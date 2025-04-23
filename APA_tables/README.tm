# APA Table Export from Excel in R

This repository provides an R script to **convert Excel tables into APA-styled tables** in a Word document.  
It is designed for researchers, students, or anyone who wants to format multiple tables for publication — with minimal effort.

---

## ✅ What This Script Does

- 📅 **Reads** all sheets from a single Excel file (each sheet is treated as one table).
- 🧹 **Cleans and formats** the tables according to APA 7th edition style:
  - Times New Roman, 12 pt
  - No vertical lines
  - Top and bottom borders only
  - Left-aligned text, padded spacing
  - Rounded numeric values (2 decimals)
- 📄 **Outputs a Word document** (`apa_tables.docx`) with each table on its own page.

---

## 📦 Requirements

Before running the script, install the required R packages:

```r
install.packages("readxl")
install.packages("flextable")
install.packages("officer")
```

---

## 📁 Files and Structure

```
apa-tables-export/
├── your_table.xlsx            # Your input file (one sheet per table)
├── excel_to_apa_tables.R      # The main R script
├── apa_tables.docx            # Output Word document (auto-generated)
├── README.md                  # This file
└── .gitignore                 # Ignores output and cache files
```

---

## 🚀 How to Use

1. **Prepare your Excel file**:
   - Place each table on its **own sheet**.
   - Give sheets meaningful names if desired (not required).

2. **Edit the R script** (if needed):
   - Make sure the file path to `your_table.xlsx` is correct.

3. **Run the script** in R or RStudio:

```r
source("excel_to_apa_tables.R")
```

4. **Check the output**:
   - Look for `apa_tables.docx` in your working directory.
   - Open in Word. Each table will be on a separate page, styled for APA.

---

## ✍️ Customization Tips

- To change font size or padding, modify:
  ```r
  fontsize(ft, size = 12)
  padding(ft, padding = 6)
  ```

- If columns wrap too tightly, adjust:
  ```r
  width(ft, width = 1.2)  # Wider columns
  ```

- If you want captions, let us know! It's easy to add from sheet names or a list.

---

## 📊 Output Example

| Variable   | M    | SD   |
|------------|------|------|
| Stress     | 14.2 | 3.21 |
| Happiness  | 18.7 | 2.90 |

---

## 🛠️ License

This project is open-source and free to use. Customize it to your workflow.

---


