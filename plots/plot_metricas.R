library(tidyverse)



ggplot(mape) + 
  geom_line(mapping = aes(x = horizon_num, y = mean, color = model)) + 
  geom_point(mapping = aes(x = horizon_num, y = mean, color = model), size = 1) +
  geom_errorbar(aes(x = horizon_num, ymin = inf, ymax = sup, color = model), width = 0.2) + 
  scale_color_manual(values = c("FFT"= "purple", "Prophet" = "blue", "XGBoost" = "green"))+
  scale_x_continuous(breaks = c(3, 6, 9, 12)) +
  labs(x = "Horizonte de Predição", y = "MAPE", color = "Modelo") +
  facet_wrap(~ instance, nrow = 1) +
  theme_bw() +
  theme(
    legend.position = "bottom"
  )
