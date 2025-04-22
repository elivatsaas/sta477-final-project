library(readxl)
library(dplyr)

transit <- read_xlsx("RawMonthly Ridership.xlsx", sheet = 3) %>%
  mutate(across(where(is.character), as.factor))



transit.tidy <- transit %>%
  pivot_longer(
    cols = 11:287,
    names_to = "months",
    values_to = "UPT")



transit <- transit %>%
  rename(
    passenger_miles = `Passenger Miles FY`,
    last_closed_year = `Last Closed Report Year`
  )


transit.tidy <- transit.tidy %>%
  rename(
    mode.3 = `3 Mode`,
    id = `NTD ID`
  )

# Now use simplified names
ggplot(transit.tidy %>% filter(!is.na(UPT), as.numeric(id) == 00001), aes(x = months, y = log(UPT))) +
  geom_point()
