import os
import numpy as np
from scipy import stats
import matplotlib.pyplot as plt

# Define the filename
filename = "clt_out.tcl"
nums = []

# Check if the file exists before trying to open it
if not os.path.exists(filename):
    print(f"Error: The file '{filename}' was not found in the current directory.")
else:
    try:
        with open(filename, 'r') as file:
            print(f"--- Parsing '{filename}' ---")
            for line in file:
                if line.startswith("| o="):
                    nums.append(line.split("=")[1].strip())
            print(f"--- Found {len(nums)} values ---\n")

    except Exception as e:
        print(f"An error occurred while reading the file: {e}")

# Decode 8-bit binary to decimal
nums_dec = []
for num in nums:
    nums_dec.append(int(num, 2))

data = np.array(nums_dec)

# Calculate Gaussian (Normal) distribution properties
n = len(data)
mean = np.mean(data)
std = np.std(data, ddof=1)  # Sample standard deviation
variance = np.var(data, ddof=1)
median = np.median(data)
skewness = stats.skew(data)
kurtosis = stats.kurtosis(data)  # Excess kurtosis (normal = 0)

# Normality tests
shapiro_stat, shapiro_p = stats.shapiro(data[:5000]) if n > 5000 else stats.shapiro(data)
ks_stat, ks_p = stats.kstest(data, 'norm', args=(mean, std))
dagostino_stat, dagostino_p = stats.normaltest(data)

# Print Gaussian property values
print("=" * 50)
print("GAUSSIAN DISTRIBUTION PROPERTIES")
print("=" * 50)
print(f"Sample size (n):        {n}")
print(f"Mean (μ):               {mean:.4f}")
print(f"Standard Deviation (σ): {std:.4f}")
print(f"Variance (σ²):          {variance:.4f}")
print(f"Median:                 {median:.4f}")
print(f"Min:                    {min(data)}")
print(f"Max:                    {max(data)}")
print()

# CLT Theoretical Analysis
print("=" * 50)
print("CLT THEORETICAL ANALYSIS")
print("=" * 50)
print("Your circuit sums 5 LFSRs using 5-bit and 6-bit adders.")
print()
# Most likely configuration based on observed mean ~109:
# 3 LFSRs contribute 5-bit values (mean 15.5 each)
# 2 LFSRs contribute 6-bit values (mean 31.5 each)
theory_mean = 3 * 15.5 + 2 * 31.5  # = 46.5 + 63 = 109.5
var_5bit = (32**2 - 1) / 12  # variance for U[0,31]
var_6bit = (64**2 - 1) / 12  # variance for U[0,63]
theory_var = 3 * var_5bit + 2 * var_6bit
theory_std = np.sqrt(theory_var)

print("Likely configuration: 3×5-bit + 2×6-bit LFSR outputs")
print(f"  Theoretical Mean:  {theory_mean:.2f} (3×15.5 + 2×31.5)")
print(f"  Observed Mean:     {mean:.2f}")
print(f"  Difference:        {abs(mean - theory_mean):.2f}")
print()
print(f"  Theoretical Std:   {theory_std:.2f}")
print(f"  Observed Std:      {std:.2f}")
print(f"  Difference:        {abs(std - theory_std):.2f}")
print()

# Alternative: all 5 LFSRs use 5-bit + offset
alt_theory_mean = 5 * 15.5  # = 77.5
print("Alternative: If all 5 LFSRs contributed 5-bits [0-31]:")
print(f"  Would give mean:   {alt_theory_mean:.2f}")
print(f"  Observed mean:     {mean:.2f}")
print(f"  Difference:        {mean - alt_theory_mean:.2f} (offset in circuit?)")
print()

# For uniform [0,255] on a single 8-bit value, mean would be 127.5
print("NOTE: For uniform 8-bit values [0-255], mean = 127.5")
print(f"Your observed mean ({mean:.1f}) indicates NOT using full 8-bit uniform inputs!")
print()

print("--- Shape Statistics ---")
print(f"Skewness:               {skewness:.4f}  (Normal ≈ 0)")
print(f"Excess Kurtosis:        {kurtosis:.4f}  (Normal = 0)")
print()
print("--- Normality Tests ---")
print(f"Shapiro-Wilk:           stat={shapiro_stat:.4f}, p={shapiro_p:.4e}")
print(f"Kolmogorov-Smirnov:     stat={ks_stat:.4f}, p={ks_p:.4e}")
print(f"D'Agostino-Pearson:     stat={dagostino_stat:.4f}, p={dagostino_p:.4e}")
print()
if shapiro_p > 0.05:
    print("✓ Shapiro-Wilk: Data appears normally distributed (p > 0.05)")
else:
    print("✗ Shapiro-Wilk: Data deviates from normal distribution (p ≤ 0.05)")
print()
print("--- Theoretical vs Observed ---")
print(f"68% of data within μ±1σ: [{mean-std:.2f}, {mean+std:.2f}]")
within_1std = np.sum((data >= mean - std) & (data <= mean + std)) / n * 100
print(f"   Observed: {within_1std:.2f}% (Expected: 68.27%)")
print(f"95% of data within μ±2σ: [{mean-2*std:.2f}, {mean+2*std:.2f}]")
within_2std = np.sum((data >= mean - 2*std) & (data <= mean + 2*std)) / n * 100
print(f"   Observed: {within_2std:.2f}% (Expected: 95.45%)")
print(f"99.7% of data within μ±3σ: [{mean-3*std:.2f}, {mean+3*std:.2f}]")
within_3std = np.sum((data >= mean - 3*std) & (data <= mean + 3*std)) / n * 100
print(f"   Observed: {within_3std:.2f}% (Expected: 99.73%)")
print("=" * 50)

# Create histogram with Gaussian overlay
fig, ax = plt.subplots(figsize=(10, 6))

# Plot histogram (density normalized for comparison with PDF)
counts, bins, patches = ax.hist(data, bins=64, density=True, alpha=0.7,
                                 color='steelblue', edgecolor='black', label='Observed Data')

# Overlay fitted Gaussian curve
x = np.linspace(min(data), max(data), 200)
gaussian_pdf = stats.norm.pdf(x, mean, std)
ax.plot(x, gaussian_pdf, 'r-', linewidth=2, label=f'Fitted Gaussian\nμ={mean:.2f}, σ={std:.2f}')

# Add vertical lines for mean and std deviations
ax.axvline(mean, color='darkred', linestyle='--', linewidth=1.5, label=f'Mean = {mean:.2f}')
ax.axvline(mean - std, color='orange', linestyle=':', linewidth=1.5, alpha=0.8)
ax.axvline(mean + std, color='orange', linestyle=':', linewidth=1.5, alpha=0.8, label=f'±1σ = {std:.2f}')

ax.set_xlabel("Decimal Value (8-bit output)", fontsize=12)
ax.set_ylabel("Probability Density", fontsize=12)
ax.set_title(f"CLT Output Distribution (n={n})\nSkew={skewness:.3f}, Kurtosis={kurtosis:.3f}", fontsize=14)
ax.legend(loc='upper right')
ax.grid(True, alpha=0.3)

plt.tight_layout()
plt.savefig('gaussian_analysis.png', dpi=150)
plt.show()

print(f"\nPlot saved to 'gaussian_analysis.png'")
