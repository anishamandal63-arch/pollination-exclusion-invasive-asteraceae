
# =========================================================
# Pollination exclusion experiment analyses
# =========================================================

library(dplyr)
library(ggplot2)


###########1. Load data
data <- read.csv("seeddata.csv")

data$Species <- as.factor(data$Species)
data$Mesh <- as.factor(data$Mesh)
data$Set <- as.factor(data$Set)

#########################################
ageratum <- subset(data, Species == "Ageratum")
chromolaena <- subset(data, Species == "Chromolaena")
mikania <- subset(data, Species == "Mikania")

# Ensure factors
data$Mesh <- factor(data$Mesh, levels = c("C","O","L","S"))
data$Species <- factor(data$Species)



####################################################
# Ensure species order
data$Species <- factor(data$Species,
                       levels = c("Ageratum", "Chromolaena", "Mikania"))

# Summary with SE seed set
summary_data_se <- data %>%
  group_by(Species, Mesh) %>%
  summarise(
    mean = mean(Seed.set.per.floret, na.rm = TRUE),
    sd = sd(Seed.set.per.floret, na.rm = TRUE),
    n = n(),
    se = sd / sqrt(n),
    .groups = "drop"
  )


############################------figures

cb_palette <- c("#0072B2", "#E69F00", "#009E73", "#CC79A7")
data$Mesh <- factor(data$Mesh, levels = c("C", "O", "L", "S"))
library(ggplot2)

##########################3 seed set se tricolour
# Seed set graph with species-specific colours

ggplot(summary_data_se,
       aes(x = Mesh, y = mean, fill = Species)) +
  
  geom_bar(stat = "identity",
           color = "black") +
  
  geom_errorbar(aes(ymin = mean - se,
                    ymax = mean + se),
                width = 0.2) +
  
  facet_wrap(~Species, scales = "free_y",
             labeller = labeller(Species = c(
               "Ageratum" = "Ageratum conyzoides",
               "Chromolaena" = "Chromolaena odorata",
               "Mikania" = "Mikania micrantha"
             ))) +
  
  scale_fill_manual(values = c(
    "Ageratum" = "#0072B2",      # blue
    "Chromolaena" = "#E69F00",  # orange
    "Mikania" = "#CC79A7"       # pink-purple
  )) +
  
  theme_bw() +
  
  labs(
    x = "Pollination Treatment",
    y = "Seed set per floret"
  ) +
  
  theme(
    legend.position = "none",
    strip.text = element_text(face = "italic")
  )

########################### seed mass
# Summary with SE (seed mass)
summary_data_mass <- data %>%
  group_by(Species, Mesh) %>%
  summarise(
    mean = mean(Weight.per.seed, na.rm = TRUE),
    sd = sd(Weight.per.seed, na.rm = TRUE),
    n = n(),
    se = sd / sqrt(n),
    .groups = "drop"
  )


ggplot(summary_data_mass,
       aes(x = Mesh, y = mean, fill = Species)) +
  
  geom_bar(stat = "identity",
           color = "black") +
  
  geom_errorbar(aes(ymin = mean - se,
                    ymax = mean + se),
                width = 0.2) +
  
  facet_wrap(~Species, scales = "free_y",
             labeller = labeller(Species = c(
               "Ageratum" = "Ageratum conyzoides",
               "Chromolaena" = "Chromolaena odorata",
               "Mikania" = "Mikania micrantha"
             ))) +
  
  scale_fill_manual(values = c(
    "Ageratum" = "#0072B2",      # blue
    "Chromolaena" = "#E69F00",  # orange
    "Mikania" = "#CC79A7"       # pink-purple
  )) +
  
  theme_bw() +
  
  labs(
    x = "Pollination Treatment",
    y = "Seed mass per seed (mg)"
  ) +
  
  theme(
    legend.position = "none",
    strip.text = element_text(face = "italic")
  )


#####################seed set vs seed mass
cor.test(
  ageratum$Seed.set.per.floret,
  ageratum$Weight.per.seed,
  method = "pearson"
)

cor.test(
  chromolaena$Seed.set.per.floret,
  chromolaena$Weight.per.seed,
  method = "pearson"
)

cor.test(
  mikania$Seed.set.per.floret,
  mikania$Weight.per.seed,
  method = "pearson"
)


###############################graphs seed set vs seed mass
library(ggplot2)
library(dplyr)

# Combine all species into one dataframe
cor_data <- rbind(
  ageratum,
  chromolaena,
  mikania
)

# Species order
cor_data$Species <- factor(
  cor_data$Species,
  levels = c("Ageratum", "Chromolaena", "Mikania")
)

# Scatter plot with regression lines
ggplot(cor_data,
       aes(x = Seed.set.per.floret,
           y = Weight.per.seed,
           color = Species)) +
  
  geom_point(size = 2, alpha = 0.7) +
  
  geom_smooth(method = "lm",
              se = TRUE,
              linewidth = 1) +
  
  facet_wrap(~Species,
             scales = "free",
             labeller = labeller(Species = c(
               "Ageratum" = "Ageratum conyzoides",
               "Chromolaena" = "Chromolaena odorata",
               "Mikania" = "Mikania micrantha"
             ))) +
  
  scale_color_manual(values = c(
    "Ageratum" = "#0072B2",      # blue
    "Chromolaena" = "#E69F00",  # orange
    "Mikania" = "#CC79A7"       # pink-purple
  )) +
  
  theme_bw() +
  
  labs(
    x = "Seed set per floret",
    y = "Seed mass per seed (mg)"
  ) +
  
  theme(
    legend.position = "none",
    strip.text = element_text(face = "italic")
  )


############################## mature vs immmature seeds (ratio)

# Calculate proportion of under-developed seeds
data$Undev_prop <- data$Undeveloped /
  (data$Undeveloped + data$Developed)

# Species order
data$Species <- factor(data$Species,
                       levels = c("Ageratum",
                                  "Chromolaena",
                                  "Mikania"))

# Summary table
summary_undev <- data %>%
  group_by(Species, Mesh) %>%
  summarise(
    mean = mean(Undev_prop, na.rm = TRUE),
    sd = sd(Undev_prop, na.rm = TRUE),
    n = n(),
    se = sd / sqrt(n),
    .groups = "drop"
  )

# Plot
ggplot(summary_undev,
       aes(x = Mesh, y = mean, fill = Species)) +
  
  geom_bar(stat = "identity") +
  
  geom_errorbar(aes(ymin = mean - se,
                    ymax = mean + se),
                width = 0.2) +
  
  facet_wrap(~Species,
             scales = "free_y",
             labeller = labeller(Species = c(
               "Ageratum" = "Ageratum conyzoides",
               "Chromolaena" = "Chromolaena odorata",
               "Mikania" = "Mikania micrantha"
             ))) +
  
  scale_fill_manual(values = c(
    "#0072B2",   # blue
    "#D55E00",   # orange
    "#CC79A7"    # pink
  )) +
  
  theme_bw() +
  
  labs(
    x = "Pollination Treatment",
    y = "Proportion of under-developed seeds"
  ) +
  
  theme(
    legend.position = "none",
    strip.text = element_text(face = "italic")
  )





################################33 pollinator assemblages

data <- read.csv(file= "Poll_ex_pollinators_chap_2.csv")

library(dplyr)

pollinator_richness <- data %>%
  group_by(Species) %>%
  summarise(
    Pollinator_richness = n_distinct(SN)
  )

pollinator_richness

order_interactions <- data %>%
  group_by(Species, Order) %>%
  summarise(
    Total_interactions = sum(PN),
    .groups = "drop"
  )

order_interactions



#########################################################
order_richness <- data %>%
  group_by(Species, Order) %>%
  summarise(
    Richness = n_distinct(SN),
    .groups = "drop"
  )

order_richness

################################################

ggplot(order_interactions,
       aes(x = Species,
           y = Total_interactions,
           fill = Order)) +
  
  geom_bar(stat = "identity") +
  
  scale_x_discrete(labels = c(
    "Ageratum conyzoides" = "Ageratum conyzoides",
    "Chromolaena odorata" = "Chromolaena odorata",
    "Mikania micrantha" = "Mikania micrantha"
  )) +
  
  theme_bw() +
  
  labs(
    x = "Invasive plant species",
    y = "Number of pollinator interactions"
  ) +
  
  theme(
    axis.text.x = element_text(
      face = "italic"
    )
  )
#####################################################
unique(order_richness$Species)

ggplot(order_richness,
       aes(x = Order,
           y = Richness,
           fill = Order)) +
  
  geom_bar(stat = "identity") +
  
  facet_wrap(
    ~Species
  ) +
  
  theme_bw() +
  
  theme(
    strip.text = element_text(size = 11),
    
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  ) +
  
  labs(
    x = "Pollinator order",
    y = "Pollinator richness"
  )+
  theme(
    legend.position = "none",
    strip.text = element_text(face = "italic")
  )
##### relative frequency
library(dplyr)

relative_freq <- data %>%
  
  group_by(Species, Order) %>%
  
  summarise(
    Total_interactions = sum(PN),
    .groups = "drop"
  ) %>%
  
  group_by(Species) %>%
  
  mutate(
    Relative_frequency =
      (Total_interactions /
         sum(Total_interactions)) * 100
  )

relative_freq

###########--------graph

library(ggplot2)

ggplot(relative_freq,
       aes(x = Species,
           y = Relative_frequency,
           fill = Order)) +
  
  geom_bar(stat = "identity") +
  
  scale_x_discrete(labels = c(
    "Ageratum conyzoides" =
      "Ageratum conyzoides",
    
    "Chromolaena odorata" =
      "Chromolaena odorata",
    
    "Mikania micrantha" =
      "Mikania micrantha"
  )) +
  
  theme_bw() +
  
  labs(
    x = "Invasive plant species",
    y = "Relative visitation frequency (%)"
  ) +
  
  theme(
    axis.text.x = element_text(
      face = "italic"
    )
  )