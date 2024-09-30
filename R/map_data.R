library(BSol.mapR)
library(dplyr)
library(readxl)

data_path <- "../output/ff_disease_prev.xlsx"

sheet_names <- excel_sheets(data_path)
for (sheet in sheet_names) {
  data <- read_excel(data_path, sheet = sheet)
  map <- plot_map(
    data,
    "Percentage",
    "Ward",
    area_name = "Birmingham",
    map_title = unique(data$Indicator)
  )
  save_map(
    map,
    save_name = sprintf("../output/ward-%s-QOF.png", sheet)
      )
}


