here::i_am("code/03_make_android_gynoid_graph.R")


#android and gynoid percent fat change.
# we are strating with android fat percentage
afx <- dxareport %>%
  drop_na(bl_android_percent_fat,
          x6mo_android_percent_fat,
          x12mo_android_percent_fat)%>% 
  summarise(Baseline_Android = mean(bl_android_percent_fat),
            `6 Month Android` = mean(x6mo_android_percent_fat),
            `12 Month Android` = mean(x12mo_android_percent_fat)) %>%
  pivot_longer(cols = contains('android'),
               names_to = "month",
               values_to = "mean_android_percent_fat") %>%
  mutate(month = case_when(
    month == "Baseline_Android" ~ "Baseline",
    month == "6 Month Android" ~ "6 Month",
    month == "12 Month Android" ~ "12 Month",
  )) 
#gynoid percent fat change

gfx <- dxareport %>%
  drop_na(bl_gynoid_percent_fat, 
          x6mo_gynoid_percent_fat,
          x12mo_gynoid_percent_fat) %>% 
  summarise(`Baseline Gynoid` = mean(bl_gynoid_percent_fat),
            `6 Month Gynoid` = mean(x6mo_gynoid_percent_fat),
            `12 Month Gynoid` = mean(x12mo_gynoid_percent_fat)) %>%
  pivot_longer(cols = contains('gynoid'),
               names_to = "month_g", 
               values_to = "mean_gynoid_percent_fat") %>%
  mutate(month = case_when(
    month_g == "Baseline Gynoid" ~ "Baseline",
    month_g == "6 Month Gynoid" ~ "6 Month",
    month_g == "12 Month Gynoid" ~ "12 Month"
  )) 

#merge gynoid and android for data visualization purposes

agfx <- merge(afx,gfx, by = "month", all= TRUE)

# Reordering the levels of month, as this is an ordinal variable.
agfx$month<- factor(agfx$month, levels = c("Baseline", "6 Month", "12 Month"))

# Plotting the mean central obesity mass across time points as a line graph
android_gynoid_graph <- ggplot(agfx, aes(x = month)) +
  geom_line(aes(y= mean_android_percent_fat), color = "black", group = 1) +
  geom_line(aes(y=mean_gynoid_percent_fat), color = "blue", group = 2) + 
  labs(x = "Time in Study", 
       y = "Mean Gynoid and Android Fat Percentage", 
       title = "Mean Gynoid and Android Fat Percentage as Compared to Lean Mass Across Study Time")
ggsave(
  file="output/03_android_gynoid_graph.png",
  plot = android_gynoid_graph,
  device = "png"
)
