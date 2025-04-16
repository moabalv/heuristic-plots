library(tidyverse)

data <- read_csv("data/custos.csv")

online = data %>% filter(window == 0, heuristic == "online")
ondemand = data %>% filter(window == 0, heuristic == "full ondemand")

data %>%
  filter(window != 0) %>%
  ggplot() +
  geom_line(mapping = aes(x = window, y = cost, color = heuristic)) +
  scale_x_continuous(breaks = c(3, 6, 9, 12)) +
  facet_wrap(~instance, scales = "free_y", nrow = 1)+
  geom_point(mapping = aes(x = window, y = cost, color = heuristic)) +
  geom_hline(data = online, aes(yintercept = cost), color = "black") +
  geom_hline(data = ondemand, aes(yintercept = cost), color = "red") +
  scale_color_manual(values = c("Oráculo" = "gold",
                                "XGBoost" = "green",
                                "FFT" = "purple",
                                "Prophet" = "blue")) +
  labs(y = "Custo", x = "Horizonte de predição (meses)", color = "Modelo") +
  theme_bw() +
  theme(
    legend.position = "bottom"
  )
