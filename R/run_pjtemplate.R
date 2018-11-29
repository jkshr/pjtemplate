# Run create new project template
#' @name run_pjtemplate
#' @export
#' @title Run create new project template
#' @param path new project path
#' @param ... Variable-length argument.
#' @return No return value.
#' @description
#' @note
#' @examples
kickoff <- function(path, ...) {
  # ensure path exists
  dir.create(path, recursive = TRUE, showWarnings = FALSE)
  dir.create(paste0(path, "/cache"))
  dir.create(paste0(path, "/graphs"))
  dir.create(paste0(path, "/input"))
  dir.create(paste0(path, "/lib"))
  dir.create(paste0(path, "/logs"))
  dir.create(paste0(path, "/munge"))
  dir.create(paste0(path, "/output"))
  dir.create(paste0(path, "/src"))

  dots <- list(...)

  # add data to .gitignore
  if (dots[[1]] == TRUE) {
    gitignore <- paste0(c(".Rproj.user",
                          ".Rhistory",
                          ".RData",
                          "data/"),
                        collapse = "\n")
    writeLines(gitignore, con = file.path(path, ".gitignore"))
  }

  if (file.exists(dots[[3]]) == TRUE) {

    dp <- ifelse(grepl("/$", path), "Dockerfile", "/Dockerfile")

    file.copy(from = dots[[3]],
              to = paste0(path, dp))
  } else {
    if (dots[[2]] == TRUE) {
      dockerfile_info <- paste0(
        "FROM: r-project/rstats:latest\n",
        paste(paste0('Maintainer: "', dots[[4]], '" ', dots[[5]]), collapse = "\n")
      )
      writeLines(dockerfile_info, con = file.path(path, "Dockerfile"))
    }
  }
}
