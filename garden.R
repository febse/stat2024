library(tidyverse)

draw_garden <- function(n, blue, smpl) {
    sn <- length(smpl)
    positions <- sapply(1:sn, function(x) (1:n^x) / n^(x-1))

    d <- tibble(
        position = positions,
        draw = rep(1:sn, times = c(n^1, n^2, n^3)),
        fill = rep(c("b", "w"), times = c(1, sn)) %>% 
           rep(., times = c(n^0 + n^1 + n^2))
    )

    lines_1 <-  tibble(
        x = rep((1:n), each = n),
        xend = ((1:n^2) / n),
        y = 1,
        yend = 2
        )

    lines_2 <- tibble(
        x = rep(((1:n^2) / n), each = n),
        xend = (1:n^3) / (n^2),
        y    = 2,
        yend = 3
        )

    d <- d %>% 
        mutate(
            denominator = ifelse(draw == 1, .5,
                                ifelse(draw == 2, .5 / n,
                                        .5 / n^2))) %>% 
        mutate(
            position = position - denominator
            )

    lines_1 <- lines_1 %>% 
    mutate(
        x    = x - .5,
            xend = xend - .5 / n^1
    )

    lines_2 <- lines_2 %>%
    mutate(
        x    = x - .5 / n^1,
            xend = xend - .5 / n^2)

    d %>% 
    ggplot(aes(x = position, y = draw)) +
    geom_segment(data  = lines_1,
                aes(x = x, xend = xend,
                    y = y, yend = yend),
                size  = 1/3) +
    geom_segment(data  = lines_2,
                aes(x = x, xend = xend,
                    y = y, yend = yend),
                size  = 1/3) +
    geom_point(aes(fill = fill),
                shape = 21, size = 4) +
    scale_fill_manual(values  = c("navy", "white")) +
    scale_x_continuous(NULL, limits = c(0, 4), breaks = NULL) +
    scale_y_continuous(NULL, limits = c(0.75, 3), breaks = NULL) +
    theme(panel.grid      = element_blank(),
            legend.position = "none") +
    coord_polar()
}
