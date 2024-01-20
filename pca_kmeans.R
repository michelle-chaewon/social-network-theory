# Load necessary libraries
library(dplyr)
library(factoextra)
library(readxl)
library(psych)
library(ggplot2)

df <- read.csv('C:/Users/bakch/Downloads/facebook/107_centrality.csv')

length(df)

# check for missing values
print(colSums(is.na(df)))
print(sum(is.na(df)))

# check for duplicates
nrow(df[duplicated(df), ])

# data types
str(df)

#extract feature columns only
features <- df[, 2:6]

# summary statistics
describe(features)

# Boxplot for a specific numeric column
ggplot(df, aes(y = degree_centrality)) + geom_boxplot()
ggplot(df, aes(y = betweenness_centrality)) + geom_boxplot()
ggplot(df, aes(y = closeness_centrality)) + geom_boxplot()
ggplot(df, aes(y = eigenvector_centrality)) + geom_boxplot()
ggplot(df, aes(y = node_degree)) + geom_boxplot()

# outlier detection (box plots)
find_outliers_in_columns <- function(data, target_columns, reference_column) {
  results <- list()
  
  for (column in target_columns) {
    # Calculate IQR for each column
    Q1 <- quantile(data[[column]], 0.25, na.rm = TRUE)
    Q3 <- quantile(data[[column]], 0.75, na.rm = TRUE)
    IQR <- Q3 - Q1
    
    # Define outlier boundaries
    lower_bound <- Q1 - 1.5 * IQR
    upper_bound <- Q3 + 1.5 * IQR
    
    # Identify outlier rows
    outlier_rows <- which(data[[column]] < lower_bound | data[[column]] > upper_bound)
    
    # Extract corresponding values from the reference column
    outlier_values <- data[outlier_rows, reference_column]
    
    # Store results in a list
    results[[column]] <- outlier_values
  }
  
  return(results)
}

feature_cols = c("degree_centrality", "betweenness_centrality", "closeness_centrality", "eigenvevtor_centrality", "node_degree")
outlier_values <- find_outliers_in_columns(df, feature_cols, "node_id")

find_outliers_in_columns(df, "degree_centrality", "node_id")
find_outliers_in_columns(df, "closeness_centrality", "node_id")

# normalization/standardization (z-score)
# z-score normalization ensures that the standardized scores have a mean of 0 and a standard deviation of 1
# allows you to analyze the deviations of individual node from the mean
# Min-Max scaling is suitable when you want to preserve the original data range and interpretation
standardized_df <- as.data.frame(scale(df[, c("degree_centrality", "betweenness_centrality", "closeness_centrality", "eigenvector_centrality", "node_degree")]))

# Add column names to the standardized dataframe
colnames(standardized_df) <- c("degree_centrality_standardized", "betweenness_centrality_standardized", "closeness_centrality_standardized", "eigenvector_centrality_standardized", "node_degree_standardized")

# Display the standardized dataframe
print(standardized_df)

# correlation analysis
correlation_matrix = cor(standardized_df)

# Melt the correlation matrix into long format for ggplot
melted_correlation <- melt(correlation_matrix)

# Create a correlation heatmap with smaller labels
ggplot(melted_correlation, aes(Var1, Var2, fill = value)) +
  geom_tile(color = "white", size = 0.2) +
  scale_fill_gradient2(low = "blue", mid = "white", high = "red",
                       midpoint = 0, limits = c(-1, 1), space = "Lab",
                       name = "Correlation") +
  labs(title = "Correlation Heatmap", x = "", y = "") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1, size = 8), # Adjust the font size
        axis.text.y = element_text(size = 8), # Adjust the font size
        legend.title = element_text(size = 10), # Adjust the legend title font size
        legend.text = element_text(size = 8)) + # Adjust the legend label font size
  geom_text(aes(label = round(value, 2)), vjust = 1, size = 5) + # Adjust the font size
  coord_fixed(ratio = 1)

# Identifying Multicollinearity: high correlations could lead to unstable PCA results
# multicollinearity: several IVs are correlated.
# Hence, let's exclude node_degree_standardized given it is identical to degree_centrality_standardized
 
features_filtered <- df[, 2:5]

# PCA: finding linear combination that accounts for as much variability as possible.
# finding optimal values of the weights to maximize the variance of the combined variables.
# variance is important because variance = information
# e.g., Y=a1X1+a2X2+a3X3+a4X (a1=loadings, X1=variables)

#1. center the data
#2. compute covariance matrix
# *degree to which two variables change together
#3. compute eigenvalue & eigenvector of covariance matrix
#4. order eigenvector
#5. calculate principal components

# Perform PCA
# could have used scale. = TRUE for z-standardization 
pca_result <- prcomp(features_filtered, scale. = FALSE)

# Summary of PCA results
# SD=spread of data points, high SD, more variance captured
# proportion of variance=total variance in the data explained by that component
# higher the proportion of variance, the more important the PC
summary(pca_result)

print(pca_result)

# Scree plot to visualize the proportion of variance explained
# y-axis=eigenvalues (variances) of each PC
# x-axis=# of PCs
# elbow point=point at which the curve starts to level off
plot(prop_var, type = "b", main = "Scree Plot", xlab = "Principal Component", ylab = "Proportion of Variance Explained")
abline(v = 2, col = "red")

# Scatterplot of scores on the first two principal components
plot(pca_result$x[, 1:2], main = "PCA", xlab = "PC1", ylab = "PC2")

pc1_pc2 <- pca_result$x[, 1:2]

# determine the number of centers in kmeans clustering
# Create a vector to store WCSS (within-cluster sum of squares) values
# wcss=sum of squared distances between each data point and the centroid of its assigned cluster
# wcss measures the compactness of clusters
wcss <- numeric(10)

# 1. select the number of clusters ("K")
# 2. randomly select K distinct data points
# 3. measure the distance between 1st point and the K initial clusters (e.g., Euclidiean distance)
# 4. assign the 1st point to the nearest cluster
# 5. same process for the successive points
# 6. calculate the mean of each cluster
# 7. assess the quality of clustering by adding up the variation within each cluster

for (k in 1:10) {
  kmeans_model <- kmeans(pca_result$x[, 1:2], centers = k)
  wcss[k] <- sum(kmeans_model$tot.withinss)
}

# Plot the elbow curve
plot(1:10, wcss, type = "b", xlab = "Number of Clusters (K)", ylab = "Within-Cluster Sum of Squares (WCSS)")

# Calculate the slopes between points
slopes <- diff(wcss)

# Find the "elbow" point where the slope changes most significantly
elbow_point <- which.max(-slopes) + 1

# Add a red line at the elbow point
abline(v = elbow_point, col = "red")

kmeans_result <- kmeans(pc1_pc2, centers = 2)

# map the cluster output to the dataframe
df$cluster <- kmeans_result$cluster

# Convert to a dataframe for ggplot
plot_data <- as.data.frame(pc1_pc2)
plot_data$cluster <- as.factor(kmeans_result$cluster)

# Plotting
ggplot(plot_data, aes(x = PC1, y = PC2, color = cluster)) +
  geom_point(alpha = 0.5) +
  theme_minimal() +
  labs(title = "K-means Clustering on First Two Principal Components",
       x = "Principal Component 1",
       y = "Principal Component 2",
       color = "Cluster")

df$cluster <- kmeans_result$cluster

# PC1 explains for 85.403% of total variance.
# PC2 explains for 12.112% of total variance.

# Cluster 1 is composed of nodes with less number of ties than Cluster 2.
# Both clusters have similar trends in PC2, which has negative loading for closeness centrality (i.e., not close to each other).

write.csv(df, 'C:/Users/bakch/Downloads/facebook/107_centrality_with_clusters.csv', row.names=FALSE)