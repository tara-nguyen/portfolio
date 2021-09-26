# Visualizations of COVID-19 vaccine Distribution Allocations by Jurisdiction

library(RSocrata)
library(usmap)
library(ggplot2)

# DATA IMPORT AND CLEANING --------------------

sources <- c(
	'https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/saz5-9hgg',
	'https://data.cdc.gov/Vaccinations/COVID-19-Vaccine-Distribution-Allocations-by-Juris/b7pe-5nws'
)

pfizer <- read.socrata(sources[1])
head(pfizer)
tail(pfizer)
colnames(pfizer)

moderna <- read.socrata(sources[2])
head(moderna)
tail(moderna)
colnames(moderna)

# Remove final row, which is the row of week totals
pfizer <- pfizer[-nrow(pfizer),]
moderna <- moderna[-nrow(moderna),]

# Shorten column names

shorten_colnames <- function(dat) {
	col <- colnames(dat)
	
	# region column
	col[2] <- 'region'
	
	# week columns
	prefix <- 'wk_'
	timeinfo <- regmatches(col, gregexpr('[0-9]+', col))
	for (i in seq(3, length(timeinfo), 2)) {
		week <- paste(timeinfo[[i]], collapse = '')
		col[i] <- paste0(prefix, week, '_dose1')
		col[i + 1] <- paste0(prefix, week, '_dose2')
	}
	
	# total columns (last two columns)
	ncol <- ncol(dat)
	col[ncol - 1:0] <- c('total_dose1', 'total_dose2')
	
	return(col)
}

colnames(pfizer) <- shorten_colnames(pfizer)
colnames(moderna) <- shorten_colnames(moderna)

# Convert number values to numeric
vals <- gsub(',', '', as.matrix(pfizer[, -(1:2)]))
pfizer[, -(1:2)] <- ifelse(vals == 'N/A', 0, as.numeric(vals))
vals <- gsub(',', '', as.matrix(moderna[, -(1:2)]))
moderna[, -(1:2)] <- ifelse(vals == 'N/A', 0, as.numeric(vals))

summary(pfizer)
summary(moderna)

# Remove jurisdictions not receiving either of the vaccines
pfizer <- subset(pfizer, total_dose1 > 0)
moderna <- subset(moderna, total_dose1 > 0)

# Create a column to take notes of the asterisks in jurisdiction names

notes <- function(dat) {
	asterisks <- regmatches(dat[, 1], gregexpr('[*]', dat[, 1]))
	dat$notes <- NA
	for (i in seq_along(asterisks)) {
		notes <- paste(asterisks[[i]], collapse = '')
		dat$notes[i] <- ifelse(notes == '****', 'Federal entities',
			ifelse(notes == '***', 'Sovereign Nation Supplement',
			ifelse(notes == '**', 'Both doses received simultaneously',
			ifelse(notes == '*', 'No Pfizer', 'None'))))
	}
	return(dat)
}

pfizer <- notes(pfizer)
moderna <- notes(moderna)

# Remove asterisks in jurisdiction names
pfizer[, 1] <- gsub('( *)\\*', '', pfizer[, 1])
moderna[, 1] <- gsub('( *)\\*', '', moderna[, 1])

# Change region numbers to region names, which are taken from
# https://www.hhs.gov/about/agencies/iea/regional-offices/index.html
levels <- c('N/A', paste('Region', 1:10))
labels <- c('Federal Entities', 'Boston', 'New York', 'Philadelphia',
	'Atlanta', 'Chicago', 'Dallas', 'Kansas City', 'Denver', 'San Francisco',
	'Seattle')
pfizer[, 2] <- factor(pfizer[, 2], levels = levels, labels = labels)
moderna[, 2] <- factor(moderna[, 2], levels = levels, labels = labels)

summary(pfizer)
summary(moderna)

# Number of columns in each dataset
ncol_pf <- ncol(pfizer)
ncol_m <- ncol(moderna)

# DATA TRANSFORMATION --------------------

# Data merge
both <- merge(pfizer, moderna, by = c('jurisdiction', 'region', 'notes'),
	all = T, suffixes = c('_pf', '_m'))
colnames(both)
# Convert NAs to zeros
for (i in 4:ncol_pf) {
	both[, i] <- ifelse(is.na(both[, i]), 0, both[, i])
}
# Check
both[both$notes == 'No Pfizer',]   # no NAs
head(both)

# Total number of first doses
(dose1 <- colSums(both[, c('total_dose1_pf', 'total_dose1_m')]))
(total_dose1 <- sum(dose1))

# Total number of second doses
(dose2 <- colSums(both[, c('total_dose2_pf', 'total_dose2_m')]))
(total_dose2 <- sum(dose2))

# Differences between Pfizer doses and Moderna doses
diff(dose1)
diff(dose1) * 100 / sum(dose1)
diff(dose2)
diff(dose2) * 100 / sum(dose2)

# Grand total number of doses
(grand_total <- total_dose1 + total_dose2)

# Differences in number of doses
abs(dose1[1] - dose1[2])
abs(dose2[1] - dose2[2])

# Total number of doses by week
pfizer_byweek <- colSums(pfizer[, 3:(ncol_pf-3)])
pfizer_byweek <- colSums(matrix(pfizer_byweek, 2))
pfizer_byweek
moderna_byweek <- colSums(moderna[, 3:(ncol_m-3)])
moderna_byweek <- colSums(matrix(moderna_byweek, 2))
moderna_byweek
(total_byweek <- pfizer_byweek + c(0, moderna_byweek))
num_weeks <- length(total_byweek)
# Cumulative total
(total_byweek_cumsum <- cumsum(total_byweek))
# Percentage increase
(pcnt_increase <- diff(total_byweek_cumsum) * 100 / total_byweek_cumsum[-num_weeks])

# Average number of doses per week, excluding the first 2 weeks
mean(pfizer_byweek[-(1:2)])
mean(moderna_byweek[-1])

# Jurisdictions receving unequal numbers of first doses and of second doses
pfizer[pfizer[, ncol_pf-2] != pfizer[, ncol_pf-1], c(1, ncol_pf-(2:0))]
moderna[moderna[, ncol_m-2] != moderna[, ncol_m-1], c(1, ncol_m-(2:0))]

# Jurisdictions receiving both doses simultaneously
both$jurisdiction[both$notes == 'Both doses received simultaneously']

# Total number of first doses by values in notes and region columns combined
xtabs(total_dose1 ~ notes + region, pfizer)
xtabs(total_dose1 ~ notes + region, moderna)

# Total number of doses by region
(pfizer_byregion <- aggregate(pfizer[, ncol_pf-(2:1)],
	list(region = factor(pfizer[, 2], exclude = 'Federal Entities')), sum))
(pfizer_byregion_rowsums <- rowSums(pfizer_byregion[, -1]))
(moderna_byregion <- aggregate(moderna[, ncol_m-(2:1)],
	list(region = factor(moderna[, 2], exclude = 'Federal Entities')), sum))
(moderna_byregion_rowsums <- rowSums(moderna_byregion[, -1]))
(totals_byregion_rowsums <- pfizer_byregion_rowsums + moderna_byregion_rowsums)

# Total number of doses by jurisdiction
columns <- c('total_dose1', 'total_dose2')
pfizer_byjur <- rowSums(both[, paste0(columns, '_pf')])
moderna_byjur <- rowSums(both[, paste0(columns, '_m')])
totals_byjur <- pfizer_byjur + moderna_byjur
totals_byjur <- cbind(both[, c('jurisdiction', 'region')], 
	pfizer_byjur, moderna_byjur, totals_byjur)
colnames(totals_byjur)[3:5] <- c('pfizer', 'moderna', 'total')
head(totals_byjur)
nrow(totals_byjur)

# Total number of doses by state
totals_bystate <- merge(totals_byjur, fips_info(), by.x = 'jurisdiction', by.y = 'full')
head(totals_bystate)
(num_states <- nrow(totals_bystate))
# Order by decreasing total
totals_bystate_ordered <- totals_bystate[order(totals_bystate$total, decreasing = T),]
head(totals_bystate_ordered)

# DATA VISUALIZATION --------------------

# Function for saving plots as png files
# name: a descriptive name for the file (without the .png extension)
# w, h: width and height (in pixels) of the image

saveaspng <- function(name, w = 650, h = 480) {
	filename <- paste0('Plots/', name, '.png')
	png(filename, w, h)
}

# Plot of number of first doses and number of second doses ----------

saveaspng('numdoses', 480)
col <- c(rgb(1, 0, 0, .5), rgb(0, 0, 1, .5))
bp <- barplot(cbind(dose1, dose2), col = col, width = .5, space = .3,
	main = 'Allocations for First Doses Versus Allocations for Second Doses',
	names.arg = c('First dose', 'Second dose'), xlim = c(.12, 1.3),
	ylab = 'Number of doses (in millions)',
	ylim = c(0, max(total_dose1, total_dose2)*1.23), axes = F)
axis_ticks <- seq(0, max(total_dose1, total_dose2)*1.23, 5e6)
axis(2, at = axis_ticks, labels = axis_ticks/1e6)
legend('top', c('Pfizer', 'Moderna'), fill = col, ncol = 2, box.lwd = .3)
# Annotate plot
pcnt <- round(rbind(prop.table(dose1), prop.table(dose2))*100, 2)
ypos <- c(dose1[1]/2, dose2[1]/2, dose1[1]+dose1[2]/2, dose2[1]+dose2[2]/2)
text(bp, ypos, paste0(pcnt, '%'))
text(bp, c(total_dose1, total_dose2) + 8e5,
	paste(format(c(total_dose1, total_dose2)/1e6, digits = 4),
	      'million doses'))
dev.off()

# Plot of cumulative number of doses by week ----------

saveaspng('cumulativedosesbyweek', 600)
dates <- seq(as.Date('2020-12-14'), by = 'week', len = num_weeks)
col <- rgb(0, 1, 0, seq(.15, .35, len = num_weeks))
bp <- barplot(total_byweek_cumsum, col = col,
	main = 'Cumulative Total Number of Allocated Doses by Week',
	names.arg = format(dates, '%b %d'), xlab = 'Week of',
	ylab = 'Cumulative number of doses (in millions)',
	ylim = c(0, grand_total*1.1), axes = F)
axis_ticks <- seq(0, grand_total*1.1, 1e7)
axis(2, at = axis_ticks, labels = axis_ticks/1e6)
lines(bp, cumsum(pfizer_byweek), col = 'red', lw = 3.5, lty = 2,
	type = 'b', pch = 2, cex = 1.2)
lines(bp[-1], cumsum(moderna_byweek), col = 'blue', lw = 3.5, lty = 3, 
	type = 'b', cex = 1.2)
legend('topleft', c('Pfizer', 'Moderna'), col = c('red', 'blue'), lw = 3.5,
	lty = c('55', '27'), seg.len = 2.5, pch = 2:1, cex = 1.1, inset = .1,
	y.intersp = 1.3, box.lwd = .5)
# Annotate plot
text(bp[-1], total_byweek_cumsum[-1]+3e6,
	paste0(round(pcnt_increase, 2), '%\nincrease'))
dev.off()

# Plot of number of doses by region ----------

saveaspng('dosesbyregion', 900)
col <- hcl.colors(length(totals_byregion_rowsums), 'dynamic', .3)
bp <- barplot(totals_byregion_rowsums, col = col,
	main = 'Allocations of COVID-19 Vaccines Grouped by Region',
	names.arg = pfizer_byregion$region, xlab = 'Region',
	ylab = 'Number of doses (in millions)',
	ylim = c(0, max(totals_byregion_rowsums)*1.1), axes = F)
axis_ticks <- seq(0, max(totals_byregion_rowsums)*1.1, 1e6)
axis(2, at = axis_ticks, labels = axis_ticks/1e6)
lines(bp, pfizer_byregion_rowsums, col = 'red', lw = 3.5, lty = 2,
	type = 'b', pch = 2, cex = 1.2)
lines(bp, moderna_byregion_rowsums, col = 'blue', lw = 3.5, lty = 3, 
	type = 'b', cex = 1.2)
legend('topleft', c('Pfizer', 'Moderna'), col = c('red', 'blue'), lw = 3.5,
	lty = 2:3, cex = 1.1, inset = .08, y.intersp = 1.3, box.lwd = .5)
# Add explanatory text
text <- 'Region names are provided by the U.S. Department of Health and Human Services'
text <- paste(text, '(https://www.hhs.gov/about/agencies/iea/regional-offices/index.html).')
mtext(text, side = 1, line = 4, cex = .8, font = 3)
dev.off()

# Maps ----------

saveaspng('map-pfizer')
plot_usmap(data = totals_bystate, values = 'pfizer', color = 'blue') +
	scale_fill_continuous(low = '#fafaff', high = 'darkblue', name = 'Count',
	                      label = scales::comma) +
	labs(title = 'Allocations of Pfizer Vaccine',
	     subtitle = paste('Updated on', format(Sys.Date(), '%B %d, %Y')),
	     caption = sources[1]) +
	theme(legend.position = c(.9, .05), legend.text.align = 1,
	      legend.text = element_text(size = 10),
	      legend.title = element_text(size = 12),
	      plot.title = element_text(face = 'bold', size = 15, hjust = .5),
	      plot.subtitle = element_text(size = 10, hjust = .5))
dev.off()

saveaspng('map-moderna')
plot_usmap(data = totals_bystate, values = 'moderna', color = 'red') +
	scale_fill_continuous(low = '#fffafa', high = 'darkred', name = 'Count',
	                      label = scales::comma) +
	labs(title = 'Allocations of Moderna Vaccine',
	     subtitle = paste('Updated on', format(Sys.Date(), '%B %d, %Y')),
	     caption = sources[2]) +
	theme(legend.position = c(.9, .05), legend.text.align = 1,
	      legend.text = element_text(size = 10),
	      legend.title = element_text(size = 12),
	      plot.title = element_text(face = 'bold', size = 15, hjust = .5),
	      plot.subtitle = element_text(size = 10, hjust = .5))
dev.off()

saveaspng('map-totals')
plot_usmap(data = totals_bystate, values = 'total', color = 'green') +
	scale_fill_continuous(low = '#fafffa', high = 'darkgreen',
	                      name = 'Count', label = scales::comma) +
	labs(title = 'Allocations of COVID-19 Vaccines',
	     subtitle = paste('Updated on', format(Sys.Date(), '%B %d, %Y')),
	     caption = paste(sources, collapse = '\n')) +
	theme(legend.position = c(.9, .05), legend.text.align = 1,
	      legend.text = element_text(size = 10),
	      legend.title = element_text(size = 12),
	      plot.title = element_text(face = 'bold', size = 15, hjust = .5),
	      plot.subtitle = element_text(size = 10, hjust = .5))
dev.off()

saveaspng('map-totals-subset', 500)
plot_usmap(data = totals_bystate, values = 'total', color = 'yellow',
           labels = T, exclude = 'FL',
           include = c(.east_north_central, .northeast_region,
                       .south_atlantic)) +
	scale_fill_continuous(low = '#fffffa', high = 'orange',
	                      name = 'Count', label = scales::comma) +
	labs(title = 'Allocations of COVID-19 Vaccines for Some States',
	     subtitle = paste('Updated on', format(Sys.Date(), '%B %d, %Y')),
	     caption = paste(sources, collapse = '\n')) +
	theme(legend.position = c(.9, .05), legend.text.align = 1,
	      legend.text = element_text(size = 10),
	      legend.title = element_text(size = 12),
	      plot.title = element_text(face = 'bold', size = 15, hjust = .5),
	      plot.subtitle = element_text(size = 10, hjust = .5))
dev.off()