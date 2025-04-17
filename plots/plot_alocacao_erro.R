library(gridExtra)
library(tidyverse)

data <- read_csv("data/alocacao.csv") 
metrics <- read_csv("data/mape_alocacao.csv")

aloc <- data %>%
  ggplot(aes(x = start_date, y = num_instances, color = "Demanda")) +
  geom_line() +
  geom_line(aes(y = xgb, color = "Reservas (XGBoost)")) +
  geom_line(aes(y = fft, color = "Reservas (FFT)")) +
  geom_line(aes(y = prophet, color = "Reservas (Prophet)")) +
  labs(y = "Vms", x = "Data", color = "") +
  scale_color_manual(values = c("Demanda" = "black", "Reservas (XGBoost)" = "green", "Reservas (FFT)" = "red", "Reservas (Prophet)" = "blue"))+
  theme_bw() + 
  theme(legend.position = "bottom")

mape <- metrics %>% ggplot() +
  geom_line(mapping = aes(x = id, y = fft, color = "FFT")) +
  geom_line(mapping = aes(x = id, y = prophet, color = "Prophet")) +
  geom_line(mapping = aes(x = id, y = xgboost, color = "XGBoost")) +
  scale_color_manual(values = c("FFT"= "red", "Prophet" = "blue", "XGBoost" = "green")) + 
  labs(x = "Data da predição", y = "MAPE", color = "Modelo") + theme_bw() + theme(legend.position = "top")

grid.arrange(mape, aloc, ncol= 1)
