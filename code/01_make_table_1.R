here::i_am("code/01_make_table_1.R")

library(table1)
library(ggplot2)
library(readxl)
library(magrittr)
library(tidyverse)
dxareport_raw <- read_excel("clean_simulated_data/dxa_simulation.xlsx")
dxareport <- janitor:: clean_names(dxareport_raw) %>% 
  select(study_id,
         bl_age, 
         bl_totalmass, 
         bl_visceral_adipose_tissue_mass_lbs, 
         bl_android_percent_fat, bl_gynoid_percent_fat,
         bl_sitting, 
         bl_walking, 
         bl_weighttraining, 
         x6mo_total_mass_lbs, 
         x6mo_visceral_adipose_tissue_mass_lbs, 
         x6mo_gynoid_percent_fat, 
         x6mo_android_percent_fat,  
         x6mo_walking_including_treadmill_less_than_3_mph_or_slower_than_20_minutes_per_mile, 
         x6mo_weight_training,
         x12mo_visceral_adipose_tissue_mass_lbs, 
         x12mo_walking, 
         x12mo_weighttraining, 
         x12mo_total_mass_lbs, 
         x12mo_visceral_adipose_tissue_mass_lbs, 
         x12mo_android_percent_fat, 
         x12mo_gynoid_percent_fat)
#label variables

label(dxareport$bl_age)       <- "Age"
label(dxareport$bl_totalmass)       <- "Total Mass"
label(dxareport$bl_visceral_adipose_tissue_mass_lbs)     <- "Visceral Adipose Tissue Mass"
label(dxareport$bl_walking) <- "Low-Intensity Walking Per Day"
label(dxareport$bl_weighttraining) <- "Time Spent Weight Training Per Day"

#attach necessary units
units(dxareport$bl_age)       <- "years"
units(dxareport$bl_visceral_adipose_tissue_mass_lbs) <- "lbs"
units(dxareport$bl_totalmass)       <- "lbs"

#create table 1

table_one <-table1(~ dxareport$bl_age + dxareport$bl_totalmass + dxareport$bl_visceral_adipose_tissue_mass_lbs + dxareport$bl_walking + dxareport$bl_weighttraining, na.rm=T)
s
saveRDS(
  table_one,
  file = "output/table_one.rds"
)