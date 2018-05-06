library(dplyr)
knn <- read.csv('~/anew/Metro_knn.csv')
rownames(knn) <- knn$city_eng
knn <- knn %>% dplyr::select(norm_stations, norm_lines, norm_old, norm_length_area, norm_tpd)
random.seed = 42
# Ward Hierarchical Clustering
d <- dist(knn, method = "euclidean") # distance matrix
fit <- hclust(d, method="ward.D2")
plot(fit, xlab = 'Cities', ylab = '', sub = '', hang = -1) # display dendogram
# draw dendogram with red borders around the 5 clusters
rect.hclust(fit, k=4, border="red")