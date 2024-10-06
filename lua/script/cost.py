import re
import sys


def process_table(table):
    lines = table.strip().split("\n")
    total_pattern = re.compile(r"\*\*Total\*\*")
    updated_lines = []
    weekly_sums = [0, 0, 0, 0]  # To store sums for Week 1, Week 2, Week 3, Week 4

    for line in lines:
        if total_pattern.search(line):
            # Skip the existing total line
            continue

        if "Day" in line or "Week" in line:
            # Keep header and week labels unchanged
            updated_lines.append(line)
            continue

        # Extract the values from the table row
        parts = re.split(r"\s+\|\s+", line.strip("| "))
        row_values = []

        for i, value in enumerate(parts[1:]):  # Skip day name
            try:
                # Check if the value contains additions like 18.07+26.98+20.44
                if "+" in value:
                    value = sum(map(float, value.split("+")))
                else:
                    value = float(value) if value != "0" else 0
                # Append value rounded to 2 decimal places
                row_values.append(f"{value:.2f}")
                # Add to the respective week's sum
                weekly_sums[i] += value
            except ValueError:
                # If we encounter a non-numeric value, append it as-is
                row_values.append(value)

        updated_lines.append(f"| {parts[0]:<9} | {' | '.join(row_values)} |")

    # Append the updated total line with 2 decimal points for each week
    updated_lines.append(
        f"| **Total**  | **${weekly_sums[0]:.2f}** | **${weekly_sums[1]:.2f}** | **${weekly_sums[2]:.2f}** | **${weekly_sums[3]:.2f}** |"
    )

    return "\n".join(updated_lines)


def main():
    # Read input (via stdin)
    input_table = sys.stdin.read()
    # Process the table and print the updated table
    updated_table = process_table(input_table)
    print(updated_table)


if __name__ == "__main__":
    main()
