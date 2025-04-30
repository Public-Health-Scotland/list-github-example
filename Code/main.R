# Main script for doing stuff in my project

# Load packages ----
source("Code/packages.R")

# Read data ----
raw_data <- read_csv(path("Data", "mtcars.csv"))

# Do analysis ----
agg_per_cyl <- raw_data |>
  group_by(cyl) |>
  summarise(across(
    c(mpg, hp, wt, gear),
    list(mean = mean, q25 = ~ quantile(., 0.25), median = median, q75 = ~ quantile(., 0.75))
  ))

# Write data ----
write_parquet(agg_per_cyl, path("Data", "aggregated_mtcars.parquet"))
