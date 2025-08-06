import csv
import os
from jinja2 import Environment, FileSystemLoader

import sys

base_dir = os.path.dirname(os.path.abspath(__file__))
csv_path = os.path.join(base_dir, "programs.csv")
template_path = os.path.join(base_dir, "programs.winget.j2")
output_path = os.path.abspath(
    os.path.join(base_dir, "../../Windows/Configs/programs.winget")
)

force = False
for arg in sys.argv[1:]:
    if arg in ("-f", "--force"):
        force = True

if os.path.exists(output_path) and not force:
    print(f"File already exists: {output_path}. Generation skipped.")
    exit(0)

with open(csv_path, newline="", encoding="utf-8") as csvfile:
    reader = csv.DictReader(csvfile)
    packages = []
    npm_packages = []
    for row in reader:
        if row.get("tag", "").strip().lower() == "npm":
            npm_packages.append(row)
        else:
            packages.append(row)

env = Environment(loader=FileSystemLoader(base_dir))
template = env.get_template("programs.winget.j2")
output = template.render(packages=packages, npm_packages=npm_packages)

with open(output_path, "w", encoding="utf-8") as f:
    f.write(output)

print(f"Generated: {output_path}")
