# Main script for doing stuff in my project

# Load packages ----
source("Code/packages.R")

# Set file path
data_dir <- path("/conf/LIST_analytics/Shetland/git-training-project/Data/")

# Read data ----
raw_data <- read_csv(path(data_dir, "mtcars.csv"))

# Do analysis ----
agg_per_cyl <- raw_data |>
  group_by(cyl) |>
  summarise(across(
    c(mpg, hp, wt, gear),
    list(mean = mean, q25 = ~ quantile(., 0.25), median = median, q75 = ~ quantile(., 0.75))
  ))

# Write data ----
write_parquet(agg_per_cyl, path(data_dir, "aggregated_mtcars.parquet"))
