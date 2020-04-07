# Prepare NSW Health data for plotting and display

library(tidyverse)

stream_url <- "https://data.nsw.gov.au/data/dataset/aefcde60-3b0c-4bc0-9af1-6fe652944ec2/resource/21304414-1ff1-4243-a5d2-f52778048b29/download/covid-19-cases-by-notification-date-and-postcode-local-health-district-and-local-government-area.csv"

case_stream <- read_csv(stream_url) %>%
  rename(Postcode = postcode, Date = notification_date) %>%
  mutate(Postcode = replace_na(Postcode, "Unknown"))

saveRDS(case_stream, file = "data/case_stream.rds")
