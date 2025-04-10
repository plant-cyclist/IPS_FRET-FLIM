### Tau_Av_Int Extraction Script

### Author:         Leander Rohr, ZMBP Tübingen

### Purpose:        Extract tau_Av_Int [ns] values from .dat files exported by Symphotime and generate corresponding CSV files.

### License:        [GPL-3.0 license]

### Last Updated:   [2024-12-05]


### Description:
###     - Place all .dat files in a single folder.
###     - Set the path to the folder (see line 37)
###     - The script processes each .dat file and generates a CSV file with the extracted values.
###     - If required, missing dependencies are installed automatically.




# Remove all objects in the workspace
rm(list = ls())

# Ensure that all needed packages are installed and loaded
ensure_packages <- function(pkgs) {
  for (pkg in pkgs) {
    if (!requireNamespace(pkg, quietly = TRUE)) {
      install.packages(pkg, dependencies = TRUE)
    }
    library(pkg, character.only = TRUE)
  }
}
ensure_packages ("dplyr")

# Set the working directory. This should be the folder where all your .dat files are stored. 
# Please note that R only accepts "/" as slash
setwd("INSERT/FILE/PATH/HERE")

# Get a list of all .dat files in the directory
dat_files <- list.files(pattern = "\\.dat$", full.names = TRUE)

# Track the number of successful conversions
success_count <- 0

# Loop through each .dat file
for (file_path in dat_files) {
  # Read the file with explicit encoding conversion to handle non-standard characters
  data <- readLines(file_path, encoding = "ISO-8859-1")
  
  # Convert the encoding to avoid issues with special characters
  data <- iconv(data, from = "ISO-8859-1", to = "UTF-8", sub = "")
  
  # Find the starting line after "tau_Av_Int[ns]"
  # This command searches where tau_Av_Int[ns] is present in the .dat file and set the start 3 lines after it.
  start_line <- grep("tau_Av_Int\\[ns\\]", data) + 3  # Start 3 lines after the found line
  
  # Verify that the line with "tau_Av_Int[ns]" was found
  if (length(start_line) == 0) {
    cat("Could not find the 'tau_Av_Int[ns]' header in the file:", basename(file_path), "\n")
    next  # Skip to the next file
  }
  
  # Find the first line that contains a number
  first_numeric_index <- NULL
  
  for (i in start_line:length(data)) {
    # Check if the line contains any numbers
    if (grepl("\\d", data[i])) {
      first_numeric_index <- i
      break
    }
  }
  
  # Output the first line containing a number
  if (!is.null(first_numeric_index)) {
    cat("First line with numeric value found in file", basename(file_path), "at line", first_numeric_index, ":\n")
    
    # Extract all values from the first_numeric_index line onwards
    extracted_lines <- data[first_numeric_index:length(data)]
    
    # Remove all "-" from the lines
    cleaned_lines <- gsub("-", "", extracted_lines)
    
    # Split each line into individual values (assuming space or tab separation)
    split_values <- unlist(strsplit(cleaned_lines, "\\s+"))  # Split by one or more whitespace characters
    
    # Remove any empty strings that may have been created during splitting
    split_values <- split_values[split_values != ""]
    
    # Create a data frame directly with cleaned values
    df <- data.frame(`tau_Av_Int[ns]` = split_values, stringsAsFactors = FALSE)
    
    # Create a CSV filename by replacing .dat with .csv
    csv_filename <- sub("\\.dat$", ".csv", basename(file_path))
    
    # Write the data frame to a CSV file in the same directory
    write.csv(df, file = csv_filename, row.names = FALSE)
    
    success_count <- success_count + 1
    
    cat("Data written to", csv_filename, "with each value in a separate cell under the header 'tau_Av_Int[ns]'.\n")
  } else {
    cat("No numeric value found after 'tau_Av_Int[ns]' in file:", basename(file_path), "\n")
  }
}

# Print a final success message
if (success_count > 0) {  
  cat("\nCSV file generation successful for", success_count, "file(s).\n") 
} else {  
  cat("\nNo CSV files were generated. Please check the .dat files for proper formatting.\n") 
}
