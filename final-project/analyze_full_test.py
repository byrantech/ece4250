#!/usr/bin/env python3
"""
Analyze all distributions from full_test.tcl multiplexed output.
Generates analysis plots similar to the individual function tests.

Optimized sample counts:
- UNIFORM: 300 samples (~1.2 LFSR cycles) - shows uniformity
- SQRT: 170 samples (< 1 cycle) - natural Rayleigh-like variation
- CLT: 500 samples - better Gaussian approximation
- LOG: 170 samples (< 1 cycle) - natural exponential-like variation

For sqrt/log: Since we don't have input-output pairs, we create matching
pairs by sorting both actual outputs and expected outputs computed from
a uniform distribution over 1-255.
"""

import re
import numpy as np
import matplotlib.pyplot as plt
from scipy import stats

def parse_full_test(filename):
    """Parse full_test.tcl and extract results for each distribution."""
    distributions = {
        'uniform': [],
        'sqrt': [],
        'clt': [],
        'log': []
    }

    current_dist = None

    with open(filename, 'r') as f:
        for line in f:
            line = line.strip()

            # Check for section markers
            if '=== START UNIFORM' in line:
                current_dist = 'uniform'
            elif '=== START SQRT' in line:
                current_dist = 'sqrt'
            elif '=== START CLT' in line:
                current_dist = 'clt'
            elif '=== START LOG' in line:
                current_dist = 'log'
            elif '=== END' in line:
                current_dist = None
            elif current_dist:
                match = re.match(r'result=([01]{8})', line)
                if match:
                    distributions[current_dist].append(int(match.group(1), 2))

    return distributions


def analyze_log_distribution(log_values, output_file='log_analysis.png'):
    """
    Analyze log distribution output.
    Log computes: -ln(N/256) in Q3.5 format
    """
    # Convert raw values to Q3.5 float
    s_float = np.array([v / 32.0 for v in log_values])
    n_samples = len(s_float)

    # Generate expected outputs for uniform input distribution
    # Sample n_samples from uniform [1, 255] and compute expected log
    np.random.seed(42)  # For reproducibility
    b_simulated = np.random.randint(1, 256, n_samples)
    expected_simulated = -np.log(b_simulated / 256.0)

    # Sort both to create pseudo-pairs for comparison
    s_sorted = np.sort(s_float)
    expected_sorted = np.sort(expected_simulated)

    # Infer input from output for scatter plot
    # If s = -ln(b/256), then b = 256 * exp(-s)
    inferred_b = 256 * np.exp(-s_float)
    inferred_b = np.clip(inferred_b, 1, 255)
    expected_from_inferred = -np.log(inferred_b / 256.0)

    # Create the plot
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))

    # Plot 1: Actual vs Expected scatter (using sorted values)
    ax1 = axes[0, 0]
    ax1.scatter(expected_sorted, s_sorted, alpha=0.6, s=20, c='blue', edgecolors='none')
    min_val = 0
    max_val = max(max(expected_sorted), max(s_sorted)) + 0.5
    ax1.plot([min_val, max_val], [min_val, max_val], 'r--', linewidth=2, label='Perfect match')
    ax1.set_xlabel('Expected: -ln(N/256)', fontsize=12)
    ax1.set_ylabel('Actual: s (Q3.5)', fontsize=12)
    ax1.set_title('Actual vs Expected Log Values', fontsize=14)
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Plot 2: Error distribution
    ax2 = axes[0, 1]
    errors = s_sorted - expected_sorted
    ax2.hist(errors, bins=30, edgecolor='black', alpha=0.7, color='coral')
    ax2.axvline(x=0, color='red', linestyle='--', linewidth=2)
    ax2.set_xlabel('Error (Actual - Expected)', fontsize=12)
    ax2.set_ylabel('Frequency', fontsize=12)
    ax2.set_title(f'Error Distribution\nMean: {np.mean(errors):.4f}, Std: {np.std(errors):.4f}', fontsize=14)
    ax2.grid(True, alpha=0.3)

    # Plot 3: Output vs Input (using inferred input)
    ax3 = axes[1, 0]
    ax3.scatter(inferred_b, s_float, alpha=0.6, s=20, c='blue', label='Actual (s)', edgecolors='none')
    ax3.scatter(inferred_b, expected_from_inferred, alpha=0.6, s=20, c='red', label='Expected (-ln(N/256))', edgecolors='none')
    ax3.set_xlabel('Input b (decimal)', fontsize=12)
    ax3.set_ylabel('Output Value', fontsize=12)
    ax3.set_title('Output vs Input', fontsize=14)
    ax3.legend()
    ax3.grid(True, alpha=0.3)

    # Plot 4: Distribution comparison
    ax4 = axes[1, 1]
    bins = np.linspace(0, max(max(s_float), max(expected_simulated)) + 0.5, 31)
    ax4.hist(s_float, bins=bins, edgecolor='black', alpha=0.7, color='steelblue', label='Actual s')
    ax4.hist(expected_simulated, bins=bins, edgecolor='black', alpha=0.5, color='orange', label='Expected')
    ax4.set_xlabel('Output Value', fontsize=12)
    ax4.set_ylabel('Frequency', fontsize=12)
    ax4.set_title('Distribution of Output Values', fontsize=14)
    ax4.legend()
    ax4.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")

    # Print statistics
    print(f"\nLOG Distribution Statistics:")
    print(f"  Samples: {len(log_values)}")
    print(f"  Q3.5 Range: {min(s_float):.4f} - {max(s_float):.4f}")
    print(f"  Mean: {np.mean(s_float):.4f}, Std: {np.std(s_float):.4f}")
    print(f"  Mean Error: {np.mean(errors):.4f}, Std: {np.std(errors):.4f}")


def analyze_sqrt_distribution(sqrt_values, output_file='sqrt_analysis.png'):
    """
    Analyze sqrt distribution output.
    Sqrt computes: sqrt(-2*ln(N/256)) in Q4.4 format
    """
    # Convert raw values to Q4.4 float
    s_float = np.array([v / 16.0 for v in sqrt_values])
    n_samples = len(s_float)

    # Generate expected outputs for uniform input distribution
    np.random.seed(42)  # For reproducibility
    b_simulated = np.random.randint(1, 256, n_samples)
    expected_simulated = np.sqrt(-2 * np.log(b_simulated / 256.0))

    # Sort both to create pseudo-pairs for comparison
    s_sorted = np.sort(s_float)
    expected_sorted = np.sort(expected_simulated)

    # Infer input from output for scatter plot
    # If s = sqrt(-2*ln(b/256)), then b = 256 * exp(-s^2/2)
    inferred_b = 256 * np.exp(-s_float**2 / 2)
    inferred_b = np.clip(inferred_b, 1, 255)
    expected_from_inferred = np.sqrt(-2 * np.log(inferred_b / 256.0))

    # Create the plot
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))

    # Plot 1: Actual vs Expected scatter
    ax1 = axes[0, 0]
    ax1.scatter(expected_sorted, s_sorted, alpha=0.6, s=20, c='blue', edgecolors='none')
    min_val = 0
    max_val = max(max(expected_sorted), max(s_sorted)) + 0.2
    ax1.plot([min_val, max_val], [min_val, max_val], 'r--', linewidth=2, label='Perfect match')
    ax1.set_xlabel('Expected: sqrt(-2*ln(N/256))', fontsize=12)
    ax1.set_ylabel('Actual: s (Q4.4)', fontsize=12)
    ax1.set_title('Actual vs Expected Sqrt Values', fontsize=14)
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Plot 2: Error distribution
    ax2 = axes[0, 1]
    errors = s_sorted - expected_sorted
    ax2.hist(errors, bins=30, edgecolor='black', alpha=0.7, color='coral')
    ax2.axvline(x=0, color='red', linestyle='--', linewidth=2)
    ax2.set_xlabel('Error (Actual - Expected)', fontsize=12)
    ax2.set_ylabel('Frequency', fontsize=12)
    ax2.set_title(f'Error Distribution\nMean: {np.mean(errors):.4f}, Std: {np.std(errors):.4f}', fontsize=14)
    ax2.grid(True, alpha=0.3)

    # Plot 3: Output vs Input
    ax3 = axes[1, 0]
    ax3.scatter(inferred_b, s_float, alpha=0.6, s=20, c='blue', label='Actual (s)', edgecolors='none')
    ax3.scatter(inferred_b, expected_from_inferred, alpha=0.6, s=20, c='red', label='Expected (sqrt(-2ln(N/256)))', edgecolors='none')
    ax3.set_xlabel('Input b (decimal)', fontsize=12)
    ax3.set_ylabel('Output Value', fontsize=12)
    ax3.set_title('Output vs Input', fontsize=14)
    ax3.legend()
    ax3.grid(True, alpha=0.3)

    # Plot 4: Distribution comparison
    ax4 = axes[1, 1]
    bins = np.linspace(0, max(max(s_float), max(expected_simulated)) + 0.2, 31)
    ax4.hist(s_float, bins=bins, edgecolor='black', alpha=0.7, color='steelblue', label='Actual s')
    ax4.hist(expected_simulated, bins=bins, edgecolor='black', alpha=0.5, color='orange', label='Expected')
    ax4.set_xlabel('Output Value', fontsize=12)
    ax4.set_ylabel('Frequency', fontsize=12)
    ax4.set_title('Distribution of Output Values', fontsize=14)
    ax4.legend()
    ax4.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")

    # Print statistics
    print(f"\nSQRT Distribution Statistics:")
    print(f"  Samples: {len(sqrt_values)}")
    print(f"  Q4.4 Range: {min(s_float):.4f} - {max(s_float):.4f}")
    print(f"  Mean: {np.mean(s_float):.4f}, Std: {np.std(s_float):.4f}")
    print(f"  Mean Error: {np.mean(errors):.4f}, Std: {np.std(errors):.4f}")


def analyze_clt_distribution(clt_values, output_file='clt_analysis.png'):
    """
    Analyze CLT (Gaussian-like) distribution output.
    CLT sums multiple uniform random values to approximate Gaussian.
    """
    values = np.array(clt_values, dtype=float)

    # Fit Gaussian
    mean_val = np.mean(values)
    std_val = np.std(values)

    # Compute skewness and kurtosis
    skewness = stats.skew(values)
    kurtosis = stats.kurtosis(values)  # Excess kurtosis (0 for normal)

    # Create the plot - single panel like the reference
    fig, ax = plt.subplots(figsize=(14, 8))

    # Histogram with density normalization
    n, bins, patches = ax.hist(values, bins=50, density=True,
                                edgecolor='black', alpha=0.7, color='steelblue',
                                label='Observed Data')

    # Overlay fitted Gaussian
    x_range = np.linspace(min(values) - 10, max(values) + 10, 200)
    gaussian_pdf = stats.norm.pdf(x_range, mean_val, std_val)
    ax.plot(x_range, gaussian_pdf, 'r-', linewidth=2,
            label=f'Fitted Gaussian\nμ={mean_val:.2f}, σ={std_val:.2f}')

    # Add mean line
    ax.axvline(mean_val, color='darkred', linestyle='--', linewidth=2,
               label=f'Mean = {mean_val:.2f}')

    # Add ±1σ lines
    ax.axvline(mean_val - std_val, color='orange', linestyle=':', linewidth=2,
               label=f'±1σ = {std_val:.2f}')
    ax.axvline(mean_val + std_val, color='orange', linestyle=':', linewidth=2)

    ax.set_xlabel('Decimal Value (8-bit output)', fontsize=12)
    ax.set_ylabel('Probability Density', fontsize=12)
    ax.set_title(f'CLT Output Distribution (n={len(values)})\n'
                 f'Skew={skewness:.3f}, Kurtosis={kurtosis:.3f}',
                 fontsize=14, fontweight='bold')
    ax.legend(loc='upper right', fontsize=10)
    ax.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")

    # Print statistics
    print(f"\nCLT Distribution Statistics:")
    print(f"  Samples: {len(values)}")
    print(f"  Range: {min(values):.0f} - {max(values):.0f}")
    print(f"  Mean: {mean_val:.2f}")
    print(f"  Std Dev: {std_val:.2f}")
    print(f"  Skewness: {skewness:.4f} (0 = symmetric)")
    print(f"  Kurtosis: {kurtosis:.4f} (0 = normal)")

    # Normality test
    _, p_value = stats.normaltest(values)
    print(f"  Normality test p-value: {p_value:.4f}")


def analyze_uniform_distribution(uniform_values, output_file='uniform_analysis.png'):
    """
    Analyze uniform (LFSR) distribution output.
    Should be approximately uniform over 1-255.
    """
    values = np.array(uniform_values, dtype=float)

    # Create the plot
    fig, axes = plt.subplots(2, 2, figsize=(14, 10))

    # Plot 1: Histogram
    ax1 = axes[0, 0]
    ax1.hist(values, bins=32, edgecolor='black', alpha=0.7, color='steelblue')
    ax1.axhline(len(values)/32, color='red', linestyle='--', linewidth=2,
                label=f'Expected: {len(values)/32:.1f}')
    ax1.set_xlabel('Value (0-255)', fontsize=12)
    ax1.set_ylabel('Frequency', fontsize=12)
    ax1.set_title('Histogram of LFSR Output', fontsize=14)
    ax1.legend()
    ax1.grid(True, alpha=0.3)

    # Plot 2: Time series
    ax2 = axes[0, 1]
    ax2.plot(values[:200], 'b-', linewidth=0.8, alpha=0.7)
    ax2.scatter(range(min(200, len(values))), values[:200], s=15, c='steelblue', alpha=0.6)
    ax2.set_xlabel('Sample Index', fontsize=12)
    ax2.set_ylabel('Value', fontsize=12)
    ax2.set_title('LFSR Output Over Time (first 200)', fontsize=14)
    ax2.grid(True, alpha=0.3)

    # Plot 3: Autocorrelation
    ax3 = axes[1, 0]
    lags = range(1, 50)
    autocorr = [np.corrcoef(values[:-lag], values[lag:])[0, 1] for lag in lags]
    ax3.bar(lags, autocorr, color='steelblue', edgecolor='black', alpha=0.7)
    ax3.axhline(0, color='black', linewidth=1)
    ax3.axhline(2/np.sqrt(len(values)), color='red', linestyle='--', label='95% CI')
    ax3.axhline(-2/np.sqrt(len(values)), color='red', linestyle='--')
    ax3.set_xlabel('Lag', fontsize=12)
    ax3.set_ylabel('Autocorrelation', fontsize=12)
    ax3.set_title('Autocorrelation (should be near 0)', fontsize=14)
    ax3.legend()
    ax3.grid(True, alpha=0.3)

    # Plot 4: CDF comparison
    ax4 = axes[1, 1]
    sorted_vals = np.sort(values)
    empirical_cdf = np.arange(1, len(sorted_vals) + 1) / len(sorted_vals)
    theoretical_cdf = (sorted_vals - 1) / 254  # Uniform on [1, 255]

    ax4.plot(sorted_vals, empirical_cdf, 'b-', linewidth=2, label='Empirical CDF')
    ax4.plot(sorted_vals, theoretical_cdf, 'r--', linewidth=2, label='Theoretical Uniform')
    ax4.set_xlabel('Value', fontsize=12)
    ax4.set_ylabel('CDF', fontsize=12)
    ax4.set_title('Empirical vs Theoretical CDF', fontsize=14)
    ax4.legend()
    ax4.grid(True, alpha=0.3)

    plt.tight_layout()
    plt.savefig(output_file, dpi=150, bbox_inches='tight')
    print(f"Saved {output_file}")

    # Print statistics
    print(f"\nUNIFORM Distribution Statistics:")
    print(f"  Samples: {len(values)}")
    print(f"  Range: {min(values):.0f} - {max(values):.0f}")
    print(f"  Mean: {np.mean(values):.2f} (expected: 128)")
    print(f"  Std Dev: {np.std(values):.2f} (expected: ~73.9)")
    print(f"  Unique values: {len(set(values))}")

    # Chi-square test for uniformity
    observed, _ = np.histogram(values, bins=16, range=(0, 256))
    expected = np.full(16, len(values) / 16)
    chi2, p_value = stats.chisquare(observed, expected)
    print(f"  Chi-square uniformity test: χ²={chi2:.2f}, p={p_value:.4f}")


def main():
    import sys

    # Parse command line arguments
    input_file = sys.argv[1] if len(sys.argv) > 1 else 'full_test.tcl'

    print(f"Parsing {input_file}...")
    distributions = parse_full_test(input_file)

    total = sum(len(v) for v in distributions.values())
    print(f"Total samples: {total}")
    for name, vals in distributions.items():
        print(f"  {name}: {len(vals)} samples")

    # Generate analysis for each distribution
    print("\n" + "="*60)

    if distributions['uniform']:
        analyze_uniform_distribution(distributions['uniform'], 'uniform_analysis.png')

    if distributions['sqrt']:
        analyze_sqrt_distribution(distributions['sqrt'], 'sqrt_analysis.png')

    if distributions['clt']:
        analyze_clt_distribution(distributions['clt'], 'clt_analysis.png')

    if distributions['log']:
        analyze_log_distribution(distributions['log'], 'log_analysis.png')

    print("\n" + "="*60)
    print("All analysis complete!")


if __name__ == '__main__':
    main()
