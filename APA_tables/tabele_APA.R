# ---------------------------------------
# 📚 Load necessary libraries
# ---------------------------------------
library(readxl)     # To read Excel files
library(writexl)    # To write Excel files (we'll create one first!)
library(flextable)  # To create nice Word tables
library(officer)    # To create/edit Word documents

# ---------------------------------------
# 🛠 Step 1: Create a small Excel file automatically
# ---------------------------------------

# Create example dataframes
df1 <- data.frame(
  Name = c("Alice", "Bob", "Charlie"),
  Score = c(85.235, 92.895, 77.5),
  Passed = c(TRUE, TRUE, FALSE)
)

df2 <- data.frame(
  Item = c("Item_One", "Item_Two", "Item_Three"),
  Value = c(12.456, 45.789, 23.123)
)

# Save them into an Excel file with two sheets
example_excel <- "example_data.xlsx"
write_xlsx(list(Sheet1 = df1, Sheet2 = df2), path = example_excel)

# 📢 Inform that example file was created
cat("✅ Example Excel file 'example_data.xlsx' created!\n")

# ---------------------------------------
# 📚 Step 2: Read the Excel file and prepare the Word document
# ---------------------------------------

# Set the path to the Excel file (now created above)
excel_file <- example_excel

# Get all sheet names from the Excel file
sheet_names <- excel_sheets(excel_file)

# Create a new, empty Word document
doc <- read_docx()

# ---------------------------------------
# 🔁 Step 3: Loop through each sheet and add nicely formatted tables to Word
# ---------------------------------------

for (i in seq_along(sheet_names)) {
  
  # Read current sheet into a dataframe
  df <- read_excel(excel_file, sheet = sheet_names[i])
  
  # Round all numeric columns to 2 decimal places
  df[] <- lapply(df, function(x) if (is.numeric(x)) round(x, 2) else x)
  
  # Create a flextable from the dataframe
  ft <- flextable(df)
  
  # Set table properties:
  ft <- set_table_properties(ft, layout = "autofit", width = .95)  # Autofit layout, 95% of page width
  ft <- theme_booktabs(ft)                                         # Apply APA-style booktabs theme
  ft <- fontsize(ft, size = 12)                                     # Set font size to 12
  ft <- font(ft, fontname = "Times New Roman")                      # Set font to Times New Roman
  ft <- align(ft, align = "left", part = "all")                     # Left-align all cells
  ft <- padding(ft, padding = 6, part = "all")                      # Add padding for better readability
  
  # Adjust column width and spacing
  ft <- autofit(ft)                       # Let flextable adjust sizes
  ft <- width(ft, width = 1.2)             # Widen all columns to 1.2 inches
  ft <- line_spacing(ft, space = 1.2)      # Set line spacing to 1.2
  
  # ---------------------------------------
  # 🛠 Handle header formatting (optional enhancement)
  # ---------------------------------------
  
  # Replace underscores "_" in header names with line breaks "\n" for better header readability
  header_labels <- setNames(gsub("_", "\n", names(df)), names(df))
  
  # Apply new header labels
  ft <- do.call(set_header_labels, c(list(ft), as.list(header_labels)))
  
  # ---------------------------------------
  # ➕ Add table to Word document
  # ---------------------------------------
  
  doc <- body_add_flextable(doc, ft)
  
  # If this is not the last table, add a page break
  if (i < length(sheet_names)) {
    doc <- body_add_break(doc)
  }
}

# ---------------------------------------
# 💾 Step 4: Save the Word document
# ---------------------------------------

# Save the final Word document
output_file <- "apa_tables.docx"
print(doc, target = output_file)

# 📢 Confirm that everything worked
cat(paste0("✅ APA tables saved to '", output_file, "'\n"))

