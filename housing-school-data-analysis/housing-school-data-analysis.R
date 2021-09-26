## Tara Nguyen
## UCLA Extension - Exploratory Data Analysis and Visualization
## Final assignment
## 12/9/20

########## DATA IMPORT AND CLEANING ##########

## use read_csv() in the readr package
## which turns the data set into a tibble for neat printing

library(readr)

##### HOUSING DATA #####

housingdat <- read_csv('housing.csv')
housingdat
summary(housingdat)

## CHECK FOR ODDITIES

## function for checking oddities in non-continuous variables
## x: variable to be checked

checkodd_noncont <- function(x) {
	table(x, useNA = 'ifany')
}

## function for checking oddities in continuous variables
## x: variable to be checked
## numq: number of quantiles of x to be examined, including the 0th quantile

checkodd_cont <- function(x, numq) {
	qx <- quantile(x, seq(0, 1, 1/(numq - 1)), na.rm = T)
	cat('\nLowest', names(qx)[2], 'of values and their counts\n')
	print(table(x[x < qx[2]]))
	cat('\nHighest', names(qx)[2], 'of values and their counts\n')
	print(table(x[x > qx[length(qx) - 1]]))
	cat('\nNumber of missing values:', sum(is.na(x)))
}

checkodd_noncont(housingdat$neighborhood)
## convert to factor
housingdat$neighborhood <- factor(housingdat$neighborhood)

checkodd_noncont(housingdat$beds)   ## 1 odd value: 999

checkodd_noncont(housingdat$baths)   ## 1 potential outlier with value: 25

checkodd_cont(housingdat$sqft, 21)
## 1 potential outlier with value 5265
## 2 NAs

checkodd_cont(housingdat$lotsize, 6)
## 4 potential outliers with values above 1
## 20 NAs

checkodd_noncont(housingdat$year)
## 1 potential outlier with value 1495
## 1 odd value: 2111 - probably a typo
## change 2111 to 2011
housingdat$year[housingdat$year == 2111] <- 2011

checkodd_noncont(housingdat$type)
## same values but coded differently:
## - "condo" and "condominium"
## - "town house" and "townhouse"
## change "condominium" to "condo", and "town house" to "townhouse"
housingdat$type[housingdat$type == 'condominium'] <- 'condo'
housingdat$type[housingdat$type == 'town house'] <- 'townhouse'
## convert to factor
housingdat$type <- factor(housingdat$type)

checkodd_noncont(housingdat$levels)
## 6 odd observations with value "?" - change them to NAs
housingdat$levels[housingdat$levels == "?"] <- NA
checkodd_noncont(housingdat$levels)   ## 6 NAs

checkodd_noncont(housingdat$cooling)   ## 7 NAs

checkodd_noncont(housingdat$heating)   ## 7 NAs

checkodd_noncont(housingdat$fireplace)   ## 6 NAs

checkodd_noncont(housingdat$elementary)
## convert to factor
housingdat$elementary <- factor(housingdat$elementary)

checkodd_noncont(housingdat$middle)
## convert to factor
housingdat$middle <- factor(housingdat$middle)

checkodd_noncont(housingdat$high)
## convert to factor
housingdat$high <- factor(housingdat$high)

checkodd_cont(housingdat$soldprice, 41)
## 1 potential outlier with value 664

## EXAMINE OUTLIERS

## confirm the presence of outliers and remove them appropriately

boxplot(housingdat$beds)
housingdat <- subset(housingdat, beds != 999 | is.na(beds))
boxplot(housingdat$beds)   ## better

boxplot(housingdat$baths)
housingdat <- subset(housingdat, baths != 25 | is.na(baths))
boxplot(housingdat$baths)   ## better

boxplot(housingdat$sqft)
housingdat <- subset(housingdat, sqft < 5000 | is.na(sqft))
boxplot(housingdat$sqft)   ## better

boxplot(housingdat$lotsize)
housingdat <- subset(housingdat, lotsize < 1 | is.na(lotsize))
boxplot(housingdat$lotsize)   ## better

boxplot(housingdat$year)
housingdat <- subset(housingdat, year != 1495 | is.na(year))
boxplot(housingdat$year)   ## no more outliers

boxplot(housingdat$soldprice)
housingdat <- subset(housingdat, soldprice != 664 | is.na(soldprice))
boxplot(housingdat$soldprice)

nrow(housingdat)   ## 667 rows left

## EXAMINE MISSING VALUES

## function for checking NAs in a variable against another variable
## x: variable containing missing values to be checked
## y: the other variable

checkna <- function(x, y) {
	isna <- is.na(x)
	
	if (is.numeric(y)) {
		## draw a pair of box plot to compare y with vs. without NAs
		boxplot(y, y[!isna])
	} else {
		## conduct proportion test
		print(na_tab <- table(y, isna))
		prop.test(na_tab)
	}
}

## NAs in lotsize

with(housingdat, checkna(lotsize, neighborhood))   ## no difference
with(housingdat, checkna(lotsize, beds))   ## no difference
with(housingdat, checkna(lotsize, baths))   ## no difference
with(housingdat, checkna(lotsize, sqft))   ## no difference
with(housingdat, checkna(lotsize, year))   ## no difference
with(housingdat, checkna(lotsize, type))   ## no difference
with(housingdat, checkna(lotsize, levels))   ## no difference
with(housingdat, checkna(lotsize, cooling))   ## no difference
with(housingdat, checkna(lotsize, heating))   ## no difference
with(housingdat, checkna(lotsize, fireplace))   ## no difference
with(housingdat, checkna(lotsize, elementary))   ## no difference
with(housingdat, checkna(lotsize, middle))   ## no difference
with(housingdat, checkna(lotsize, high))   ## no difference
with(housingdat, checkna(lotsize, soldprice))
## no more outlier in soldprice
## Conclusion: Values in lotsize are missing completely at random.

## NAs in heating

with(housingdat, checkna(heating, neighborhood))   ## no difference
with(housingdat, checkna(heating, beds))   ## no difference
with(housingdat, checkna(heating, baths))   ## no difference
with(housingdat, checkna(heating, sqft))   ## no difference
with(housingdat, checkna(heating, lotsize))   ## no difference
with(housingdat, checkna(heating, year))   ## no difference
with(housingdat, checkna(heating, type))   ## no difference
with(housingdat, checkna(heating, levels))   ## no difference
with(housingdat, checkna(heating, cooling))   ## no difference
with(housingdat, checkna(heating, fireplace))   ## no difference
with(housingdat, checkna(heating, elementary))   ## no difference
with(housingdat, checkna(heating, middle))   ## no difference
with(housingdat, checkna(heating, high))   ## no difference
with(housingdat, checkna(heating, soldprice))   ## no difference
## Conclusion: Values in heating are missing completely at random.

## NAs in levels

with(housingdat, checkna(levels, neighborhood))   ## no difference
with(housingdat, checkna(levels, beds))   ## no difference
with(housingdat, checkna(levels, baths))   ## no difference
with(housingdat, checkna(levels, sqft))   ## no difference
with(housingdat, checkna(levels, lotsize))   ## no difference
with(housingdat, checkna(levels, year))   ## no difference
with(housingdat, checkna(levels, type))   ## no difference
with(housingdat, checkna(levels, cooling))   ## no difference
with(housingdat, checkna(levels, heating))   ## no difference
with(housingdat, checkna(levels, fireplace))   ## no difference
with(housingdat, checkna(levels, elementary))   ## no difference
with(housingdat, checkna(levels, middle))   ## no difference
with(housingdat, checkna(levels, high))   ## no difference
with(housingdat, checkna(levels, soldprice))   ## no difference
## Conclusion: Values in levels are missing completely at random.

## NAs in fireplace

with(housingdat, checkna(fireplace, neighborhood))   ## no difference
with(housingdat, checkna(fireplace, beds))   ## no difference
with(housingdat, checkna(fireplace, baths))   ## no difference
with(housingdat, checkna(fireplace, sqft))   ## no difference
with(housingdat, checkna(fireplace, lotsize))   ## no difference
with(housingdat, checkna(fireplace, year))   ## no difference
with(housingdat, checkna(fireplace, type))   ## no difference
with(housingdat, checkna(fireplace, levels))   ## no difference
with(housingdat, checkna(fireplace, heating))   ## no difference
with(housingdat, checkna(fireplace, cooling))   ## no difference
with(housingdat, checkna(fireplace, elementary))   ## no difference
with(housingdat, checkna(fireplace, middle))   ## no difference
with(housingdat, checkna(fireplace, high))   ## no difference
with(housingdat, checkna(fireplace, soldprice))
## no more outlier in soldprice
## Conclusion: Values in fireplace are missing completely at random.

## NAs in sqft

with(housingdat, checkna(sqft, neighborhood))   ## no difference
with(housingdat, checkna(sqft, beds))   ## no difference
with(housingdat, checkna(sqft, baths))   ## no difference
with(housingdat, checkna(sqft, lotsize))   ## no difference
with(housingdat, checkna(sqft, year))   ## no difference
with(housingdat, checkna(sqft, type))   ## no difference
with(housingdat, checkna(sqft, levels))   ## no difference
with(housingdat, checkna(sqft, cooling))   ## no difference
with(housingdat, checkna(sqft, heating))   ## no difference
with(housingdat, checkna(sqft, fireplace))   ## no difference
with(housingdat, checkna(sqft, elementary))   ## no difference
with(housingdat, checkna(sqft, middle))   ## no difference
with(housingdat, checkna(sqft, high))   ## no difference
with(housingdat, checkna(sqft, soldprice))   ## no difference
## Conclusion: Values in sqft are missing completely at random.

## HANDLE MISSING VALUES

## change categorical NAs to "noinfo"
## then convert the variables to factors

housingdat$cooling[is.na(housingdat$cooling)] <- 'noinfo'
housingdat$cooling <- factor(housingdat$cooling, 
	levels = c('Yes', 'No', 'noinfo'))
housingdat$heating[is.na(housingdat$heating)] <- 'noinfo'
housingdat$heating <- factor(housingdat$heating, 
	levels = c('Yes', 'No', 'noinfo'))
housingdat$levels[is.na(housingdat$levels)] <- 'noinfo'
housingdat$levels <- factor(housingdat$levels)
housingdat$fireplace[is.na(housingdat$fireplace)] <- 'noinfo'
housingdat$fireplace <- factor(housingdat$fireplace, 
	levels = c('Yes', 'No', 'noinfo'))
summary(housingdat)

## make a copy of the data set at this point (before handling numeric NAs)
## so later we can go back to it for sensitivity analysis

hsdat_numericna <- housingdat

## use single imputation to replace numeric NAs - replace with mean value

housingdat$lotsize[is.na(housingdat$lotsize)] <- mean(housingdat$lotsize, 
	na.rm = T)
housingdat$sqft[is.na(housingdat$sqft)] <- mean(housingdat$sqft, na.rm = T)
summary(housingdat)

## subset of data without school information

housingdat_noschool <- housingdat[, -(12:14)]

##### SCHOOL DATA #####

schooldat <- read_csv('schools.csv')
schooldat
summary(schooldat)

## check for oddities

checkodd_noncont(schooldat$school)
checkodd_cont(schooldat$size, 3)
checkodd_cont(schooldat$rating, 3)

boxplot(schooldat$size)
boxplot(schooldat$rating)

## number of schools

n_schools <- nrow(schooldat)

##### DATA MERGE #####

## reshape a subset of housingdat to long format
## use melt() in the reshape2 package

library(reshape2)
housingdat_melt <- melt(housingdat, id = 'soldprice',
	measure = c('elementary', 'middle', 'high'), value.name = 'school',
	variable.name = 'schlevel')
head(housingdat_melt)

## merge the school data with the new housing data

mergedat <- merge(schooldat[, -2], housingdat_melt, by = 'school')
head(mergedat)
## rearrange and rename columns
mergedat <- mergedat[, c(1, 4, 2, 3)]
colnames(mergedat) <- c('school', 'schlevel', 'schrating', 'hsprice')
head(mergedat)
summary(mergedat)
nrow(mergedat)
names(mergedat)

########## DATA VISUALIZATION ##########

## function for getting colors for plots
## n: number of colors needed
## i: index of the color palette listed in hcl.pals('qualitative')
## i = 1: "Pastel 1"
## i = 2: "Dark 2"
## i = 3: "Dark 3"
## i = 4: "Set 2"
## i = 5: "Set 3"
## i = 6: "Warm"
## i = 7: "Cold"
## i = 8: "Harmonic"
## i = 9: "Dynamic"
## i > 9: the list of palettes gets recycled
## alpha: color transparency; a single number or a vector of numbers between 0 and 1

getcol <- function(n, i, alpha = NULL) {
	if (i %% 9 != 0) {
		i <- i %% 9
	}
	hcl.colors(n, hcl.pals('qualitative')[i], alpha = alpha)
}

## function for saving plots as png files
## name: a descriptive name for the file (without the .png extension)
## w, h: width and height (in pixels) of the image

saveaspng <- function(name, w = 700, h = 480) {
	filename <- paste0('Plots/', name, '.png')
	png(filename, w, h)
}

##### ONE-VARIABLE PLOTS #####

saveaspng('housingyears', 480)
boxplot(housingdat$year, main = 'Years the Housing Units Were Built',
	boxwex = .6, medlwd = 2, whisklwd = .5, staplewex = .3, outcex = .5,
	col = 4)
## add mean point
points(mean(housingdat$year), bg = 2, pch = 23, cex = 1.2)
dev.off()

saveaspng('housingprices')
hist(housingdat$soldprice, col = 5, xlab = 'Price',
	main = 'Prices of Housing Units Sold in 2019')
dev.off()

saveaspng('schoolsizes', 750)
barplot(schooldat$size, main = 'Student Population Sizes of All Schools', 
	xlab = 'School ID', names.arg = 1:n_schools, ylab = 'Size', 
	col = getcol(n_schools, 9))
## add explanatory text
text(3, 1100, paste0('School IDs #1-23: Elementary schools\n',
	'School IDs #24-38: Middle schools\nSchool IDs #39-52: High schools'), 
	adj = 0)
dev.off()

##### TWO-VARIABLE PLOTS #####

saveaspng('housinglotsz-vs-sqft')
scatter.smooth(housingdat[, c('lotsize', 'sqft')], col = getcol(1, 7, .5), 
	main = 'Lot Sizes Vs. Areas of Housing Units', xlab = 'Lot size',
	ylab = 'Area in square feet', pch = 20, lpars = list(col = 2, lwd = 4, 
	lty = 2))
## add legend
legend('bottomright', 'Smooth curved fitted by loess', col = 2, lwd = 4, 
	lty = 2, inset = c(0, .2))
## add vertical line at lot size = .4 and horizontal line at area = 3000
abline(v = .4, h = 3000, col = getcol(2, 9), lty = 4:3, lwd = 3)
dev.off()

saveaspng('housinglotsz-vs-price-bytype', 750)
with(housingdat, scatter.smooth(lotsize, soldprice, col = type, cex = .5,
	main = 'Lot Sizes Vs. Selling Price, Separated by Unit Type', 
	xlab = 'Lot size', ylab = 'Price', lpars = list(col = 2, lwd = 4, 
	lty = 2)))
## add legends
legend('topleft', 'Smooth curved fitted by loess', col = 2, lwd = 4, 
	lty = 2)
legend('topright', levels(housingdat$type), title = 'Unit type', 
	col = 1:4, pt.cex = .5, pch = 1)
## add horizontal lines at price = 850000, 1600000 and vertical line at lot size = .6
h <- c(850000, 1600000)
abline(h = h, v = .6, col = 5:7, lty = 4:6, lwd = 3)
## add text to explain the vertical lines
text(.8, c(790000, 1660000), paste('price =', h))
dev.off()

saveaspng('housingsqft-vs-price', 480)
with(housingdat, smoothScatter(sqft, soldprice, nrpoints = 0,
	main = paste('Smoothed Color Density Plot of\nAreas of Housing Units',
	'Vs. Selling Price'), xlab = 'Area in square feet', ylab = 'Price'))
## add horizontal lines at price = 1000000, 20000000
abline(h = c(1000000, 2000000), col = 6:7, lty = 4:5, lwd = 3)
dev.off()

########## STATISTICAL ANALYSES ##########

##### LINEAR REGRESSION: PREDICT SELLING PRICE #####

lm1 <- lm(soldprice ~ ., housingdat_noschool)
summary(lm1)

## use stepwise algorithm to select a model by

lm2 <- step(lm1)
lm2$call   ## new model
options(scipen = 1)   ## prevent scientific notation from displaying
summary(lm2)
options(scipen = 0)   ## revert to the default setting

## diagnostic plots

par(mfrow = c(2, 2))   ## turn plot window into a 2x2 grid
plot(lm2)
par(mfrow = c(1, 1))

##### K-MEANS CLUSTERING OF SCHOOL RATINGS AND HOUSING PRICES #####

## data frame consisting of school ratings and average housing prices grouped by school

schmeans <- aggregate(cbind(schrating, hsprice) ~ school + schlevel, 
	mergedat, mean)
schmeans <- data.frame(schmeans[, -(1:2)], row.names = schmeans[, 1])

## scale each column

schmeans_scaled <- scale(schmeans)

## clustering on the scaled data frame

set.seed(6)   ## for reproducible results
(km <- kmeans(schmeans_scaled, 3))

## visualize the clusters

library(factoextra)

saveaspng('kmeans', 1000, 800)
# saveaspng('kmeans-rerun', 1000, 800)
fviz_cluster(km, schmeans, repel = T, xlab = 'School rating',
	main = 'Clusters of School Ratings and Housing Prices',
	ylab = 'Housing price', palette = 'Dark2', ellipse.alpha = .1,
	labelsize = 14)
dev.off()

## combine the clustering vector with info on neighborhood, elementary, 
## middle, and high schools from the housing dataset

cluster_df <- data.frame(school = names(km$cluster), cluster = km$cluster)

housingdat_cluster <- merge(housingdat[, c(1, 12:14)], cluster_df, 
	by.x = 'elementary', by.y = 'school')
housingdat_cluster <- merge(housingdat_cluster, cluster_df, by.x = 'middle', 
	by.y = 'school', suffixes = c('_elem', '_mid'))
housingdat_cluster <- merge(housingdat_cluster, cluster_df, by.x = 'high', 
	by.y = 'school')
head(housingdat_cluster)
## rearrange and rename columns
housingdat_cluster <- housingdat_cluster[, c(4, 3, 5, 2, 6, 1, 7)]
colnames(housingdat_cluster)[7] <- 'cluster_high'
head(housingdat_cluster)

## number of schools in each cluster for each neighborhood

elemclusttab <- xtabs(~ neighborhood + cluster_elem, housingdat_cluster)
midclusttab <- xtabs(~ neighborhood + cluster_mid, housingdat_cluster)
highclusttab <- xtabs(~ neighborhood + cluster_high, housingdat_cluster)
elemclusttab + midclusttab + highclusttab

########## SENSITIVITY ANALYSIS ##########

## go back to the housing dataset before single imputation was implemented
## and delete all numeric missing data

summary(hsdat_numericna)   ## dataset before numeric NAs were replaced
housingdat <- subset(hsdat_numericna, !is.na(sqft) & !is.na(lotsize))
nrow(housingdat)   ## 647 rows left

## subset of data without school information

housingdat_noschool <- housingdat[, -(12:14)]

## scroll up and redo data merge, linear regression, and k-means clustering
## then examine the numeric NAs to help explain the differences between the runs

## NA tests

isna_sqft <- is.na(hsdat_numericna$sqft)
isna_lsz <- is.na(hsdat_numericna$lotsize)

## number of NAs for each baths value

aggregate(cbind(isna_sqft, isna_lsz), list(baths = hsdat_numericna$baths), 
	sum)