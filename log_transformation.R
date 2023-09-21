library(data.table)

# Read and assign data to prs1, prs2, ..., prsn
list <- 1:n
for (i in list) {
  wd <- paste0("prs", i)
  assign(paste0("prs", i), fread(wd))
}

# Take the logarithm of the third column for each dataframe
df.list <- lapply(list, function(x) {
  df <- get(paste0("prs", x))
  df[, 3] <- log(df[, 3])
  return(df)
})

# Export dataframes to files
for (i in list) {
  fwrite(get(paste0("prs", i)), paste0("prs", i), sep = " ", col.names = FALSE)
}
