# My first script in this project
library(ggplot2)
library(ratdat)

ggplot(complete_old, aes(x = hindfoot_length, y = weight))+
  geom_point()

# Make a comment 
ggplot(complete_old, aes(x = hindfoot_length, y = weight))+
  geom_point()

# Change 7/1/2026
str(complete_old)
ggplot (complete_old, aes(x = year, y = hindfoot_length, color = species))+
  geom_point()
