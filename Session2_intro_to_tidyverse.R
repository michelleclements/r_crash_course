#' ---
#' title: "Crash course in R: Session 2 - intro to tidyverse"
#' author: "Michelle Clements"
#' date: "`r Sys.Date()`"
#' output:
#'    html_document:
#'      keep_md: true
#' ---
#' 
#+ setup, include=FALSE
knitr::opts_chunk$set(echo = T, warning = T, message = T)
#'
#' # Part 1: Last session recap
#' 
#'  
#' * RStudio  
#' * Vectors  
#' * Square brackets to subset  
#' * Functions - inbuilt (e.g. mean()) & user generated    
#' * Datasets  
#' * $ sign as a short cut for vectors in datasets  
#' 
#' 
#' # Do bigger animals sleep more?
#' 
#'  * We will use an inbuilt dataset, msleep, and tidyverse  
#'  * This session is data manipulation and summaries  
#'  * Next session is graphs  
#'  
#' 
#' # Part 2: Set up  
#' 
#' ### 2.1 Installing packages
#' 
#' * Install tidyverse with packages -> install  or `install.packages("tidyverse")`  
#' * Look at tidyverse on CRAN   
#' * Use the package devtools to install from github 
#' * Use install_version in devtools to install an old version  
#' 
#' ### 2.2 Initial set-up    
#' 
#' * Ctrl-shift-N to open new script  
#' * Load a package using library. good practice to put afterwards what it's for  
#' * `setwd()` to set working directory (same as global in Stata)  
#' * Note that file paths need forward slashes  
#' * Navigate to wd using files -> More -> go to working directory  
#' * Read in datafiles - we won't do this here but it's covered at the bottom  
#' * Instead we'll assign msleep to msleep  
#'
#'
#' *Load tidyverse* 
#' 
library(tidyverse)


#' *Set working directory* 
#' 
setwd("C:/")


#' *Get datafiles* 
#' 
msleep <- msleep

#' *Have a quick look with `glimpse()`* 
#' 
glimpse(msleep)




#'
#' # Part 3: Data manipulation   
#' 
#' ### 3.1 Datasets in tidyverse   
#' 
#' * Datasets in tidyverse are called `tribbles` 
#' * Tribbles are just a type of dataframe  
#' * Characters are never factors unless specified  
#' * I recommend keeping things in tribbles and not as random vectors - things are less likely to go wrong this way   
#' 
#' 
#' ### 3.2 Verbs for data manipulation  
#' 
#' * `select()` to select variables/columns (keep in Stata)   
#' * `filter()` to select rows (keep if in Stata)  
#' * `rename()` to rename columns (newname = oldname)  
#' * `mutate()` to create or alter new variables (gen and replace in Stata)  
#' * `arrange()` to sort  
#' 

#' 
#' ### 3.3 Manipulating msleep the long way  
#'
#' We are going to create a dataset:   
#' 
#' * Keep only rodents in rows (order is Rodentia)
#' * Keep only columns of name, vore, sleep_total and bodywt 
#' * Make vore into longform   
#' * Delete vore  
#' * Rename bodywt to body_weight  
#' * Arrange by body_weight  
#' 

rodents <- filter(msleep, order == "Rodentia")

rodents <- select(rodents, "name", "vore", "sleep_total", "bodywt")

rodents <- mutate(rodents, 
                  vore_long = ifelse(is.na(vore), NA, paste0(vore, "vore")))

rodents <- select(rodents, - vore)

rodents <- rename(rodents, body_weight = bodywt)  

rodents <- arrange(rodents, body_weight)

#' ### 3.4 Piping  
#' 
#' * Different commands can be piped together  
#' * Symbol is `%>%`, with shortcut ctrl-shift-M. I say 'and then'    
#' * Start with dataset, then pipe, then statement without dataset  
#' * Highlight from the beginning just to run the first bit  
#' 
#' * First two parts above as an example:  
#' 
#' 
#' 
rodents <- msleep %>% 
  filter(order == "Rodentia") %>% 
  select("name", "vore", "sleep_total", "bodywt") 


#' Exercise  
#' 
#' * Put all of the commands above into one piped command  
#' 
#' 
#' 
#' Solution  
#' 
#' 
rodents <- msleep %>% 
  filter(order == "Rodentia") %>% 
  select("name", "vore", "sleep_total", "bodywt") %>% 
  mutate(vore_long = ifelse(is.na(vore), NA, paste0(vore, "vore"))) %>% 
  select(- vore) %>% 
  rename(body_weight = bodywt)  %>% 
  arrange(body_weight)


#' Can also pass functions to piping  
#' Here we will do a correlation matrix of all numerics in rodents   
rodents %>% 
  select_if(is.numeric) %>% 
  cor()


#' # Part 4: group_by   
#' 
#' * `group_by()` to group the dataset  
#' * `ungroup()` to ungroup     
#' 


#' *dataset of lightest animal in each order *
light <- msleep %>% 
  arrange(bodywt) %>% 
  group_by(order) %>% 
  slice(1)

#' # Part 5: summarising
#' 
#' * `summarise()` to summarise  
#' *  `group_by()` often helpful here  

#' * create a summary table of number of obs and mean bodywt for each order*  
#' 
summ_wt <- msleep %>% 
  group_by(order) %>% 
  summarise(n = n(), 
            mean_wt = mean(bodywt))


#' Exercise  
#' 
#' * Create a summary table showing n() and max weight in each order and vore, ordered by descending max weight (desc())
#' 
#' 
#' 
#' Solution
summ_maxwt <- msleep %>% 
  group_by(order, vore) %>% 
  summarise(n = n(), 
            max_wt = max(bodywt)) %>% 
  arrange(desc(max_wt))


#' Useful things:
#' 
#' *count n for each order*
count(msleep, vore)

#' *count n for each order, with output sorted*
count(msleep, vore, sort = T)

#' # Part 5: joining  
#' 
#'  * `inner_join` keeps only rows with matchkeys found in both datasets
#'  * `left_join` keeps everything in the first dataset and merges on where possible  
#'  * use `by = ` to specify mergekey  
#'  * variables in both datasets not in `by` will automatically have `.x` and `.y` as suffixes, can change this if needed  
#'  * don't get a report like Stata, need to do checks by hand  
#'  
#' * merge mean weights onto msleep by order
msleep_wt <- msleep %>% 
  inner_join(summ_wt, by = "order")

#'  * use `assertthat` package to check number of rows in msleep and msleep_wt is the same 
#'  * need to have assertthat installed  
#'  * package and `::` lets you use package without 
assertthat::are_equal(nrow(msleep), nrow(msleep_wt))
#'        
#' 
#' # Part 6: pivoting
#' 
#' * `pivot_longer()` lets you go from wide to long  
#' * `pivot_wider()` lets you go from long to wide  
#' * The approach in R is generally longer than in Stata  
#' * Plotting sometimes requires really long datasets  

#'  *for each species in rodents, create a column that is 'metric' and one that is 'value' for body_weight and sleep_total  


rodents_long <- rodents %>% 
  pivot_longer(cols = c(sleep_total, body_weight), 
              names_to = "metric", 
              values_to = "value")


rodents_wide <- rodents_long %>% 
  pivot_wider(names_from = metric, values_from = value)


#' * to pivot long on multiple variables (x1, x2, y1, y2), you need to pivot really long, separate out the variable names, then pivot wide   
#' * in Stata: reshape long x y, i(id) j(t) string  
#' 
#' 
#' 
# example 1 - no separation between x & a
df <- tribble(~id,~xa,~xb,~ya,~yb,
              1,1,3,6,8,
              2,2,4,7,9)

df %>%
  # make all variable and timepoint columns long
  pivot_longer(cols = -id) %>%
  # pull t out of name, and make name just the variable 
  mutate(
    t = substr(name, 2, 2),
    name = substr(name, 1, 1) 
  ) %>% 
  # pivot wider on id and timepoint, putting in variables
  pivot_wider(id_cols = c(id, t))


# example 2 - x and a separated by _
df2 <- tribble(~id,~x_a,~x_b,~y_a,~y_b,
               1,1,3,6,8,
               2,2,4,7,9)

df2 %>%
  # make all variable and timepoint columns long
  pivot_longer(cols = -id, names_to = c("name", "t"), names_sep = "_") %>%
  # pivot wider on id and timepoint, putting in variables
  pivot_wider(id_cols = c(id, t))

#' # Part 7: reading in & writing out data  
#' 
#'  * use tidyverse `read_csv` to read in csvs  
#'  * use readxl `read_xlsx` to read in from excel  
#'  * use haven package `read_dta` to read in Stata files  
#'  * use tidyverse `write_csv` to write files out as csvs
#'  
#'  Potentially useful function for tidying up files that have been read in from Stata
fix_stata <- function(df){
  df %>% 
    # get rid of all variable labels
    zap_label() %>% 
    # make labelled vars into factors with labels as values
    map_if(is.labelled, ~as_factor(.x, levels = "default")) %>% 
    # make factors into characters
    map_if(is.factor, as.character) %>% 
    # make empty strings in characters NA
    map_if(is.character, zap_empty) %>% 
    # return a tibble
    as_tibble()
  
}


#' # Part 8: Further resources  
#' * The [R for Data Science](https://r4ds.had.co.nz/) book is great and available freely online  
#' * Useful parts linked to today's section are:   
#'      + Tibbles: Section 10  
#'      + Working directories & projects: Section 4  
#'      + Manipulating data: Section 5 
#'      + Pipe: Section 5.6.1 (more info in section 18) 
#'      + Merging: Section 13  
#'      + Pivoting: Sections 12.3 & 12.5  
#'      
#'      
#'  * Other sections that we didn't have time to cover are:    
#'      + String/character manipulation: Section 14  
#'      + Dates & times: Section 16  
 

#'
#' # Part 9: Upcoming  
#' * Session 3: Making graphs with ggplot2  