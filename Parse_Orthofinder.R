###################
### Run locally ###
###################

#Set working directory

#Load the packages
library(tidyverse)
library(data.table)
library(cowplot)
library(RColorBrewer)
library(UpSetR)
library(ComplexUpset)

#Summarize Orthofinder statistics per species
#Import dataset
dat <- fread("Statistics_PerSpecies_5.tsv")
ids=names(dat)
dat <- gather(dat, species, perc, ids[ids!="V1"], factor_key = TRUE)

#Parse Dataset
o_ratio <- dat %>%
  filter(V1 %in% c("Number of genes",
                   "Number of genes in orthogroups",
                   "Number of unassigned genes",
                   "Number of orthogroups containing species",
                   "Number of species-specific orthogroups",
                   "Number of genes in species-specific orthogroups"))

o_percent <- dat %>%
  filter(V1 %in% c("Percentage of genes in orthogroups",
                   "Percentage of unassigned genes",
                   "Percentage of orthogroups containing species",
                   "Percentage of genes in species-specific orthogroups"))

pastel_colors <- c("Pastel1" = "#fbb4ae", "Pastel2" = "#b3cde3", "Pastel3" = "#ccebc5", 
                   "Pastel4" = "#decbe4", "Pastel5" = "#fed9a6", "Pastel6" = "#ffffcc",
                   "Pastel7" = "#e5d8bd", "Pastel8" = "#fddaec", "Pastel9" = "#f2f2f2")

#Plot
p <- ggplot(o_ratio, aes(x =  V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  scale_fill_brewer(palette = "Paired") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Count")
p
ggsave("Orthogroups.pdf")
p <- ggplot(o_percent, aes(x =  V1, y = perc, fill = species)) +
  geom_col(position = "dodge") +
  ylim(c(0, 100)) +
  scale_fill_brewer(palette = "Paired") +
  theme_cowplot() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  labs(y = "Count")
p
ggsave("Percentage_ortho.pdf")

# =============================================================================
#PLot co-occurrence of Orthogroups
ogroups <- fread("Orthogroups.GeneCount.tsv")

#Parse dataset
ogroups <- ogroups %>% select(-Total)
ogroups_presence_absence <- ogroups
rownames(ogroups_presence_absence) <- ogroups_presence_absence$Orthogroup
ogroups_presence_absence[ogroups_presence_absence > 0] <- 1
ogroups_presence_absence$Orthogroup <- rownames(ogroups_presence_absence)

str(ogroups_presence_absence)
ogroups_presence_absence$Orthogroup

ogroups_presence_absence <- ogroups_presence_absence %>%
  rowwise() %>%
  mutate(SUM = sum(c_across(ends_with("proteins"))))

genomes <- names(ogroups_presence_absence)[grepl("proteins",names(ogroups_presence_absence))]
ogroups_presence_absence <- data.frame(ogroups_presence_absence)
ogroups_presence_absence[genomes] <- ogroups_presence_absence[genomes] == 1
library(ComplexUpset)
#Plot data using the ComplexUpset package
pdf("one-to-one_orthogroups_plot.complexupset.pdf", height = 5, width = 10, useDingbats = FALSE)
upset(ogroups_presence_absence, genomes, name = "genre", width_ratio = 0.1, wrap = TRUE, set_sizes = FALSE)
dev.off()