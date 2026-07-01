# data wrangling(cleaning, filtering, etc.)
library(tidyverse)
library(ratdat)

class(complete_old)
head(complete_old)
tail(complete_old)

head(complete_old, n=2)
head(complete_old, 2)
head(n = 2, x = complete_old) # if we switch the order pf the arguments, then we *have* to name them.

# Getting help with functions?
?head # the ? operator, before a function, opens the help file for that function. This works for all functions.
??ggplot2 # ?? before a package name will list all functions in that package

summary(complete_old)
str(complete_old)

# The $ operator allows us to pull out one single column from a data frame.
complete_old$year
complete_old$species

# Assignment, objects, and values
# Challenge: What is the valye of y after running the following code
x <- 5
y <- x
x <- 10
y
x

x <- 5
sqrt(x/2)

# Reading in data from outside of R
surveys <- read_csv("data/surveys_complete_77_89.csv")

# We can use the function "select" to select only a few columns
select(surveys, plot_id, species_id, hindfoot_length)
select(surveys, species_id, plot_id, hindfoot_length)
select(surveys, -record_id, -year) # select all columns from surveys except for record_id and year

select(surveys, 10)

select(surveys, where(is.numeric))
mydata_subset <- select(surveys, plot_id, species_id, hindfoot_length)

# We can use the function "filter" to choose only certain rows.
filter(surveys, year == 1985)
filter(surveys, year > 1985)

filter(surveys, species_id %in% c("RM", "DO")) #filter the "surveys" dataset to keep only the rows where the value of the 'species_id' column is found in the vector of RM and DO

filter(surveys, year <= 1988 & !is.na(hindfoot_length)) #rows of surveys where the year is less than or equal to 1988 and where hind_foot_length is not NA

filter(surveys, year != 1988) # year is NOT equal to 1988
filter(surveys, year == 1988) #  year IS equal to 1988

# Challenge: Filter to rows where the year is later than 1980 and the sex is M. Save your result to a variable called "males_1980"

filter(surveys, year > 1980, sex == "M")
males_1980 <- filter(surveys, year > 1980, sex == "M")

# Challenge 2: Filter to rows where the genus is "Neotoma" and the plot_type is either "Control" or "Long-term Krat Exclosure"
filter(surveys, genus == "Neotoma", plot_type %in% c("Control", "Long-term Krat Exclosure"))

# Challenge 3
# A. Use the surveys data to make a data frame that has only data with years from 1980 to 1985

# B. Use the surveys data to make a data frame that has only the following columns, in order: year, month, species_id, plot_id

#------------------------------------------------
# The pipe: %>%
filter(select(surveys, -day), month >=7)

surveys_noday <- select(surveys, -day)
filter(surveys_noday, month >=7)

surveys %>%
  select(-day) %>%
  filter(month >=7)
# Take the surveys dataset, AND THEN select all but the day column, AND THEN filter rows such that month is >= 7

# Challenege
# Use the surveys data to make a data frame that has the columns record_id, month, and species_id, with data from the year 1988. Use a pipe between function calls

surveys %>%
  filter(year == 1988) %>%
  select(record_id, month, species_id) 

# Grouping and summarizing data by group
# group_by()
# summarize()

surveys %>%
  group_by(sex) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE))

# We can define multiple columns in one summarize() function
# For example, I'd like to know if these different weights have anything to do with sample size

surveys %>%
  group_by(sex, species) %>%
  summarize(mean_weight = mean(weight, na.rm = TRUE),
          sample_size = n()) %>%
  arrange(desc(mean_weight))




















