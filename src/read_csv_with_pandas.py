from pathlib import Path
import pandas as pd

# 1. generer data to csv
df = pd.DataFrame({
    "name": ["Alice", "Bob", "Charlie"],
    "age":  [25, 30, 35]
})

# 2. find path of projet 
project_root = Path(__file__).resolve().parents[1]   # read_csv_with_pandas.py 的上一級
csv_path = project_root / "data" / "test_data.csv"

# 2-1. if data dosn't exist creer it
csv_path.parent.mkdir(parents=True, exist_ok=True)

# 3. write csv
df.to_csv(csv_path, index=False, encoding="utf-8")
print(f"CSV saved to: {csv_path}")

# 4. read csv
with open(csv_path, encoding="utf-8") as f:
    print("\n--- Raw CSV text ---")
    print(f.read())

df_read = pd.read_csv(csv_path, encoding="utf-8")
print("\n--- DataFrame ---")
print(df_read)
