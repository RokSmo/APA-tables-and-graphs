library(readxl)
library(flextable)
library(officer)

excel_file <- "Doživljanje.xlsx"
sheet_names <- excel_sheets(excel_file)

doc <- read_docx()

for (i in seq_along(sheet_names)) {
  df <- read_excel(excel_file, sheet = sheet_names[i])
  
  # Round numeric values
  df[] <- lapply(df, function(x) if (is.numeric(x)) round(x, 2) else x)
  
  # Create APA-style flextable
  ft <- flextable(df)
  ft <- set_table_properties(ft, layout = "autofit", width = .95)
  ft <- theme_booktabs(ft)
  ft <- fontsize(ft, size = 12)
  ft <- font(ft, fontname = "Times New Roman")
  ft <- align(ft, align = "left", part = "all")
  ft <- padding(ft, padding = 6, part = "all")
  
  # ✅ Prevent Word from wrapping numbers weirdly
  ft <- autofit(ft)
  ft <- width(ft, width = 1.2)  # set all column widths wider
  ft <- line_spacing(ft, space = 1.2)
  
  # ✅ Wrap header text if too long, but NOT data cells
  # ✅ Optional: wrap header names by replacing "_" with line breaks
  header_labels <- setNames(gsub("_", "\n", names(df)), names(df))
  ft <- do.call(set_header_labels, c(list(ft), as.list(header_labels)))
  
  # Add to document
  doc <- body_add_flextable(doc, ft)
  if (i < length(sheet_names)) {
    doc <- body_add_break(doc)
  }
}

print(doc, target = "apa_tables.docx")
cat("✅ APA tables saved to 'apa_tables.docx'\n")

