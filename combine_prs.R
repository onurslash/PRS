library(data.table)

# Define a function to read and combine data
combine_data <- function(prefix, num) {
  data <- rbindlist(lapply(num, function(i) fread(paste0(prefix, i, ".profile"))), use.names = FALSE)
  data <- data[, -c(1, 2, 4, 5), with = FALSE]
  return(data)
}

# Read and combine PRS data
prs <- combine_data("prs", 1:n)

# Read and combine SVM data
svm <- combine_data("prs_svm", 1:n)
colnames(svm) <- c("P", "SVM")

# Read and combine RF data
rf <- combine_data("prs_rf", 1:n)
colnames(rf) <- c("P", "RF")

# Read and combine DL data
dl <- combine_data("prs_dl", 1:n)
colnames(dl) <- c("P", "DL")

# Combine all data frames
result <- cbind(prs, svm$SVM, rf$RF, dl$DL)
colnames(result) <- c("PHENO", "PRS", "SVM", "RF", "DL")

# Write to a CSV file
fwrite(result, "prs_5K.csv", sep = ";")
