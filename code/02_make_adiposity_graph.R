here::i_am("code/02_make_adiposity_graph.R")

#clean data and manipulate for adiposity
vatx <- dxareport %>%
  drop_na(bl_visceral_adipose_tissue_mass_lbs, 
          x6mo_visceral_adipose_tissue_mass_lbs, 
          x12mo_visceral_adipose_tissue_mass_lbs) %>% 
  summarise(Baseline = mean(bl_visceral_adipose_tissue_mass_lbs),
            `6 Month` = mean(x6mo_visceral_adipose_tissue_mass_lbs),
            `12 Month` = mean(x12mo_visceral_adipose_tissue_mass_lbs)) %>%
  pivot_longer(cols = everything(),
               names_to = "Timepoint",
               values_to = "Mean_Visceral_Adipose_Tissue")

# Reordering the levels of  timepoint, as this is an ordinal variable.
vatx$Timepoint <- factor(vatx$Timepoint, levels = c("Baseline", "6 Month", "12 Month"))

# Plotting the mean visceral adipose tissue mass across time points as a line graph
adiposity_graph<- ggplot(data = vatx, aes(x = Timepoint, y = Mean_Visceral_Adipose_Tissue, group = 1)) +
  geom_line(color = "cyan") +
  geom_point(color = "black") +
  labs(x = "Time in Study", 
       y = "Mean Visceral Adipose Tissue Mass (lbs)", 
       title = "Mean Visceral Adipose Tissue Mass (lbs) across Time Points")

ggsave(filename = "output/02_adiposity_graph.png", 
       plot = adiposity_graph, 
       device = "png")
