# Report on Housing and School Data

- Written by [**Tara Nguyen**](https://www.linkedin.com/in/taranguyen264/) in December 2020

## Datasets and Data Cleaning

### Housing Data

The original dataset had 15 columns (variables) with 683 rows (observations). Each row contained information about a housing unit in the city.

#### Missing Values and Oddities

Variable | Information | Number of missing values | Oddities
--- | --- | :---: | ---
`neighborhood` | Name of the neighborhood the unit is in | 0 | None
`beds` | Number of bedrooms | 0 | • 1 odd value: 999 - unrealistic value<br>• The other values ranged from 1 to 6
`baths` | Number of bathrooms | 0 | • 1 potential outlier with value 25<br>• The other values ranged from 1 to 5
`sqft` | Area in square feet | 2 | • 1 potential outlier with value 5265<br>• The other values ranged from 536 to 5097
`lotsize` | Lot size | 20 | 4 potential outliers with values above 1
`year` | Year the unit was built | 0 | • 1 odd value: 2111 - impossible because it is a future year<br>• 1 potential outlier with value 1495<br>• The other values ranged from 1908 to 2018
`type` | Unit type | 0 | • Same values coded differently:<br>-- "condo" and "condominium"<br>-- "town house" and "townhouse"
`levels` | Number of floors in the unit | 6<br>(see next column) | • 6 odd observations with value "?" were considered missing values
`cooling` | Whether or not the unit has cooling | 7 | None
`heating` | Whether or not the unit has central heating | 7 | None
`fireplace` | Whether or not the unit has a fireplace | 6 | None
`elementary` | Elementary school assigned to the unit | 0 | None
`middle` | Middle school assigned to the unit | 0 | None
`high` | High school assigned to the unit | 0 | None
`soldprice` | Selling price of the unit | 0 | • 1 potential outlier with value 664<br>• The other values ranged from 321000 to 2393000

The cleaning of this dataset was completed in two main steps:
1. First, odd values and outliers were either replaced or removed.
2. Then, missing values were replaced with sensible values.

#### Handling the Oddities

In column `year`, the value 2111 was probably a typo, so it was changed to 2011.

In column `type`, "condominium" was changed to "condo", and "town house" was changed to "townhouse".

In column `levels`, "?" was changed to NA (for missing values).

Box plots were then drawn to confirm the presence of outliers in the variables listed below. The values that were too extreme (i.e., their differences from the value of the nearest whisker in the box plot were too big) or that had unrealistic values (e.g., 999 bedrooms) were removed immediately. As for the remaining outliers, later if any of them was deemed to affect the result of a particular analysis, it would be removed as well.

Variable | Outliers | First removal | Outliers remaining after first removal | Further removal
--- | --- | --- | --- | ---
`beds` | One with value 999 | The one outlier | Two remained, one above and the other below the mean.<br>They appeared equidistant from the median line in the box plot. | Depends on later analyses
`baths` | Two above the mean | The more extreme outlier with value 25 | One with value 5 | Depends on later analyses
`sqft` | A few above the mean | Values 5000 and above | A bit remained, not too far from the upper whisker | Depends on later analyses
`lotsize` | Quite a few above the mean | Values 1 and above | A few above the mean remained | Depends on later analyses
`year` | One with value 1495 | The one outlier | None | Not needed
`soldprice` | One below the mean | The one outlier | One above the mean | Depends on later analyses

After the extreme outliers had been removed, the dataset had 667 rows left.

#### Examining and Handling the Missing Values

Missing values (NAs) in one variable were checked against each of the other variables in the dataset. If the latter variable was categorical, a proportion test was run to see if there was any difference in the proportion of the NAs among groups. If that variable was numeric, a pair of box plots were drawn to compare its values with vs. without the NAs. This check showed that all the NAs were missing completely at random.

Categorical NAs (`cooling`, `heating`, `levels`, and `fireplace`) were changed to "noinfo", whereas numeric NAs (in `lotsize` and `cooling`) were replaced with the mean of the respective variable using single imputation.

#### Converting Categorical Variables to Factors

Categorical variables without any missing value or oddity in the original dataset were converted to factors right after the check for such values. Categorical variables with missing values and/or oddities were converted to factors only after such values had been handled.

### School Data

The dataset had 3 columns (variables) with 52 rows (observations). Each row contained information about a school, including elementary, middle, and high schools.

Value | Information
--- | ---
`school` |  School name
`size` | Approximate student population size
`rating` | School rating on a 1 to 10 scale

There was neither missing nor odd value. The column `size` had 2 outliers, but they were not removed because every observation in this dataset corresponds to a school in the housing dataset. If we removed any observation from the school dataset, then when the two datasets were merged, the merged dataset would have missing values.

### Data Merge

To merge the housing dataset with the school dataset, a subset of the former was first reshaped from wide format to long format, with each the schools across all three columns `elementary`, `middle`, and `high` in a separate row. Therefore, each of the 667 rows in the housing dataset was spread over three rows, one for each of the assigned schools.

The reshaped housing dataset and the school dataset were then merged on the `school` variable (name of the school). The merged dataset had 2001 rows and 4 columns:
- 2 columns in the school dataset: `school` and `schrating` (renamed from `rating`); plus
- 2 column from new reshaped housing dataset: `hsprice` (renamed from `soldprice`) and `schlevel` (school level: elementary, middle, or high).

## Data Visualization

### One-Variable Visuals

Here is a box plot of the years the housing units were built. The oldest unit was built in 1908 and the newest one was built in 2018. The average year is 1978, and there are more units built after that than there are units built before that year.

![housingyears](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/housingyears.png)

Next is a histogram of the prices of housing units sold in 2019. The distribution is approximately normal, peaking at around the values between 1,200,000 and 1,400,000. Most units were sold at a price between 500,000 and 1,800,000. Very few units for either less than 500,000 or more than 1,800,000.

![housingprices](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/housingprices.png)

Switching to the school data, we have a bar plot of the student population sizes of all the schools in all three levels - elementary, middle, and high. High schools tend to have more students than either elementary or middle schools. The school with the smallest population size is School ID #36, Panda Middle School, with only 500 students. The school with the largest size is School ID #42, Alpine High School, with 1,250 students.

![schoolsizes](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/schoolsizes.png)

### Multi-Variable Visuals

In the following graph, the areas (in square feet) of housing units are plotted against lot sizes, with an overlaid smooth curve fitted by loess. We can see a curvilinear relationship between lot size and area: as lot size increases, so does area. Most lot sizes are under .4 and most units are under 3,000 square feet in area.

![housinglotsz-vs-sqft](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/housinglotsz-vs-sqft.png)

The next graph shows the selling prices of housing units as a function of lot size, with different colors for the different unit types. For lot sizes below .6, price increases very slowly as lot size increases. As lot size reaches .6, price start to level off, and does not get below 850,000. Note, though, that very few lots have sizes above .6. In terms of unit type, all family houses were sold at above 850,000, whereas all condos and townhouses were sold at below $1,600,000.

![housinglotsz-vs-price-bytype](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/housinglotsz-vs-price-bytype.png)

Next is a smoothed color density plot of the areas of housing units versus the selling price. There is a positive relationship between area and price: as area increases, so does price. Most units were sold at a price between $1,000,000 and $2,000,000.

![housingsqft-vs-price](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/housingsqft-vs-price.png)

## Statistical Analyses

### Linear Regression to Predict Selling Price

Linear regression was used to predict selling price from various other variables available in the housing dataset.

First, a linear regression model was run with selling price as the response and the following variables as the predictors:
- Neighborhood
- Number of bedrooms
- Number of bathrooms
- Area in square feet
- Lot size
- Year the unit was built
- Unit type
- Number of floors
- Whether or not the unit has cooling
- Whether or not the unit has central heating
- Whether or not the unit has a fireplace

All terms except the following yielded statistically significant to marginally significant (*p*s < .08) coefficient estimates:
- Number of bathrooms
- Area in square feet
- Lot size
- Two floors
- No information on the number of floors
- No cooling
- No information on heating
- No information on fireplaces

A stepwise algorithm was therefore used to select a model by the Akaike information criterion. The algorithm removed the following predictors from the model (in order of removal from the first to the last): number of floors, lot size, and number of baths. Interestingly, area was not removed despite being insignificant in the original model (probably because its coefficient estimate had a *p*-value of .11, suggesting that the term was rather close to being statistically significant).

#### Model Results

The selected model was run, producing a very high adjusted R-squared value of .8956. This means that the model was able to explain 89.56% of the variance in selling prices.

The model yielded the following coefficient estimates and probabilities:

Term | Coefficient estimate | *p*-value
--- | ---: | :---:
Intercept | -5006389.83 | < .001
Gold neighborhood   |  280272.87 | < .001
Green neighborhood  |  130146.68 | < .001
Orange neighborhood | -99707.32 | < .001
Purple neighborhood | -141622.53 | .045
Red neighborhood    | -187375.97 | < .001
Silver neighborhood |  35932.79 | .06
Yellow neighborhood |  134818.88 | < .001
Number of bedrooms | 62607.91 | < .001
Area in square feet | 28.55 | .02
Year built | 2869.75 | < .001
Multi-family home type  | 568072.84 | < .001
Single-family home type | 586381.78  | < .001
Townhouse type          | 76938.04  | < .001
No cooling | -5556.24 | .62
No information on cooling | -134073.97 | .01
No heating | -41788.12 | .002
No information on heating | -39369.21 | .43
No fireplace | -40308.18  | < .001
No information on fireplace | 30128.25 | .58

#### Model Interpretation

Based on the table above, the model can be interpreted as follows:
- Compared to a unit in the Blue neighborhood, an exact same unit (having the same number of bedrooms and same measured area, having been built in the same year, being of the same type, and having/lacking the same amenities) in the Gold, Green, Silver, or Yellow neighborhood is predicted to increase selling price, whereas an exact same unit in the other neighborhoods is predicted to decrease price. The Gold neighborhood is associated with the largest boost in selling price (by $280,272.87), whereas the Red neighborhood is associated with the largest decline (by $187,375.97)
- For units in the same neighborhood, of the same type, having the same measured area, having been built in the same year, and having/lacking the same amenities, each additional bedroom is predicted to increase selling price by $62,607.91.
- For units in the same neighborhood, of the same type, having the same number of bedrooms, having been built in the same year, and having/lacking the same amenities, each additional square foot in area is associated with a $28.55 increase in selling price.
- For units in the same neighborhood, of the same type, having the same number of bedrooms and same measured area, and having/lacking the same amenities, a unit built in a certain year is predicted to be sold at $2,869.75 higher than a unit built in the year before that.
- With all other attributes held the same, multi-family homes, single-family homes, and townhouses are all associated with increases in selling price compared to condos (by $568,072.84, $586,381.78, and $76,938.04, respectively).
- Having either no central heating or no fireplace is predicted to decrease selling price by $41,788.12 and $40,308.18, respectively. Having no cooling neither is not associated with selling price.

Taken together, these findings suggest that we can expect the following kind of unit to be sold at the highest price: a huge single-family home currently being built in the Gold neighborhood, having lots of bedrooms and both central heating and a fireplace available.

### K-Means Clustering of School Ratings and Housing Prices

K-means clustering was used to separate schools both by their ratings and by the average selling prices of the housing units to which the schools were assigned. The aim was to see how housing prices might be related to school ratings and/or to the assigned schools themselves.

The clustering process consisted of the following steps:
1. The average housing price for each school was computed and put into a data frame along with information about the schools (names, levels, and ratings).
2. In the new data frame, school ratings and housing prices were scaled so that values in each column represented how much they deviated from the mean of that column.
3. Clustering was done on the scaled data frame.
4. The clusters were visualized.

#### Results of the Clustering

The algorithm produced three clusters of sizes 17, 20, and 15. The centers of each cluster are as follows (note that these are deviation scores, not actual values of school ratings and of selling prices):

Cluster ID | Mean school rating | Mean housing price
:---: | :---: | :---:
1 | -1.16 | -1.07
2 | .20 | .01
3 | 1.05 | 1.20

We can see that Cluster 1 has below-average school ratings and housing prices, Cluster 2 is at about the midpoint on both variables, and Cluster 3 is "above average."

Here is a visualization of the clusters, with the school names also displayed.

![kmeans](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/kmeans.png)

The graph shows that school rating and housing price have a positive relationship: as school rating increases, so does housing price. Thus, having a higher-rated school assigned to a unit is associated with a higher selling price for that unit.

#### Which Neighborhood is the "Best" and Which is the "Worst"?

The following table shows, for each neighborhood, the number of schools in each cluster:

Neighborhood | Number of schools in Cluster 1<br>("below-average" cluster) | Number of schools in Cluster 2<br>("average" cluster) | Number of schools in Cluster 3<br>("above-average" cluster)
--- | :---: | :---: | :---:
Blue   | 131 | 262 | 0
Gold   | 0   | 0   | 153
Green  | 0   | 149 | 148
Orange | 210 | 201 | 0
Purple | 6   | 3   | 0
Red    | 345 | 0   | 0
Silver | 33  | 128 | 31
Yellow | 0   | 35  | 166

Gold is the only neighborhood with all schools in the "above-average" cluster, suggesting that it has both the highest-rated schools and the most expensive housing units. The latter is consistent with the results of the linear regression above, which associated this neighborhood with the largest boost in selling price.

At the other end of the spectrum is the Red neighborhood, where all schools are in the "below-average" cluster. This suggests that this neighborhood is the worst in terms of both school rating and housing price. This is also consistent with the linear regression result that selling prices are predicted to be the worst in this neighborhood.

## Sensitivity Analysis

The entire data merge and data analysis process (from linear regression to k-means clustering) was rerun after the missing data in the housing dataset had been handled using list-wise deletion instead of the original method of single imputation. That is, all rows containing numeric missing values were removed, resulting in 20 rows being deleted and 647 rows left in the dataset. I will now discuss the similarities and differences between the two analysis runs.

### Similarities and Differences in Linear Regression Results

When all variables except the school-information variables in the housing dataset were included as predictors, the terms that had been statistically insignificant in the first run were still insignificant this time, along with the following terms. A term that had been marginally significant in the first run but was insignificant this time was *Being the in Silver neighborhood*.

Next, the stepwise algorithm removed number of floors and lot size just like in the first run, but unlike that run, this time number of bathrooms was not removed. This is probably because 14 of the 20 observations deleted from the dataset had the same value 1 for `baths`. Removing those observations meant both the mean and variance of `baths` increased from that at the first run of the model.

When the model selected by the stepwise algorithm was run, the only big difference from the first run, aside from the inclusion of `baths` as a predictor, was that the coefficient estimate for this added predictor was not significant (*p* = .14). This shows that the number of bathrooms was still not related to changes in selling price.

### Similarities and Differences in K-Means Clustering Results

In this second run, the sizes of the clusters were still 17, 20 and 15. The centers differed from those in the first run only by .01 in each of the mean values for housing price. As seen from the pair of graphs below (clusters from the first run shown first, followed by those from the second run), there was no big difference between the two runs.

![kmeans](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/kmeans.png)

![kmeans-rerun](https://github.com/tara-nguyen/UCLA-Extension-coursework/blob/main/Exploratory%20Data%20Analysis%20and%20Visualization/Homework/Final%20assignment/Plots/kmeans-rerun.png)

With regard to the "best" and the "worst" neighborhoods, though the number of schools in each cluster for each neighborhood changed by a bit this time, Gold was still the "best" and Red was still the "worst."

Thus we can conclude that using a different method for handling missing values did not affect analysis results.

---

This report was written as part of the final assignment for the course *Exploratory Data Analysis and Visualization* at UCLA Extension.

All steps of data wrangling, visualization, and analysis described in the report were performed in R by the report author, [**Tara Nguyen**](https://www.linkedin.com/in/nguyenthuyanh/).
