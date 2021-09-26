# Analysis of Match Statistics and Team Performances in the Premier League From Season 2015/16 to Season 2019/20

### Author and Project Information

- AUTHOR: [**TARA NGUYEN**](https://www.linkedin.com/in/nguyenthuyanh/)
- Final project for the course *Introduction to Data Science* at UCLA Extension
- Completed in December 2020

### Contents

- [Introduction](1.-Introduction)
  - [The Premier League](1.-Introduction#the-premier-league)
  - [The Current Project: Research Questions and Hypotheses](1.-Introduction#the-current-project-research-questions-and-hypotheses)
- [Data Wrangling](2.-Data-Wrangling)
  - [Data Set (Before Data Cleaning)](2.-Data-Wrangling#data-set-before-data-cleaning)
  - [Data Import and Cleaning](2.-Data-Wrangling#data-import-and-cleaning)
- [Exploratory Data Analysis](3.-Exploratory-Data-Analysis)
  - [Match Statistics](3.-Exploratory-Data-Analysis#match-statistics)
  - [Team Performances](3.-Exploratory-Data-Analysis#team-performances)
- [Classification of Full-Time Results Using Random Forests](4.-Classification-of-Full-Time-Results-Using-Random-Forests)
  - [Steps in the Modeling Process](4.-Classification-of-Full-Time-Results-Using-Random-Forests#steps-in-the-modeling-process)
  - [Model Results and Using the Model to Classify Full-Time Results in the Test Set](4.-Classification-of-Full-Time-Results-Using-Random-Forests#model-results-and-using-the-model-to-classify-full-time-results-in-the-test-set)
  - [Fine-Tuning the Model by Varying the Number of Variables Tried at Each Split](4.-Classification-of-Full-Time-Results-Using-Random-Forests#fine-tuning-the-model-by-varying-the-number-of-variables-tried-at-each-split)
  - [Variable Importance](4.-Classification-of-Full-Time-Results-Using-Random-Forests#variable-importance)
  - [Partial Dependence Plots](4.-Classification-of-Full-Time-Results-Using-Random-Forests#partial-dependence-plots)
- [Conclusions and Final Thoughts](5.-Conclusions-and-Final-Thoughts)
  - [Which Statistics Are the Most Predictive of Match Results?](5.-Conclusions-and-Final-Thoughts#which-statistics-are-the-most-predictive-of-match-results)
  - [The Home Advantage](5.-Conclusions-and-Final-Thoughts#the-home-advantage)

---

# Introduction

## The Premier League

The [English Premier League](https://www.premierleague.com/) (or simply the Premier League, or EPL for short) is the top level of competition in English soccer and is one of the most popular and most competitive events not just in soccer but also in sports in general. Each season typically lasts from mid-August to mid-May (with the exception of the 2019/20 season, which was postponed for three months due to COVID-19). Twenty teams compete for the trophy and the champions medals.

There is almost always a lot of discussion (sometimes even [heated debates](https://www.youtube.com/watch?v=iJTC3oTa-Aw)) on an EPL match both before the match begins and after it ends. Pundits, fans, and the general audience alike attempt to predict the outcome of the match, and afterward analyze what happened in the match. Pundits especially look at match statistics to explain the result, to assess whether a team played well or poorly, and to offer opinions on areas on which the team should maintain or improve. Typical match statistics include number of goals scored by each team, result at half-time, team formations, number of passes and passing accuracy, number of shots and shooting accuracy, goalkeepers' performances, number of defensive plays (e.g., tackles, interceptions, clearances), number of fouls committed, etc. Such statistics served as the data in the current project.

## The Current Project: Research Questions and Hypotheses

I analyzed match statistics in the EPL from the 2015/16 season to the 2019/20 season in order to answer the main research question:

### Which Statistics Are the Most Predictive of Match Results?

Because the result of a match is based on the number of goals each team score, naturally such statistics should be the most predictive. Other statistics were also expected to affect match results, such as which team scored first, how much possession of the ball each team had, and what the goal difference at half-time was.

### Other Questions Answered Along the Way

**Is there really a home advantage (i.e., the phenomenon where the home team perform better than the away/visiting team)? If so, which statistics display it the most clearly?** This phenomenon is well-known and well-researched in [sports like baseball](https://bleacherreport.com/articles/1803416-is-home-field-advantage-as-important-in-baseball-as-other-major-sports), but not so much in soccer. I expected that there should be some degree of home advantage in the EPL. A good piece of evidence for it would be a higher probability that the home team win after conceding first and/or after trailing at half-time, compared to such a probability for the away team.

**Across the 5 seasons covered in the dataset, which team formation was the most/least effective against which formation?** There are a wide range of [formations](https://en.wikipedia.org/wiki/Formation_(association_football)) used in soccer, each of which has several variations. Most teams change their formations from match to match (sometimes even during a match), depending on the availability and strength of their current squads and on who their opponents are. Therefore it is hard for a non-pundit like myself to tell which formation would be the most/least effective.

**Which matches were the most/least eventful?** The answers to these two questions are just as unpredictable as soccer itself. Sometimes you think a match will be boring and not worth watching but it turns out to be exciting and/or eventful; other times the reverse happens. That is what makes soccer so fun.

**Which team had the best/worst performance record across all 5 seasons?** In the past decade in the EPL, a small subset of teams collectively known as ["The Big Six"](https://www.radiotimes.com/news/sport/football/2020-10-13/premier-league-big-6/) have been dominating in (on-the-pitch) performance (as well as in off-the-pitch power and influence), so I expected these teams to have the best records in most match statistics. On the contrary, the teams that were relegated in each of the 5 seasons should have the worst records.

# Data Wrangling

The entire project was completed in R. Data were scraped directly from https://fbref.com/en/comps/9/Premier-League-Stats (see [R script](../blob/main/epldat5seasons_WebScraping.R) in the repo), by first reading the webpages containing fixture lists to obtain match reports, and then reading the webpage for each of the reports to obtain match statistics. The final data set was saved as a [CSV file](../blob/main/matchstats.csv).

## Data Set (Before Data Cleaning)

The [data set](../blob/main/matchstats.csv) has 1900 rows (observations) and 27 columns (variables). Each row contains the following information about a single match in the Premier League from Season 2015/16 to Season 2019/20:

Index | Column/Variable name | Information
--- | --- | ---
1 | `season` | The season in which the match was played
2 | `hometeam` | The home team
3 | `awayteam` | The away team
4 | `fulltime_res` | Full-time result (whether the home team won, the away team won, or it was a draw)
5 | `homegoals` | Number of goals scored by the home team
6 | `awaygoals` | Number of goals scored by the away team
7 | `scoredfirst` | The team that scored first; missing value if neither team scored
8 | `hafltime_res` | Result at half-time (whether the home team led, the away team led, or it was a draw)
9 | `halftime_goaldiff` | Difference between the number of goals scored by the home team and that by the away team at half-time
10 | `homeformation` | Home team formation
11 | `awayformation` | Away team formation
12 | `homepossession` | Proportion of the time the home team possessed the ball
13 | `awaypossession` | Proportion of the time the away team possessed the ball; equal to `1 - homepossession`
14 | `homepasses` | Number of passes made by the home team
15 | `awaypasses` | Number of passes made by the away team
16 | `homepass_acc` | The home team's passing accuracy
17 | `awaypass_acc` | The away team's passing accuracy
18 | `homeshots` | Number of shots taken by the home team
19 | `awayshots` | Number of shots taken by the away team
20 | `homeontarget` | Proportion of shots on target taken by the home team
21 | `awayontarget` | Proportion of shots on target taken by the away team
22 | `homesaves` | Proportion of shots on target that were saved by the home team goalkeeper
23 | `awaysaves` | Proportion of shots on target that were saved by the away team goalkeeper
24 | `homedefense` | Number of defensive plays by the home team; defined as the sum of the numbers of tackles, interceptions, and clearances by the home team
25 | `awaydefense` | Number of defensive plays by the away team; defined in the same way as `homedefense`
26 | `homebadplays` | Number of unsportsmanlike plays by the home team; defined as the sum of:<br>- the number of fouls committed by the home team;<br>- the number of [yellow cards](https://en.wikipedia.org/wiki/Fouls_and_misconduct_(association_football)#Misconduct) received by the home team;<br>- the number of [second yellow cards](https://en.wikipedia.org/wiki/Fouls_and_misconduct_(association_football)#Misconduct) received by a player of the home team, multipled by 3; and<br>- the number of [red cards](https://en.wikipedia.org/wiki/Fouls_and_misconduct_(association_football)#Misconduct) received by the home team, multiplied by 3
27 | `awaybadplays` | Number of unsportsmanlike plays by the away team; defined in the same way as `homebadplays`

## Data Import and Cleaning

The [data set](../blob/main/matchstats.csv) was [imported into R](../blob/main/epldat5seasons_Analysis.R) using the `read_csv()` function in the `readr` package, which turns the data set into a tibble for neat printing. The data were then cleaned in the two steps:
- Missing values in `scoredfirst` (134 in total, corresponding to 134 goalless matches) were replaced as `'neither'`.
- Four variables - `season`, `fulltime_res`, `scoredfirst`, and `halftime_res` - were converted to factors. The table below lists the levels of each of these factors.

Variable | Levels
--- | ---
`season` | `'2015/16'`, `'2016/17'`, `'2017/18'`, `'2018/19'`, `'2019/20'`
`fulltime_res` | `'home_win'`, `'draw'`, `'away_win'`
`scoredfirst` | `'home'`, `'neither'`, `'away'`
`halftime_res` | `'home_lead'`, `'draw'`, `'away_lead'`

# Exploratory Data Analysis

## Match Statistics

### Distribution of Match Results

From Season 2015/16 to Season 2019/20 of the Premier League (EPL), 1900 matches were played. Among them:
- 870 matches ended in a win for the home team
- 453 matches ended in a draw
- 577 matches ended in a win for the away team

In terms of results at half-time:
- The home team led in 639 matches
- The score was level in 788 matches
- The away team led in 473 matches

The following graph shows the distribution of full-time results grouped by half-time results. Here we start to see evidence for the [home advantage](1.-Introduction#other-questions-answered-along-the-way).
- If the home team led at half-time, 81% of the time they ended up winning the match, compared to only 5% for the away team.
- If the away team led at half-time, 72% of the time they ended up winning the match, compared to 11% for the home team.
- If the score was level at half-time, the home team were a bit more likely to win the match than were the away team (39% vs. 26%).

![fulltime-halftime-results](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/fulltime-halftime-results.png)

In the next graph, the left panel shows the number of matches in which the home team scored first, the number of goalless draws, and the number of matches in which the away team scored first. The right panel shows the distribution of full-time results grouped by which team scored first, which offers another piece of evidence for the home advantage.
- If the home team scored first, 76% of the time they ended up winning the match, compared to only 9% for the away team.
- If the away team scored first, 63% of the time they ended up winning the match, compared to 16% for the home team.

![fulltime-results-scoredfirst](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/fulltime-results-scoredfirst.png)

Looking at the distribution of full-time results grouped by half-time goal difference (graph below), we see that:
- The biggest lead a team had at half-time was by 5 goals. In fact, only in two out of the 1900 matches did this happen.
- If a team led by more than 2 goals at half-time, they always won the match. Otherwise, the team leading at half-time were always more likely to win the match than were the other team.

![fulltime-results-halftime-goaldiff](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/fulltime-results-halftime-goaldiff.png)

### Team Formations: the Most Commonly Used and the Most/Least Effective

Thirty-three unique [formations](https://en.wikipedia.org/wiki/Formation_(association_football)) were used, with the most popular being the 4-2-3-1 formation (4 defenders, 2 defensive midfielders, 3 attacking midfielders, and 1 forward/striker). This formation was used by the home team in 605 matches, and by the away team in 535 matches, much more often than any of the other formations. Next in order of decreasing popularity are the following formations:
- 4-3-3 (4 defenders, 3 midfielders, and 3 forwards)
- 4-4-2 (4 defenders, 4 midfielders, and 2 forwards) - a bit of trivia: this formation used to be the most popular in soccer up [until the early 2000s](https://www.theguardian.com/football/blog/2008/dec/18/4231-442-tactics-jonathan-wilson)
- 3-4-3 (3 defenders, 4 midfielders, and 3 forwards)

Only these four formations were considered for an assessment of the most/least effective formation, because there were too few matches in which any of the other formations was used either against one of the top 4 or against another formation. The following graph shows the distribution of full-time results grouped by combinations of home team formation and away team formation.

![formations](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/formations.png)

For the home team, the most effective strategy was to use 4-3-3 against 3-4-3, which led to a win 80% of the time. The least effective strategy was to use 4-4-2 when the away team either also used 4-4-2 or used 3-4-3. In these cases, the home team won only 29% and 28% of the time, respectively. Using 4-4-2 against 3-4-3 was even more detrimental in that 48% of the time the home team used this strategy, the away team ended up winning (compared to 38% of the time 4-4-2 was used against 4-4-2).

Correspondingly, for the away team, using 3-4-3 against 4-4-2 was the most effective, whereas using 3-4-3 against 4-3-3 was the least effective. Of the 25 matches in which the away team used the latter strategy, they won only 2 matches (8%).

The graph also offers a slight hint of the [home advantage](1.-Introduction#other-questions-answered-along-the-way) in that, regardless of which of the top 4 formations was used, the match ended in a win for the home team more often than it did for the away team (49% vs. 31%).

### Numeric Variables

The following graph contains box plots for each pair (home vs. away) of the numeric variables in the [data set](../blob/main/matchstats.csv). There does not seem to be any big difference between the home team and the away team here.

![numericvars1](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/numericvars1.png)

Let's look at a visualization of the correlation matrix. The proportion of ball possession and the number of passes were extremely highly correlated, and each of them correlated strongly to moderately with passing accuracy, the number of shots, and the number of defensive plays. The number of goals scored by the home team and that by the away team correlated strongly with the proportion of shots on target that were saved by the goalkeeper of the opponent team. Each of the goal statistics also correlated, albeit a bit weakly, with the proportion of shots on target. Both of the goal statistics correlated strongly with half-time goal difference.

![correlation-matrix](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/correlation-matrix.png)

The next graph is a pairwise scatterplot matrix of the numeric variables that would be included in the [random forest model to classify full-time results](4.-Classification-of-Full-Time-Results-Using-Random-Forests). We can see some separation of the data points by full-time results, thereby making the case for these variables to be used in the random forest classifier.

![scatterplot-matrix](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/scatterplot-matrix.png)

### Match Records

**Match with the highest number of goals scored by the home team**: 8 goals
- Manchester City v. Watford in Season 2019/20 - Manchester City won
  - This was also the **biggest win for a home team** and had the **highest goal difference at half-time** (5 goals).

**Match with the highest number of goals scored by the away team**: 9 goals
- Southampton v. Leicester City in Season 2019/20 - Leicester won
  - This was also the **biggest win for an away team**.

**Draws with the highest number of goals**: 6 goals (3 for each team)
- There were 14 such matches, so they will not be listed here.

**Biggest comeback after trailing at half-time**
- Fulham v. Brighton in Season 2018/19 - Fulham came back from a 2-goal deficit at half-time to win 4-2

**Most unbalanced ball possession**: .83 vs. .17
- Manchester City v. Swansea in Season 2017/18 - Manchester City won
  - This also had the **biggest difference in the number of accurate passes** (931 vs. 143, a difference of 788 passes)

**Win with the lowest proportion of ball possession**: .20 possession
- Burnley v. Liverpool in Season 2016/17 - Burnley won
  - This was also the **loss with the highest proportion of ball possession** (.80 possession).

**Match with the highest number of passes by both teams combined**: 1428 passes
- Manchester City (1008 passes) v. Chelsea (420 passes) in Season 2017/18 - Manchester City won

**Match with the lowest number of passes by both teams combined**: 616 passes
- Crystal Palace (315 passes) v. Norwich City (301 passes) in Season 2015/16 - Crystal Palace won

**Match with the highest number of shots by both teams combined**: 44 shots
- Manchester United (37 shots) v. Burnley (7 shots) in Season 2016/17 - the match ended in a draw

**Match with the lowest number of shots by both teams combined**: 5 shots
- Bournemouth (3 shots) v. Burnley (2 shots) in Season 2019/20 - Burnley won

**Win with the lowest number of shots on target**: 0 shots
- Crystal Palace v. Watford in Season 2016/17 - Crystal Palace won thanks to an own goal by a Watford player
- Newcastle v. Crystal Palace in Season 2018/19 - Crystal Palace won thanks to a successful [penalty kick](https://en.wikipedia.org/wiki/Penalty_kick_(association_football))

**Loss with the highest number of shots on target**: 14 shots
- Arsenal v. Manchester United in Season 2017/18 - Manchester United won

**Match with the biggest difference in number of shots on target**: a difference of 15 shots
- Tottenham Hotspur (15 shots) v. Swansea City (0 shot) in Season 2016/17 - Tottenham won

**Draw with the highest number of shots on target by both teams combined**: 14 shots
- Arsenal (11 shots) v. Southampton (3 shots) in Season 2015/16

**Match with the highest number of defensive plays by both teams combined**: 196 plays
- Sunderland (118 defensive plays) v. Leicester (78 defensive plays) in Season 2015/16 - Leicester won

**Match with the lowest number of defensive plays by both teams combined**: 47 plays
- Manchester City (18 defensive plays) v. Stoke City (29 defensive plays) in Season 2017/18 - Manchester City won

**Match with the highest number of unsportsmanlike plays by both teams combined**: 60 plays
- Aston Villa (29 unsportsmanlike plays) v. Crystal Palace (31 unsportsmanlike plays) in Season 2019/20 - Aston Villa won

**Match with the lowest number of unsportsmanlike plays by both teams combined**: 5 plays
- Burnley (2 unsportsmanlike plays) v. Arsenal (3 unsportsmanlike plays) in Season 2016/17 - Arsenal won

Even these match records offer a glimpse of the home advantage, with the home team in those matches almost always having better statistics than do the away team. Even when the home team had worse statistics(e.g., in the Burnley v. Liverpool match), the home team still prevailed in the end (except when Leicester won away against Sunderland in Season 2015/16, the season that saw the former win the league for the time ever).

## Team Performances

A total of 29 teams participated in the EPL from Season 2015/16 to Season 2019/20, but only 13 teams played in all five seasons. The following graph shows the distribution of wins, draws, and losses for each team across all the seasons in which they played. Unsurprisingly, the ["The Big Six"](https://www.radiotimes.com/news/sport/football/2020-10-13/premier-league-big-6/) - Arsenal (ARS), Chelsea (CHE), Liverpool (LIV), Manchester City (MCT), Manchester United (MU), and Tottenham (TOT) - had the highest win proportions.

![win-draw-loss](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/win-draw-loss.png)

Next we have the average number of times a team won after conceding first in a season. The graph show great evidence for the [home advantage](1.-Introduction#other-questions-answered-along-the-way): after having conceded first, most teams were more likely to win if the match was played at home than if it was played away.

![win-concfirst-seasonavg](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/win-concfirst-seasonavg.png)

Similarly, most teams were more likely to win at home than to win away after trailing at half-time.

![win-trailatht-seasonavg](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/win-trailatht-seasonavg.png)

For easier comparison, here are box plots of the proportion of times a team won at home vs. away after conceding first (left panel) and after trailing at half-time (right panel).

![win-homeadvantage-props](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/win-homeadvantage-props.png)

### Numeric Variables

The numeric statistics were averaged across matches for each team and then plotted as a function of where the matches were played (at home vs. away). The graph offers a hint of the home advantage: on average, when playing at home, compared to when playing away, teams scored more goals, conceded fewer goals, possessed the ball more, made slightly more passes, took more shots, and had to make both fewer defensive plays and fewer unsportsmanlike plays (probably due to fewer attacking plays from the opponents).

![numericvars2](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/numericvars2.png)

The match averages were also plotted as bar plots (see below), with each bar representing a team. It is again the "Big Six" that were superior in terms of ball possession, the number of passes, and the number of shots. For the other statistics, all teams were quite similar to one another.

![team-matchavg-possession](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-possession.png)
![team-matchavg-passes](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-passes.png)
![team-matchavg-pass_acc](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-pass_acc.png)
![team-matchavg-shots](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-shots.png)
![team-matchavg-ontarget](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-ontarget.png)
![team-matchavg-saves](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-saves.png)
![team-matchavg-defense](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-defense.png)
![team-matchavg-badplays](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/team-matchavg-badplays.png)

### Team Records

Teams with the **highest/lowest number of wins in a season**
- Highest: 32 wins - Liverpool in Season 2019/20; Manchester City in Seasons 2017/18 and 2018/19
- Lowest: 3 wins - Aston Villa in Season 2015/16; Huddersfield in Season 2018/19

Teams with the **highest/lowest average number of wins per season**
- Highest: 26.4 wins/season - Manchester City
- Lowest: 5 wins/season - Middlesbrough

eams with the **Thighest/lowest number of draws in a season**
- Highest: 15 draws - Southampton in Season 2017/18; Manchester United in Season 2016/17
- Lowest: 2 draws - Manchester City and Tottenham in Season 2018/19

Teams with the **highest/lowest average number of draws per season**
- Highest: 13 draws/season - Middlesbrough
- Lowest: 4 draws/season - Cardiff City

Teams with the **highest/lowest number of losses in a season**
- Highest: 28 losses - Huddersfield in Season 2018/19
- Lowest: 1 loss - Liverpool in Season 2018/19

Teams with the **highest/lowest average number of losses per season**
- Highest: 26 losses/season - Fulham
- Lowest: 5 losses/season - Liverpool

Teams with the **highest/lowest number of points in a season**
- Highest: 100 points (out of 114 points possible) - Manchester City in Season 2017/18
- Lowest: 16 points - Huddersfield in Season 2018/19

Teams with the **highest/lowest average number of points per season**
- Highest: 84.6 points/season - Manchester City
- Lowest: 26 points/season - Fulham and Aston Villa

Team with the **highest season-average number of wins after conceding first**
- 4 wins/season - Hull City

Team with the **highest season-average number of losses after scoring first**
- 4 losses/season - Fulham

Teams with the **highest season-average number of wins after trailing at half-time**
- 3 wins/season - Wolverhampton Wanderers

Team with the **highest season-average number of losses after leading at half-time**
- 2 losses/season - Aston Villa

Team with the **highest average number of clean sheets (i.e., matches without conceding) per season**
- 16.6 clean sheets/season - Manchester City

Teams with the **highest/lowest number of goals scored in a season**
- Highest: 106 goals - Manchester City in Season 2017/18
- Lowest: 22 goals - Huddersfield in Season 2018/19

Teams with the **highest/lowest number of goals conceded in a season**
- Highest: 81 goals - Fulham in Season 2018/19
- Lowest: 22 goals - Liverpool in Season 2018/19

Teams with the **highest/lowest goal difference in a season**
- Highest: a difference of 79 goals - Manchester City in Season 2017/18
- Lowest: a difference of -54 goals - Huddersfield in Season 2018/19

**Overall**: Manchester City and Liverpool had the best performance records, whereas Huddersfield and Fulham had the worst records. Expectedly, the latter two teams were relegated at the end of Season 2018/19.

# Classification of Full-Time Results Using Random Forests

## Steps in the Modeling Process

To answer the main research question (**_Which statistics are the most predictive of match results?_**), the random forest algorithm was used to classify full-time results. The modeling process consisted of the following steps:
1. The [data set](../blob/main/matchstats.csv) was first split into a training set and a test set using the ratio 70:30. This ratio was picked in consideration of the number of feature variables (9). As a result, the training set had 1330 rows and the test set had 570 rows.
2. A random forest classification model was run with full-time result as the response and the following variables as features:
    - number of goals scored by the home team
    - number of goals scored by the away team
    - which team scored first
    - goal difference at half-time
    - proportion of ball possession by the home team
    - proportion of shots on target taken by the home team
    - proportion of shots on target taken by the away team
    - proportion of shots on target that were saved by the home team goalkeeper
    - proportion of shots on target that were saved by the away team goalkeeper
3. The model was used to classify full-time results in the test set.
4. The number of variables tried at each split in the model was varied in an attempt to fine-tune the model.
5. Variable importance in the original model was examined.
6. Partial dependence plots for the three most important variables were examined.

## Model Results and Using the Model to Classify Full-Time Results in the Test Set

The `randomForest()` function in the `randomForest` package was used to run the model, with the default values unchanged. Thus, the number of trees was 500 and the number of variables tried at each split was 3. The out-of-bag (OOB) error estimate was .45%, with only 3 values in the OOB sample misclassified.

Here is a graph of error rates as a function of the number of trees. The error rates start to level off when the number of tree is about 70.

![randomforest-error-vs-ntree](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/randomforest-error-vs-ntree.png)

When the model was used to predict full-time results in the test set, the number of misclassifications was 2 and the error rate was .35%, so this seemed like a good model. The next step was to fine-tune it.

## Fine-Tuning the Model by Varying the Number of Variables Tried at Each Split

For each number of variables per split from 1 to 9 (the number of feature variables in the original model), a new random forest was generated and then used to classify the response values in the test set. Afterward, both the error rates in the test set and the OOB error estimates were plotted against the number of variables tried at each split.

![randomforest-finetune](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/randomforest-finetune.png)

With just 2 variables at each split, both the error rate in the test set and the OOB error estimate were below 1%. The error rate in the test set gets very close to zero when the number of variables is at least 4. To avoid overfitting, I retained the original model (with 500 trees and 3 variables at each split).

## Variable Importance

The variable importance plot shows that the number of goals scored by home team (`homegoals`) and the number of goals scored by the away team (`awaygoals`) were the most important variables in the model. The next most important variable was `scoredfirst` (which team scored first). Both the decrease in accuracy and the decrease in node impurities if this variable were omitted from the training set were much lower than if either `homegoals` or `awaygoals` were omitted. The other variables in the model had little importance compared to the top 3, with the proportion of ball possession by the home team (`homepossession`) barely having any importance at all.

![randomforest-varimportance](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/randomforest-varimportance.png)

With respect to the frequencies that variables were used in the random forest, `awaygoals` was used the most frequently (5971 times), followed closely by `homegoals` (5828 times). `scoredfirst`, despite being the third most important variable, was used the least frequently (1283 times).

## Partial Dependence Plots

Partial dependence plots were drawn for the three most important variables in the model: `homegoals`, `awaygoals`, and `scoredfirst`. Here is the plot for the first two variables:

![randomforest-partialdependence-numeric](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/randomforest-partialdependence-numeric.png)

The threshold for whether the number of goals enhanced or lowered the probability that a response was classed either as a home win or an away win seemed to be at 1 goal. Specifically, the probability of a match result being classified as a win either for the home team or for the away team decreased when the team in question scored at most 1 goal, and increased when the team scored more than 1 goal. Correspondingly, the probability of a match result being classified as a loss for a team increased when the team scored at most 1 goal, and decreased otherwise.

The probability of a match result being classified as a draw increased when either team scored fewer than 2 goals, and decreased very slightly otherwise.

Finally we have the partial dependence plot for the variable `scoredfirst`:

![randomforest-partialdependence-sf](https://github.com/tara-nguyen/english-premier-league-random-forest-analysis/blob/main/Plots/randomforest-partialdependence-sf.png)

Once again we can see evidence for the [home advantage](1.-Introduction#other-questions-answered-along-the-way). The increase in the probability of a match result being classified as a home win when the home team scored first was much larger than the increase in the probability of a match result being classified as an away win when the away team scored first. Similarly, the decrease in the probability of a match result being classified as a home win when the away team scored first was much smaller than the decrease in the probability of a match result being classified as an away win when the home team scored first.

# Conclusions and Final Thoughts

## Which Statistics Are the Most Predictive of Match Results?

In this project I looked at match statistics and team performances in the Premier League (EPL) from Season 2015/16 to Season 2019/20. The main research question was: **_Which statistics are the most predictive of match results?_** Random forests classifying match results were run to help answer this question, showing three feature variables that are important in predicting match results. In order of decreasing importance, they are: how many goals the home team scored, how many goals the away team scored, and whether it was the home team or the away team that scored first. This result was partly expected, considering that the result of a match is based on the difference in the number of goals scored by the two teams in the match. I was rather surprised to see that `scoredfirst` (which team scored first) was the third most important variable in the random forest, but that `halftime_goaldiff` (goal difference at half-time) was of little importance. One reason could be that the former was a categorical variable and the latter was a continuous variable. Perhaps if `halftime_res` (result at half-time) had been included in the model instead of `halftime_goaldiff`, it might have held some importance for the classification of full-time results.

## The Home Advantage

Exploratory data analysis suggested the presence of the [home advantage](1.-Introduction#other-questions-answered-along-the-way) in the EPL. Perhaps [the clearest piece of evidence](3.-Exploratory-Data-Analysis#team-performances) was that teams were more likely to win a match after conceding first or after trailing at half-time if the match was played at home than if it was played away. Because the home advantage in soccer does not appear to be as common as it is in other sports, research on this topic has been rather lacking. It would be nice to see future research take a close and extensive look at the topic.
