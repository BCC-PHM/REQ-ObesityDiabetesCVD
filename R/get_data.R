library(fingertipsR)
library(BSol.mapR)
library(dplyr)
library(writexl)

FT_ids <- list(
  # Obesity: QOF prevalence (18+ yrs)
  "obesity" = 92588,
  # Diabetes: QOF prevalence (17+ yrs)
  "diabetes" = 241,
  # CHD: QOF prevalence (all ages)
  "CHD" = 273,
  # Hypertension: QOF prevalence (all ages)
  "hypertention" = 219
)

output <- list()

for (indicator in names(FT_ids)) {
  id <- FT_ids[[indicator]]
  
  print(id)
  
  GP_data <- fingertips_data(
    AreaTypeID = 7, 
    IndicatorID = id
  ) 
  
  ward_data <- convert_GP_data(
    GP_data, 
    GP_code_header = "AreaCode",
    value_header = "Count",
    norm_header = "Denominator"
  ) %>%
    rename(
      Percentage = `Count per 100 Denominator`
    ) %>%
    mutate(
      Indicator = unique(GP_data$IndicatorName)
    ) %>%
    select(
      c(Indicator, Ward, Count, Percentage)
    )
  
  output[[indicator]] = ward_data
}

write_xlsx(output, path = "../output/ff_disease_prev.xlsx")