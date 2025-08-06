# Generate programs.winget from CSV

## Useage

2. Create a virtual environment (if you don't have one):
   ```
   python -m venv .venv
   ```
3. Activate the virtual environment:
   ```
   .venv\Scripts\Activate.ps1
   ```
4. Install dependencies:
   ```
   pip install -r tools/generate-programs-winget/requirements.txt
   ```
5. Run the script:
   ```
   python tools/generate-programs-winget/generate-programs-winget.py
   ```

- The script will NOT overwrite an existing `Windows/Configs/programs.winget` file.
- Edit `programs.csv` to add/remove packages.
