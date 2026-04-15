import math
import numpy as np
import matplotlib.pyplot as plt
from typing import Dict, List, Tuple

# --- Configuration ---
# K=3 for mantissa index.
MANTISSA_BITS = 3
MANTISSA_SIZE = 2**MANTISSA_BITS # 8 entries for fractional LUT V_I
EXPONENT_SIZE = 8 # 8 entries for exponent LUT V_E
TOTAL_LUT_SIZE = EXPONENT_SIZE * MANTISSA_SIZE # 64 address combinations

N_MAX = 256
LN2 = math.log(2)

# --- Fixed-Point Configuration (Q3.5 - 8 bits total) ---
FIXED_POINT_FRAC_BITS = 5
FIXED_POINT_SCALE = 2**FIXED_POINT_FRAC_BITS # 32

def quantize_value(value: float) -> int:
    """Converts a float value to the nearest Q3.5 fixed-point integer, clamping to 8 bits."""
    if value < 0:
        return 0
    return min(int(round(value * FIXED_POINT_SCALE)), 255)

def calculate_subtractive_luts() -> Tuple[Dict[int, int], Dict[int, int]]:
    """
    Calculates LUTs V_E and V_I based on the subtractive identity:
    X = V_E[E] - V_I[I]
    Where V_E = (8 - E) * ln(2) and V_I = ln(M). Both are guaranteed >= 0.
    """
    V_E_lut = {}
    V_I_lut = {}

    # --- 1. Calculate Exponent LUT (V_E) ---
    print(f"\n--- EXPONENT LUT (V_E[E]): (8 - E) * ln(2) (Q3.5) ---")
    print(f"| E | Float Value | Q3.5 Value (Dec) |")
    print(f"|---|-------------|------------------|")
    for E in range(EXPONENT_SIZE):
        value = (8.0 - E) * LN2
        fixed_value = quantize_value(value)
        V_E_lut[E] = fixed_value
        print(f"| {E} | {value:.6f} | {fixed_value:5d} | {fixed_value:08b}")

    # --- 2. Calculate Mantissa LUT (V_I) ---
    print(f"\n--- MANTISSA LUT (V_I[I]): ln(1 + I/8) (Q3.5) ---")
    print(f"| I | Mantissa | Float Value | Q3.5 Value (Dec) |")
    print(f"|---|----------|-------------|------------------|")
    for I in range(MANTISSA_SIZE):
        M_I = 1.0 + (I / MANTISSA_SIZE)
        value = math.log(M_I)
        fixed_value = quantize_value(value)
        V_I_lut[I] = fixed_value
        print(f"| {I} | {M_I:.6f} | {value:.6f} | {fixed_value:5d} | {fixed_value:08b}")

    return V_E_lut, V_I_lut

def analyze_ln_approximation(V_E_lut: Dict[int, int], V_I_lut: Dict[int, int]) -> List[Tuple[int, float, float, float]]:
    """
    Analyzes the error for all 8-bit inputs (N=1 to 255) using V_E - V_I subtraction.
    """
    results = []

    for N in range(1, 256):
        # --- 1. Address Generation (Hardware Logic) ---
        E = N.bit_length() - 1

        if E < MANTISSA_BITS:
            fractional_bits_raw = N & (2**E - 1)
            I = fractional_bits_raw << (MANTISSA_BITS - E) if E > 0 else 0
        else:
            I = (N & (2**E - 1)) >> (E - MANTISSA_BITS)

        I = min(I, MANTISSA_SIZE - 1)

        # --- 2. Hardware Calculation: V_E - V_I (8-bit subtraction) ---
        raw_diff = V_E_lut.get(E, 0) - V_I_lut.get(I, 0)

        # Clamp the result (should always be positive for N >= 1)
        fixed_approx_X = max(raw_diff, 0)

        # Convert back to float for analysis
        approx_X = fixed_approx_X / FIXED_POINT_SCALE

        # --- 3. Actual Value Calculation ---
        R_float = N / N_MAX
        actual_X = -math.log(R_float)
        absolute_error = abs(actual_X - approx_X)

        results.append((N, actual_X, approx_X, absolute_error))
    return results

def print_full_binary_table(V_E_lut: Dict[int, int], V_I_lut: Dict[int, int]):
    """Prints the full input-output mapping table in binary for all 256 inputs."""
    print("\n" + "="*80)
    print("COMPLETE 8-BIT INPUT/OUTPUT MAPPING TABLE (Binary)")
    print("="*80)
    print(f"| N (Dec) | N (Binary) | E | I | V_E-V_I (Dec) | Output (Binary) | Actual -ln(N/256) |")
    print(f"|---------|------------|---|---|---------------|-----------------|-------------------|")

    for N in range(1, 256):
        # Address generation
        E = N.bit_length() - 1

        if E < MANTISSA_BITS:
            fractional_bits_raw = N & (2**E - 1)
            I = fractional_bits_raw << (MANTISSA_BITS - E) if E > 0 else 0
        else:
            I = (N & (2**E - 1)) >> (E - MANTISSA_BITS)

        I = min(I, MANTISSA_SIZE - 1)

        # Hardware calculation
        raw_diff = V_E_lut.get(E, 0) - V_I_lut.get(I, 0)
        fixed_output = max(raw_diff, 0)

        # Actual value
        R_float = N / N_MAX
        actual_X = -math.log(R_float)

        # Format binary strings
        N_binary = f"{N:08b}"
        output_binary = f"{fixed_output:08b}"

        print(f"| {N:7d} | {N_binary} | {E} | {I} | {fixed_output:13d} | {output_binary} | {actual_X:17.6f} |")

    print("="*80)

def print_summary(results: List[Tuple[int, float, float, float]]):
    """Prints the error statistics."""
    errors = [e[3] for e in results]
    max_error = np.max(errors)
    mean_error = np.mean(errors)
    rms_error = np.sqrt(np.mean(np.square(errors)))

    print("\n--- Subtractive Log Identity Error Summary for X = -ln(N/256) ---")
    print(f"Fixed-Point Format: Q3.5 (8 bits total)")
    print(f"Architecture: V_E - V_I (Both LUTs use positive values)")
    print("-" * 50)
    print(f"Maximum Absolute Error (Float): {max_error:.6f}")
    print(f"Mean Absolute Error (Float):    {mean_error:.6f}")
    print(f"RMS Error (Float):              {rms_error:.6f}")
    print("-" * 50)

    max_error_entry = max(results, key=lambda x: x[3])
    N_max, actual_max, approx_max, error_max = max_error_entry
    R_float = N_max / N_MAX
    print(f"Max error occurs at N={N_max} (R={R_float:.4f}):")
    print(f"Actual X = {actual_max:.6f}, Approx X = {approx_max:.6f}")

def plot_error(results: List[Tuple[int, float, float, float]]):
    """Generates a plot of the approximation vs. actual value and the absolute error."""
    N_values = [r[0] for r in results]
    actual = [r[1] for r in results]
    approx = [r[2] for r in results]
    abs_error = [r[3] for r in results]

    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), sharex=True)
    fig.suptitle('8-bit Negative Natural Log Approximation (Subtractive Identity, Q3.5)')

    # Top plot: Comparison
    ax1.plot(N_values, actual, label='Actual $-\ln(N/256)$', color='blue')
    ax1.scatter(N_values, approx, label='Approximated Value (64 Levels)', color='red', marker='.', s=10)
    ax1.set_ylabel('X Value ($-\ln(R)$)')
    ax1.set_title('Approximation vs. Actual Value')
    ax1.grid(True, linestyle='--')
    ax1.legend()

    # Bottom plot: Error
    ax2.plot(N_values, abs_error, label='Absolute Error', color='green')
    ax2.axhline(np.max(abs_error), color='orange', linestyle='--', label=f'Max Error: {np.max(abs_error):.4f}')
    ax2.set_xlabel('Input Value N (8-bit, 1 to 255)')
    ax2.set_ylabel('Absolute Error')
    ax2.set_title('Absolute Error |Actual - Approx|')
    ax2.grid(True, linestyle='--')
    ax2.legend()

    plt.tight_layout(rect=[0, 0.03, 1, 0.95])
    plt.show()

# --- Main Execution ---
if __name__ == '__main__':
    # 1. Calculate the two independent 8-entry LUTs (V_E and V_I)
    V_E_lut, V_I_lut = calculate_subtractive_luts()

    # 2. Print full binary mapping table
    print_full_binary_table(V_E_lut, V_I_lut)

    # 3. Analyze Approximation Error
    error_results = analyze_ln_approximation(V_E_lut, V_I_lut)

    # 4. Print Summary
    print_summary(error_results)

    # 5. Generate Plot
    plot_error(error_results)