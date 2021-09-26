# Analyzing the Competitive Balance of Different Soccer Leagues

### Author and Project Information

- AUTHOR: [**TARA NGUYEN**](https://www.linkedin.com/in/nguyenthuyanh/)
- Project for the course *Exploratory Data Analysis and Visualization* at UCLA Extension
- Completed in December 2020

### Contents

- [Introduction](1.-Introduction)
  - [La Liga, the Premier League, and the Bundesliga](1.-Introduction#la-liga-the-premier-league-and-the-bundesliga)
  - [The Major League Soccer](1.-Introduction#the-major-league-soccer)
  - [The Current Project: Aim, Research Question, and Hypothesis](1.-Introduction#the-current-project-aim-research-question-and-hypothesis)
- [Data Wrangling](2.-Data-Wrangling)
  - [Data Sets Before Import Into R](2.-Data-Wrangling#data-sets-before-import-into-r)
  - [The Final Data Set](2.-Data-Wrangling#the-final-data-set)
- [Exploratory Data Analysis](3.-Exploratory-Data-Analysis)
  - [Numbers of Teams That Finished in the Top 4](3.-Exploratory-Data-Analysis#numbers-of-teams-that-finished-in-the-top-4)
  - [Points Per Game](3.-Exploratory-Data-Analysis#points-per-game)
  - [Win Proportions](3.-Exploratory-Data-Analysis#win-proportions)
  - [Points After Each Week in a Season](3.-Exploratory-Data-Analysis#points-after-each-week-in-a-season)
  - [Points Per Game and Win Proportions for Teams That Finished in the Top 4](3.-Exploratory-Data-Analysis#points-per-game-and-win-proportions-for-teams-that-finished-in-the-top-4)
  - [Comparing the Top 4 With Teams Outside the Top 4](3.-Exploratory-Data-Analysis#comparing-the-top-4-with-teams-outside-the-top-4)
- [K-Means Clustering of Teams Based on Performances](4.-K-Means-Clustering-of-Teams-Based-on-Performances)
  - [Cluster Sizes and Means](4.-K-Means-Clustering-of-Teams-Based-on-Performances#cluster-sizes-and-means)
  - [Visualization of the Clusters](4.-K-Means-Clustering-of-Teams-Based-on-Performances#visualization-of-the-clusters)
- [Conclusions and Final Thoughts](5.-Conclusions-and-Final-Thoughts)
  - [Which Soccer League is the Most Competitive?](5.-Conclusions-and-Final-Thoughts#which-soccer-league-is-the-most-competitive)
  - [Possible Explanations and Confounding Factors](5.-Conclusions-and-Final-Thoughts#possible-explanations-and-confounding-factors)

---

# Introduction

Soccer (or football), one of the most popular sports in the world, is well beloved for its excitement, competitiveness, and unpredictability. For long-time soccer fans like myself, a weekend with at least a soccer match to watch can be much more enjoyable than a weekend without. Personally, I love soccer not just because it is fun, but also because it allows me to experience a wide range of emotions, some of which I do not get to experience every day: joy when my favorite team (Liverpool) score, disappointment when they concede a goal, delight when they play well and win a match, anger when they play poorly and lose, anxiety when there are only a few minutes left in a tight match, and euphoria when they accomplish the seemingly unthinkable (like when they made [one of the greatest comebacks ever against Barcelona in the Champions League](https://www.youtube.com/watch?v=Ik-DhHJM8eo)).

Most (if not all) fans of the sport closely follow at least one of the many soccer competitions, from club-level leagues like the [English Premier League](https://www.premierleague.com/) (or simply the Premier League, or EPL for short) and the [La Liga](https://www.laliga.com/en-GB), to country-level tournaments like the [World Cup](https://www.fifa.com/worldcup/). Fans of one soccer league may argue that their favorite league is the best one in terms of excitement, unpredictability, and/or competitiveness. So which league really is the most competitive? The current project was carried out to answer this question. I chose to focus on competitions at the club level, due to their prevalence, prestige, and popularity.

## La Liga, the Premier League, and the Bundesliga

Of all soccer competitions, La Liga, the Premier League (EPL), and the Bundesliga are among the most popular ones. They are the top level of soccer competition in Spain, England, and Germany, respectively. They have been the [top three soccer leagues in the world](https://en.wikipedia.org/wiki/UEFA_coefficient#Top_leagues_by_period) since 2014. In each season of each league, which typically lasts from August to May, a fixed number of teams (20 in La Liga and in the EPL each, and 18 in the Bundesliga) compete. Teams finishing the top 4 will automatically qualify for the next season of the [Champions League](https://www.uefa.com/uefachampionsleague/) (one of the most prestigious soccer tournaments in the world), whereas teams finishing in the bottom 3 (or just 2 in the Bundesliga) will be relegated (i.e., they are no longer eligible to play in the next season).

In terms of popularity, these three leagues are among the [top 6 of all men's professional sports leagues when it comes to average game attendance](https://en.wikipedia.org/wiki/List_of_attendance_figures_at_domestic_professional_sports_leagues#Top_men's_leagues_in_total_attendance_with_a_minimum_of_8_million). The Bundesliga has the highest average attendance of the three, with 43,449 fans per game in the 2018/19 season, followed by 38,181 in the EPL and 26,811 in La Liga. All three leagues are broadcast worldwide.

## The Major League Soccer

Unlike in Europe, in the United States and Canada, soccer has most often been overlooked. The two countries share one top-level soccer competition, the Major League Soccer (MLS). Each regular season runs from February/March to October of the same year, with teams competing for the [Supporters' Shield](https://en.wikipedia.org/wiki/Supporters%27_Shield). Unlike in most other soccer leagues, in the MLS no team is relegated at the end of a season. The number of teams participating each season [has been increasing](https://en.wikipedia.org/wiki/Expansion_of_Major_League_Soccer) consistently, from 10 teams in its inaugural season in 1996 to 26 teams in the latest 2020 season, and will continue increasing at least until 2023.

Compared to the three European leagues, the MLS is less popular. In terms of average attendance, it ranks [10 in the world](https://en.wikipedia.org/wiki/List_of_attendance_figures_at_domestic_professional_sports_leagues#Top_men's_leagues_in_total_attendance_with_a_minimum_of_8_million) with 21,311 fans per game in Season 2019. In terms of broadcasts outside the U.S. and Canada, until 2019, [broadcasts of the MLS](https://en.wikipedia.org/wiki/Major_League_Soccer#Media_coverage) were limited to the United Kingdom, Ireland, and India.

## The Current Project: Aim, Research Question and Hypothesis

The aim of this project was to assess the competitive balance of the four soccer leagues: the Bundesliga, La Liga, the EPL, and the MLS. Competitive balance refers to the degree of uncertainty regarding the outcome of a competition. When it comes to major European leagues, this topic has received great attention both [in](../tree/main/References) and [outside](https://www.fearthewall.com/2019/7/8/20685467/the-state-of-the-league-comparing-the-bundesliga-with-its-competitors) academia. In comparison, competitive balance in the MLS has earned considerably less attention. With this project, I hoped to generate more interest in the MLS.

I analyzed team performances (points per game, win proportions, etc.) in the four soccer leagues across five seasons, from Season 2015/2016 to Season 2019/2020. The main research question was: **_Which soccer league is the most competitive?_**

Previous research has produced different findings on which European league is the most competitive (see the Introduction section of [Penn and Berridge's paper](../blob/main/References/Penn%20%26%20Berridge%2C%202019%20-%20competitive%20balance%20in%20the%20EPL.pdf) for a quick literature review), but the consensus seems to be that the competitive balance in these leagues is [decreasing over time](https://www.thestatszone.com/archive/how-competitive-are-the-top-five-european-leagues-13538) due to the growing dominance of the big clubs in each league, both in terms of on-the-pitch performance and off-the-pitch power and influence. Such dominance is less expected in the MLS, which, unlike the other three leagues, operates as a single entity in which the league ["owns all of the teams that play in the league"](https://caselaw.findlaw.com/us-1st-circuit/1441684.html). Therefore, I hypothesized that the MLS had at least as much competitive balance as the Bundesliga, La Liga, and the EPL.

# Data Wrangling

## Data Sets Before Import Into R

Data for the project came from https://www.transfermarkt.us/. For each season (from 2015/16 to 2019/20) of each of the [four leagues](1.-Introduction) (the Bundesliga, La Liga, the Premier League [EPL], and the Major League Soccer [MLS]), the following statistics were obtained:
1. Each team's season-end position
2. Number of matches played in the season
3. Number of wins each team got
4. Number of draws each team got
5. Number of losses each team got
6. Number of goals each team scored
7. Number of goals each team conceded
8. Number of total points each team got at the end of the season
9. Match results: whether or not each team won ("W"), drew ("D"), or lost ("L") each match in the season

All of the above statistics except #9 for all four leagues were saved in one [data set](../blob/main/all-leaguetables.xlsx). The statistics in #9 were collectively called a form table; for each league, there was one data set containing form tables for all five seasons (see the files whose names start with "`form-`" in the [main branch](../) of the repo).

Because team names in the original data were too long and contained characters unfamiliar to R (e.g., "á" and "é" in Spanish team names, or "ö" in German team names), they were modified before the data sets were imported into R.

## The Final Data Set

To create the [final data set](../blob/main/all-form-leaguetables.csv), first, the match results in the form tables into cumulative number of points after each week in a season, with 3 points awarded for a win, 1 point for a draw, and 0 point for a loss. Then, the new form tables were merged with the league table [data set](../blob/main/all-leaguetables.xlsx) and save as a [CSV file](../blob/main/all-form-leaguetables.csv) (see [R script](../blob/main/leaguesfinaldat_DataWrangling.R) in the repo).

The final [data set](../blob/main/all-form-leaguetables.csv) has 399 rows (observations) and 45 columns (variables). Each row contains the following information about a team in the four leagues from Season 2015/16 to Season 2019/20:

Index | Column/Variable name | Information
--- | --- | ---
1 | `league` | The league in which the team played
2 | `season` | The season in which the team played
3 | `position` | Season-end position; lower values means higher position
4 | `team` | Team name
5 | `matches` | Number of matches played;<br>`38` for La Liga and the EPL, or `34` for the Bundesliga and the MLS
6 | `wins` | Number of wins
7 | `points` | Number of total points at the end of the season
8 | `week1` | Number of points after the first week in the season; values `0`, `1`, or `3`
9 | `week2` | Number of points after the second week in the season
. | ...
41 | `week34` | Number of points after the 34th week in the season<br>This is the final week in the Bundesliga and the MLS; therefore there is no value for these two leagues from the next column on.
. | ...
45 | `week38` | Number of points after the 38th week in the season (final week in La Liga and the EPL)

# Exploratory Data Analysis

## Numbers of Teams That Finished in the Top 4

From Season 2015/16 to Season 2019/20, a total of 104 teams played across four leagues:
- 24 in the Bundesliga
- 27 in La Liga
- 24 in the Major League Soccer (MLS)
- 29 in the Premier League (EPL)

The following graph shows the number and percentage of teams that finished in the top 4 across the five seasons in each league. A small subset of teams have been dominating each of the three European leagues.
- In the Bundesliga, only 7 teams finished in the top 4. Bayern Munich won the league in all five seasons.
- In La Liga, only 6 teams finished in the top 4. Barcelona and Real Madrid were the only 2 teams that won the league.
- In the Major League Soccer, 12 teams finished in the top 4, four of which won the league from Season 2015/16 to Season 2019/20.
- In the Premier League, only 7 teams finished in the top 4, four of which won the league in the five seasons.

![numteams.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/numteams.png)

Before diving deeper into the statistics for the top 4, let's look at the statistics for all teams in each league. I focused on three statistics: points per game (computed by dividing the number of total points at the end of a season by the number of matches played that season), win proportion (computed by dividing the number of wins in a season by the number of matches played that season), and points after each week in a season.

## Points Per Game

Here is a graph of points per game (PPG) as a function of season-end position, averaged across seasons for each league. A more gradually declining line indicates that teams' performances are closer to one another, which in turn suggests that the league is more balanced. The MLS appears to be the most balanced, and the Bundesliga the least balanced. La Liga and the EPL are quite similar to each other in terms of competitive balance. PPG in the MLS is lower than those in the other leagues for the first 5 positions, but starts to surpass PPG in the Bundesliga at Position #6, and surpasses those in all the other leagues from Position #8 onward. This suggests that it is more difficult for the top teams in the MLS to earn points than it is for the tops teams in the European leagues, which in turn offers another piece of evidence for a higher level of competitive balance in the MLS.

![ppg-position.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/ppg-position.png)

To have a clearer picture of how close teams' performances were to one another, I computed the difference in PPG between each team and the team immediately below them in the season-end table. For example, for the team in the first place, this measure was computed by subtracting from their PPG the PPG of the team in the second place in the same season of the same league. The following graph shows the distribution of this measure for each league. A lower mean value indicates that teams' performances are closer to one another, which in turn suggests that the league is more balanced. Again, the MLS is the most balanced of all the leagues. This is true even if all the outliers (the dots in the graph) are removed.

![diffppg.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/diffppg.png)

Next we have the differences in PPG plotted against season-end position, with lower values suggesting more competitive balance. Most values are under .15, equivalent to either 1 win and 2 draws or 2 wins. In general, the values are lower for the MLS than for the other leagues, with only one value in the MLS above .15. This confirms what we have learned so far from the analyses: the MLS has the highest competitive balance. Also note that, for all leagues, the values for the top 2 teams are higher than those for the teams in the middle positions, suggesting that it is easier to tell apart top 2 teams from the rest than to tell the middle teams apart. This is more obvious for the European leagues (especially the Bundesliga) than for the MLS, which corroborates the claim that the MLS is the most balanced.

![diffppg-position.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/diffppg-position.png)

## Win Proportions

The results for win proportions were quite similar to those for PPG. The following graphs shows win proportions as a function of season-end position, averaged across seasons for each league. Similar to what we saw in the graph of PPG, here the line for the MLS has the most shallow slope, indicating that the performances of teams in this league, compared to those of teams in the other leagues, are the closest to one another. This in turn suggests that the MLS is the most balanced. Additionally, the win proportions in the MLS are lower than those in the other leagues for the first six positions, but are higher for the remaining positions. This suggests that the top teams in the MLS are less likely to win than are the top teams in the other leagues, which in turn is another piece of evidence for stronger competitive balance in the MLS.

![winprop-position.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/winprop-position.png)

Just like for PPG, for win proportions I computed the difference between every two teams that were adjacent in season-end positions, and then plotted the differences averaged across seasons for each league as a function of position (graph below). The graph tells a story similar to what we have seen from the other graphs (though it might be less clear here than it was from the graph of the differences in PPG): the MLS has the highest competitive balance. Most values are under .065, equivalent to more than 2 wins. Again, the values for the top 2 teams are higher than those for the teams in the middle positions, suggesting that it is easier to separate top 2 teams from the rest than to separate the middle teams from one another. This is especially true for the Bundesliga and the Premier League, indicating a lack of balance between the top 2 teams and the rest in each of these leagues.

![diffwinprop-position.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/diffwinprop-position.png)

## Points After Each Week in a Season

In the following four graphs, the number of points after each week in a season is plotted for each season-end position, averaged across all five seasons of each league. The closer the lines representing the positions are to one another, the higher the competitive balance. We can easily see that the MLS is the most balanced. In the European leagues, there is more balance among teams in the middle positions than either that between the top 2-3 teams and the rest or that between the bottom 3 teams and the rest. Furthermore, if we consider just the teams in the middle positions, the Bundesliga is the most unbalanced league.

![weekpts-bundesliga.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/weekpts-bundesliga.png)

![weekpts-laliga.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/weekpts-laliga.png)

![weekpts-mls.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/weekpts-mls.png)

![weekpts-epl.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/weekpts-epl.png)

Also in each graph are two vertical lines:
- The brown line denotes the earliest time at which it would be possible to tell who the top 2 teams of the season would be.
- The blueish line denotes the earliest time at which it would be possible to tell who would win the league.

The later time at which either of those two lines occurs (i.e., the further left of the graph they are), the smaller the gap between the top 2 teams and the rest, which in turn suggests higher competitive balance. We can see that the Bundesliga and the EPL are quite similar to each other. For La Liga, the brown vertical line occurs at Week #16, only one week earlier than when it occurs for the EPL. However, it only takes 3 weeks for the blueish line to occur for La Liga, indicating that the gap between the league champions and the other teams in the league usually manifests itself very early in a season. Notably, both of the vertical lines for the MLS occur later than those for the European leagues (though only by 1-2 weeks). Once again this suggests that the MLS is the most balanced.

## Points Per Game and Win Proportions for Teams That Finished in the Top 4

Let's now zoom in and look at only the top 4 positions in each season. Finishing in the top 4 is especially important for teams in the European leagues, because doing so will earn them a spot in the next season of the highly prestigious [Champions League](https://www.uefa.com/uefachampionsleague/). The next two graphs show the PPG and win proportions for these positions in each league, averaged across all five seasons. A higher bar indicates that it is more demanding to finish in that position. For a particular league, if the bars have relatively similar heights, that suggests higher competitive balance among the top 4.

![top4-ppg.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/top4-ppg.png)

![top4-winprop.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/top4-winprop.png)

Overall, finishing in the top 4 is the most difficult in the EPL, followed by La Liga, the Bundesliga, and finally the MLS, where it is pretty easy to finish in the top 4. The differences among the leagues are not big, though. To know the minimum PPG and minimum win proportion needed for a team to finish in the top 4, let's look at the statistics for the fifth position in each league (averaged across all five seasons):

League | PPG | Win proportion
--- | :---: | :---:
Bundesliga | 1.62 | .45
La Liga | 1.63 | .46
MLS | 1.60 | .45
EPL | 1.81 | .54

Thus, the race for the top 4 is indeed more demanding in the EPL than in the other leagues.

Another thing that the two top-4 graphs show us is that, as suggested by the similar heights of the bars, the competitive balance among the top 4 is the highest in the MLS. In La Liga it is also rather balanced, though not as much as it is in the MLS. In the Bundesliga and the EPL, there is quite an obvious gap between the top 2 teams and the other two, and an even bigger gap between the league champions and the runner-ups. This is consistent with what is shown in the graph of the differences in PPG and in that of the differences in win proportion.

## Comparing the Top 4 With Teams Outside the Top 4

Finally we have graphs comparing teams that finished in the top 4 with those that did not in terms of PPG and win proportion. In both graphs, the difference between the top-4 and the non-top-4 is the smallest in the MLS, again suggesting that this league is the most balanced. The other leagues are quite similar to one another.

![top4vsnontop4-ppg.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/top4vsnontop4-ppg.png)

![top4vsnontop4-winprop.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/top4vsnontop4-winprop.png)

# K-Means Clustering of Teams Based on Performances

For each league, k-means clustering was performed on all teams to put them into four clusters based on the points per game (PPG) and win proportions averaged across all five seasons for each season-end position.

## Cluster Sizes and Means

- Bundesliga

  Cluster ID | Size | Mean PPG | Mean win proportion
  :---: | :---: | :---: | :---:
  1 | 6 | 1.60 | .45
  2 | 7 | 1.18 | .30
  3 | 3 | .83 | .20
  4 | 2 | 2.26 | .69

- La Liga

  Cluster ID | Size | Mean PPG | Mean win proportion
  :---: | :---: | :---: | :---:
  1 | 4 | 1.62 | .46
  2 | 10 | 1.21 | .31
  3 | 3 | .78 | .18
  4 | 3 | 2.19 | .66

- Major League Soccer (MLS)

  Cluster ID | Size | Mean PPG | Mean win proportion
  :---: | :---: | :---: | :---:
  1 | 5 | .88 | .22
  2 | 3 | 1.81 | .53
  3 | 10 | 1.49 | .41
  4 | 6 | 1.19 | .32

- Premier League (EPL)

  Cluster ID | Size | Mean PPG | Mean win proportion
  :---: | :---: | :---: | :---:
  1 | 5 | 1.76 | .50
  2 | 9 | 1.21 | .32
  3 | 4 | .82 | .20
  4 | 2 | 2.33 | .73

## Visualization of the Clusters

![kmeans.png](https://github.com/tara-nguyen/soccer-competitiveness-k-means-clustering/blob/main/Plots/kmeans.png)

In each of the European leagues, the "best" cluster (i.e., one with the highest PPG and win proportions), each of which having two members, is far separated from the other clusters. This points toward the big gap between the top 2 teams and the other teams in these leagues. In the EPL, there is also a big gap between the "second-best" cluster (denoted by black circles) and the "third-best" one (denoted by red triangles), further demonstrating a lack of competitive balance in the league. In the Bundesliga and La Liga, the gaps among the "non-best" clusters are smaller and quite similar to one another. In comparison, in the MLS, the clusters are evenly separated, pointing toward a high level of competitive balance here.

# Conclusions and Final Thoughts

## Which Soccer League is the Most Competitive?

The main research question of this project was: **_Which soccer league is the most competitive?_** To answer this question, I analyzed team performances (focusing on points per game, win proportions, and points after each week in a season) in four leagues: the Bundesliga (in Germany), La Liga (in Spain), the Major League Soccer (MLS in the United States), and the Premier League (EPL in England). Both [exploratory data analysis](3.-Exploratory-Data-Analysis) and [k-means clustering](4.-K-Means-Clustering-of-Teams-Based-on-Performances) showed that the MLS is the most competitive, with the highest balance among teams.

The European leagues are quite similar to one another in terms of competitive balance. If I had to rank them, the Bundesliga would probably be the most unbalanced, followed closely by the EPL, and finally La Liga. The Bundesliga appears even more uncompetitive (and rather predictable) if we consider the fact that only one team (Bayern Munich) have won the Bundesliga in all five seasons (from 2015/16 to 2019/20). The EPL also lacks competitive balance and has, for the last decade, been dominated by a small subset of teams collectively known as ["The Big Six"](https://www.radiotimes.com/news/sport/football/2020-10-13/premier-league-big-6/). La Liga might be the least unbalanced of the three leagues, but it is still far from balance and lacks competitiveness, with only 22.22% of teams managing to [break into the top 4 positions](3.-Exploratory-Data-Analysis#numbers-of-teams-that-finished-in-the-top-4) and only two teams (Barcelona and Real Madrid) winning the league in all five seasons.

## Possible Explanations and Confounding Factors

The lack of competitive balance (as well as the [decrease thereof over the years](https://www.thestatszone.com/archive/how-competitive-are-the-top-five-european-leagues-13538)) in the European leagues has been attributed both to [improvements in performance of a few big clubs](https://www.thestatszone.com/archive/how-competitive-are-the-top-five-european-leagues-13538) (e.g., Bayern Munich, Barcelona, Real Madrid) and to the [quick financial growth](https://www.fearthewall.com/2019/7/8/20685467/the-state-of-the-league-comparing-the-bundesliga-with-its-competitors) of such clubs. The latter allows them to spend more money both on upgrading training facilities and on buying high-quality players, which in turn increases their success on the pitch.

With regard to the comparison between the European leagues and the MLS, the results might have been confounded by the fact that the MLS is played in a slightly different format from the other leagues. In the European leagues, teams face each of their opponents twice in a season, one at home and one away. In the MLS, teams are divided into the Eastern Conference and the Western Conference; teams play against each of their conference opponents twice, but face each of the teams from the other conference only once. Thus, if we define *competitive balance* as [the degree to which teams are evenly matched on their ability to win](https://voxeu.org/article/competition-and-sorting-evidence-bundesliga-football), then, for the MLS, it is impossible to measure competitive balance in its complete sense, because not all teams play against all other teams in the league the same number of times (twice). Future research should look for ways to tackle this issue and try to come up with a good measure of competitive balance in the MLS.
