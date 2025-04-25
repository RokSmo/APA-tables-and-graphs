# Load required libraries
library(ggplot2)
library(dplyr)

######## GRAF 1
######## Primerjava dveh skupin v treh pogojih v še dveh pogojih

# Define data with SD
data <- data.frame(
  AgeGroup = rep(c("Adolescent", "Young Adult"), times = 6),
  RiskLevel = factor(rep(c("Low Risk", "High Risk"), each = 6), levels = c("Low Risk", "High Risk")),
  RewardSize = factor(rep(c("Small Reward", "Medium Reward", "Large Reward"), each = 2, times = 2), 
                      levels = c("Small Reward", "Medium Reward", "Large Reward")),
  FramingScore = c(
    0.20, 0.30,  # Low Risk - Small
    0.07, 0.27,  # Low Risk - Medium
    0.09, 0.13,  # Low Risk - Large
    0.14, 0.18,  # High Risk - Small
    0.13, 0.15,  # High Risk - Medium
    0.07, 0.15   # High Risk - Large
  ),
  SD = c(
    0.02, 0.025,
    0.015, 0.02,
    0.018, 0.02,
    0.02, 0.025,
    0.02, 0.02,
    0.015, 0.02
  )
)




# Plot
ggplot(data, aes(x = AgeGroup, y = FramingScore, fill = RewardSize)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.8), 
           color = "black", width = 0.7) +
  geom_errorbar(aes(ymin = FramingScore - SD, ymax = FramingScore + SD),
                position = position_dodge(width = 0.8), width = 0.15) +
  facet_wrap(~ RiskLevel) +
  scale_fill_manual(values = c("white", "khaki1", "lightblue"), 
                    name = "Reward Size") +
  labs(
    x = "Age Group",
    y = "Framing Score"
  ) +
  theme_classic(base_size = 14) +
  theme(
    strip.background = element_blank(),
    strip.text = element_text(face = "bold", size = 14),
    axis.title = element_text(face = "bold"),
    axis.text = element_text(size = 12),
    legend.position = "top",
    legend.title = element_text(face = "bold"),
    legend.text = element_text(size = 12),
    text = element_text(family = "Times")
  )



######## GRAF 2
######## Primerjava vseh sistemov med seboj
library(ggplot2)

# APA-style bar chart for multiple items
plot_apa_bar <- function(labels, values, title = "Emotional response to scene", 
                         width = 6, height = 4, filename = NULL) {
  data <- data.frame(
    Label = factor(labels, levels = labels),
    Value = values
  )
  
  p <- ggplot(data, aes(x = Label, y = Value)) +
    geom_col(fill = "gray70", width = 0.7, color = "black") +
    theme_classic(base_size = 14, base_family = "Times") +
    labs(
      title = title,
      x = NULL,
      y = "Score"
    ) +
    theme(
      axis.text.x = element_text(angle = 30, hjust = 1),
      axis.title.y = element_text(face = "bold"),
      plot.title = element_text(hjust = 0.5, face = "bold"),
      axis.line = element_line(color = "black"),
      panel.grid.major.y = element_line(color = "gray90", linetype = "dotted"),
      plot.margin = margin(10, 10, 10, 10)
    )
  
  # Optional save
  if (!is.null(filename)) {
    ggsave(filename, plot = p, width = width, height = height, dpi = 300)
  }
  
  return(p)
}

# Example call
plot_apa_bar(
  labels = c("4o", "o3-mini-pro", "Gemma", "Gemini Flash", "DeepSeek"),
  values = c(140, 122, 129, 145, 125)
)





######## GRAF 3
######## Primerjava HomeDOCtorja z posameznim LLM-om

plot_apa_two_item <- function(name1, val1, name2, val2,
                              color1 = "gray60", color2 = "gray85",
                              width = 6, height = 4, filename = NULL) {
  data <- data.frame(
    Label = factor(c(name1, name2), levels = c(name1, name2)),
    Value = c(val1, val2)
  )
  
  p <- ggplot(data, aes(x = Label, y = Value)) +
    geom_col(aes(fill = Label), width = 0.5, color = "black") +
    geom_text(aes(label = Value), vjust = -0.4, size = 5, family = "serif") +
    scale_fill_manual(values = c(color1, color2)) +
    labs(
      x = NULL,
      y = "Frequency"
    ) +
    theme_classic(base_size = 14, base_family = "serif") +
    theme(
      axis.title.y = element_text(face = "bold"),
      axis.text = element_text(size = 12),
      legend.position = "none",
      panel.grid.major.y = element_line(color = "gray85", linetype = "dotted"),
      plot.margin = margin(10, 10, 10, 10),
      plot.title = element_blank()
    )
  
  if (!is.null(filename)) {
    ggsave(filename, plot = p, width = width, height = height, dpi = 300)
  }
  
  return(p)
}

# Example
plot_apa_two_item("Joy", 5, "Fear", 2)





