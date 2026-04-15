import numpy as np
import matplotlib.pyplot as plt

# --- The Hardware Model ---
def get_hardware_details(x_int):
    """
    Returns the internal hardware signals for a given input.
    Returns: (region_name, constant, shift_amount, shifted_val, result_int)
    """
    if x_int == 0:
        # Special case handling as per logic
        # "Clamp 0... 54 - 0"
        return "Zero", 54, 0, 0, 54

    # 1. Region Detection
    is_high = (x_int >= 64)       # Bit 7 or 6 is 1
    is_mid  = (x_int >= 16) and not is_high # Bit 5 or 4 is 1

    # 2. Mux Selection
    if is_high:
        region = "High"
        constant = 35  # 0x23
        shift_amt = 3
        shifted_val = x_int >> 3
    elif is_mid:
        region = "Mid"
        constant = 43  # 0x2B
        shift_amt = 2
        shifted_val = x_int >> 2
    else:
        region = "Low"
        constant = 54  # 0x36
        shift_amt = 0
        shifted_val = x_int

    # 3. Subtraction
    result_int = max(0, constant - shifted_val)

    return region, constant, shift_amt, shifted_val, result_int

def hardware_box_muller(x_int):
    """
    Simulates the 8-bit hardware logic for sqrt(-2ln(x/256))
    Input: Integer 0-255
    Output: Float (converted from Fixed Point Q4.4)
    """
    _, _, _, _, result_int = get_hardware_details(x_int)
    # Convert Q4.4 back to float for graphing
    return result_int / 16.0

# --- Table Generation ---
def print_conversion_tables():
    print(f"{'='*110}")
    print(f"HARDWARE CONVERSION LOGIC SUMMARY")
    print(f"{'='*110}")
    print(f"| Region | Input Range | Logic (Q4.4 fixed point operations)")
    print(f"|--------|-------------|------------------------------------")
    print(f"| Low    | 0 - 15      | 54 - (x >> 0)")
    print(f"| Mid    | 16 - 63     | 43 - (x >> 2)")
    print(f"| High   | 64 - 255    | 35 - (x >> 3)")
    print(f"{'='*110}\n")

    print(f"{'='*110}")
    print(f"FULL LOOKUP TABLE (0-255)")
    print(f"{'='*110}")
    # Headers
    print(f"| {'In (Dec)':^8} | {'In (Bin)':^8} | {'Region':^6} | {'Const':^5} | {'Shifted':^7} | {'Result':^6} | {'Out (Bin)':^9} | {'Out (Float)':^11} |")
    print(f"|{'-'*10}|{'-'*10}|{'-'*8}|{'-'*7}|{'-'*9}|{'-'*8}|{'-'*11}|{'-'*13}|")

    for x in range(256):
        region, const, shift, shifted, res = get_hardware_details(x)

        # Format binary strings
        in_bin = f"{x:08b}"
        out_bin = f"{res:08b}"
        out_float = res / 16.0

        print(f"| {x:8d} | {in_bin} | {region:6s} | {const:5d} | {shifted:7d} | {res:6d} | {out_bin} | {out_float:11.4f} |")

# --- The Real Math ---
def real_box_muller(x_int):
    if x_int == 0: return None # Asymptote
    u = x_int / 256.0
    return np.sqrt(-2 * np.log(u))

# --- Main Execution ---
if __name__ == "__main__":
    # 1. Print the Tables
    print_conversion_tables()

    # 2. Generate Plots
    x_vals = np.arange(1, 256) # 1 to 255
    y_real = [real_box_muller(x) for x in x_vals]
    y_hw   = [hardware_box_muller(x) for x in x_vals]
    error  = [h - r for h, r in zip(y_hw, y_real)]

    # --- Plotting ---
    fig, (ax1, ax2) = plt.subplots(2, 1, figsize=(10, 8), sharex=True)

    # Graph 1: Overlay
    ax1.set_title('Hardware Approx of $\sqrt{-2\ln(x/256)}$ (Q4.4 Output)')
    ax1.plot(x_vals, y_real, 'k-', label='Real Math', linewidth=2, alpha=0.6)
    ax1.plot(x_vals, y_hw, 'r-', label='Hardware (Shift/Sub)', linewidth=2)
    ax1.grid(True, which='both', linestyle='--', alpha=0.7)
    ax1.legend()
    ax1.set_ylabel('Output (Fixed Point 4.4)')

    # Graph 2: Error
    ax2.set_title('Approximation Error')
    ax2.plot(x_vals, error, 'b-', label='Error')
    ax2.axhline(0, color='k', linewidth=1)
    # Target tolerance zone
    ax2.axhline(0.15, color='r', linestyle=':', label='Tolerance (+/- 0.15)')
    ax2.axhline(-0.15, color='r', linestyle=':')
    ax2.grid(True, which='both', linestyle='--', alpha=0.7)
    ax2.set_ylabel('Error magnitude')
    ax2.set_xlabel('Input Integer (0-255)')
    ax2.legend()

    plt.tight_layout()
    plt.show()
