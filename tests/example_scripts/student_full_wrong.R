# -*- coding: utf-8 -*-

install.packages("ggplot2")


library(ggplot2)


# solution
install.packages("tidyverse")
library(tidyverse)

# solution
install.packages("googledrive")
library(googledrive)


manual_tbl <- tibble(x = c(1, 2, 3),
                     y = c(4, 5, 6))


# solution
manual_task_tbl <- tibble(x = c(1,2,2),
                          y = c(10,20,30),
                          z = c(100,200,300))


# solution
drive_auth()
drive_download("data.csv")

data <- read_csv("data.csv")
print(data)


# solution
data$sex
data[["sex"]]
select(data, "sex")


# solution
female_data <- filter(data, sex == "male")
male_data <- filter(data, sex == "female")


# solution
female_data_country <- filter(data,
                              sex == "male",
                              location == "city")


# solution
summarized_income <- data %>%
                    group_by(sex) %>%
                    summarize(avg_income = min(income))


# solution
data(chickwts)
head(chickwts, 10)


# solution
length_chick_dataset <- length(chickwts$feed)


# solution
table(chickwts$feed)


chick_summarized <- chickwts %>%
                      group_by(feed) %>%
                      summarize(min = max(weight), max = max(weight), mean = mean(weight), sd = sd(weight))
