## Data geberation code

generate_dataset <- function(N=1000){
  
  age <- runif(N, min=10-3, max=10+6)
  alcohol <- rnorm(N, mean=20, sd=5)
  caffeine <- rnorm(N, mean=200, sd=80)
  smokes <-  rbinom(N, 2, .20)
  chocolates <- rnorm(N, mean=2, sd=.5)
  
  Caffeine_alcohol_index <- ( 0.1 * (alcohol) + .001 * (caffeine) + 
                                .03 * (smokes) + 0.02 * (chocolates) )
  
  video_games <- rbinom(N, 4, .70)
  television <- rbinom(N, 1, .40)
  games_played <- rbinom(N, 2, .53)
  leisure_time <- rnorm (N, mean = 7, sd = 2)
  
  Physical_activity_index <-  (0.10 * games_played + 0.25* leisure_time 
                               - .10 * video_games - .20 * television) 
  
  Physical_abuse <- sample(c("Y", "N"), N, replace=TRUE, prob=c(.34, .66))
  
  make <- c("Audi", "Camry", "Nissan", "Subaru", 
            "Honda", "BMW", "Acura", "Infinity")
  car <- sample(make, N, replace=TRUE)
  
  bad_family <- ifelse((Physical_abuse == 'Y'), 2,0) 
  
  headaches = floor(0.5 * age + 1.14 * Caffeine_alcohol_index 
                    - 0.7 * Physical_activity_index + bad_family)
  
  
  headaches[which(headaches <= 0)] = 0
  
  data.frame(age, alcohol, caffeine, smokes, chocolates,video_games, 
             television, games_played, leisure_time, Caffeine_alcohol_index, 
             Physical_activity_index,Physical_abuse, bad_family, car, 
             headaches)
  
}

df <- generate_dataset(1000)

# Plotting code

with(df, plot(age, headaches))

## Manipulate function to calculate coefficients 

library(manipulate)
manipulate({ 
  df <- transform(df, headaches = floor(a * age + b * Caffeine_alcohol_index 
                                        - c * Physical_activity_index + bad_family))
  
  plot(df$age , df$headaches)
}, a=slider(0, 10, step=0.1, initial = 0),b=slider(0, 10, step=0.01, initial = 0), 
c=slider(0, 10, step=0.1, initial = 0))


## code to write the dataframe in a csv file
dfnew <- df

colnames(dfnew) <- c("Age (in years)", "Alcohol intake per week (in mg)", 
                     "Caffeine intake per day (in mg)", "Smokes per week", 
                     "Chocolates per week","Video games owned", " No. tv sets in bedroom", 
                     " No. of physical games played", "Leisure time per week (in hours)",
                     "Caffeine_alcohol_index", "Physical_activity_index", 
                     "Physical abuse", "bad_family","Car make",
                     "No. of headaches per week" )

write.csv(dfnew,file="/Users/chamanpreetkaur/Desktop/data")

