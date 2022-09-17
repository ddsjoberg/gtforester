#' Add a Forest Plot
#'
#' @param x a gtsummary table
#'
#' @return a gt table
#' @export
#'
#' @examples
#' # Add example
add_forest <- function(x) {
  # create ggplots -------------------------------------------------------------
  lst_ggplots <-
    seq_len(nrow(x$table_body)) %>%
    lapply(
      function(i) {
        if (is.na(x$table_body$estimate[i]) ||
            is.na(x$table_body$conf.low[i]) ||
            is.na(x$table_body$conf.high[i])) {
          return(NULL)
        }

        x$table_body[i, ] %>%
          dplyr::mutate(y = 1L) %>%
          ggplot2::ggplot(
            ggplot2::aes(
              y = .data$y,
              x = .data$estimate,
              xmin = .data$conf.low,
              xmax = .data$conf.high
            )
          ) +
          ggplot2::geom_point(size = 40) +
          ggplot2::geom_errorbarh(height = 0, size = 8) +
          ggplot2::geom_vline(xintercept = 1, linetype = "dotted", size = 10) +
          ggplot2::scale_x_continuous(
            limits = c(min(x$table_body$conf.low, na.rm = TRUE),
                       max(x$table_body$conf.high, na.rm = TRUE))
          ) +
          ggplot2::theme_void()
      }
    )

  # add plots to table ---------------------------------------------------------
  x %>%
    gtsummary::modify_table_body(~.x %>% dplyr::mutate(ggplot = NA, .after = .data$label)) %>%
    gtsummary::modify_footnote(gtsummary::everything() ~ NA) %>%
    gtsummary::modify_footnote(gtsummary::everything() ~ NA, abbreviation = TRUE) %>%
    gtsummary::modify_header(ggplot = "") %>%
    gtsummary::as_gt() %>%
    gt::text_transform(
      locations = gt::cells_body(columns = .data$ggplot),
      fn = function(x) {
        lst_ggplots %>%
          gt::ggplot_image(height = gt::px(20), aspect_ratio = 8)
      }
    ) %>%
    gt::cols_width(ggplot ~ gt::px(250)) %>%
    gt::opt_table_lines(extent = "none") %>%
    # gt::tab_options(column_labels.hidden = TRUE) %>%
    identity()
}
