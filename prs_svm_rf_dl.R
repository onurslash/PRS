library(data.table)

# Function to read files and write results
process_data <- function(prefix, suffix) {
  data <- fread(paste0(prefix, suffix), header = TRUE)
  data <- data[, -3, with = FALSE]
  fwrite(cbind(data, fread(paste0("w_", prefix, suffix), header = TRUE)), paste0("prs_", prefix, suffix), sep = " ", col.names = FALSE)
}

# Generate PRS for different scenarios
prefixes <- c("svm", "rf", "dl")
suffixes <- 1:n

for (prefix in prefixes) {
  for (suffix in suffixes) {
    process_data(prefix, suffix)
  }
}

# Quit R
q()
