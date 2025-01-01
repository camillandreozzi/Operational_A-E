Operational Research for Hospital Sites
================

## Linear Mixed model

#### to analyze the variation of attendees by Site_Code, Month, and Year

``` r
library(lme4)
model.p <- lmer(n ~ Site_Code + (1|Month) + (1|Year), data = data.p)
summary(model.p)
```

    ## Linear mixed model fit by REML ['lmerMod']
    ## Formula: n ~ Site_Code + (1 | Month) + (1 | Year)
    ##    Data: data.p
    ## 
    ## REML criterion at convergence: 9045.7
    ## 
    ## Scaled residuals: 
    ##     Min      1Q  Median      3Q     Max 
    ## -2.9580 -0.2518 -0.0062  0.1520  3.3342 
    ## 
    ## Random effects:
    ##  Groups   Name        Variance Std.Dev.
    ##  Month    (Intercept)      0     0     
    ##  Year     (Intercept)      0     0     
    ##  Residual             822711   907     
    ## Number of obs: 558, groups:  Month, 12; Year, 4
    ## 
    ## Fixed effects:
    ##             Estimate Std. Error t value
    ## (Intercept)   2868.5      130.9  21.910
    ## Site_Code2    3058.7      185.1  16.520
    ## Site_Code3   -1866.0      185.1 -10.079
    ## Site_Code4    -381.9      166.8  -2.290
    ## Site_Code5    1814.3      185.1   9.799
    ## Site_Code6   -1508.1      185.1  -8.145
    ## Site_Code7    -132.5      184.2  -0.719
    ## Site_Code8     956.6      185.1   5.166
    ## Site_Code9   -2655.8      185.1 -14.344
    ## Site_Code10  -1142.6      185.1  -6.171
    ## Site_Code11   6493.5      185.1  35.072
    ## 
    ## Correlation of Fixed Effects:
    ##             (Intr) St_Cd2 St_Cd3 St_Cd4 St_Cd5 St_Cd6 St_Cd7 St_Cd8 St_Cd9
    ## Site_Code2  -0.707                                                        
    ## Site_Code3  -0.707  0.500                                                 
    ## Site_Code4  -0.785  0.555  0.555                                          
    ## Site_Code5  -0.707  0.500  0.500  0.555                                   
    ## Site_Code6  -0.707  0.500  0.500  0.555  0.500                            
    ## Site_Code7  -0.711  0.503  0.503  0.558  0.503  0.503                     
    ## Site_Code8  -0.707  0.500  0.500  0.555  0.500  0.500  0.503              
    ## Site_Code9  -0.707  0.500  0.500  0.555  0.500  0.500  0.503  0.500       
    ## Site_Code10 -0.707  0.500  0.500  0.555  0.500  0.500  0.503  0.500  0.500
    ## Site_Code11 -0.707  0.500  0.500  0.555  0.500  0.500  0.503  0.500  0.500
    ##             St_C10
    ## Site_Code2        
    ## Site_Code3        
    ## Site_Code4        
    ## Site_Code5        
    ## Site_Code6        
    ## Site_Code7        
    ## Site_Code8        
    ## Site_Code9        
    ## Site_Code10       
    ## Site_Code11  0.500
    ## optimizer (nloptwrap) convergence code: 0 (OK)
    ## boundary (singular) fit: see help('isSingular')

# Objective 1:

## Predicting the likelihood of a patient visiting a site using Random Forest

# Random Forest Classification Model

#### Confusion matrix to evaluate the model

    ## Confusion Matrix and Statistics
    ## 
    ##           Reference
    ## Prediction      1      2      3      4      5      6      7      8      9
    ##         1   32393    332      0     78    396     94    145    138      0
    ##         2    1413  68432      0   1097   3551    838   2717   2652      0
    ##         3       0      0  13298    863      0      0    328      0    182
    ##         4     669   2280    625  47576   3022    346   1107   5430    235
    ##         5    1144   5046      0   1290  46383    308    490   3041      0
    ##         6     537    455      0     61    182   9541     82   2173      0
    ##         7     861   3277    411    848   2562    216  33830    862    141
    ##         8     525   2466      0   4776   3575   5444    300  37698      0
    ##         9       0      0    128    100      0      0     92      0   2552
    ##         10    309   1589      0     94    329   2367    185   2214      0
    ##         11   3748   1492      0    389   7381    440   1020    846      0
    ##           Reference
    ## Prediction     10     11
    ##         1      42   4153
    ##         2    2914   6183
    ##         3       0      0
    ##         4     387   2713
    ##         5     532  11126
    ##         6    3560    199
    ##         7     303   3725
    ##         8    4742   1338
    ##         9       0      0
    ##         10  12061    900
    ##         11    241 104427
    ## 
    ## Overall Statistics
    ##                                           
    ##                Accuracy : 0.7509          
    ##                  95% CI : (0.7498, 0.7521)
    ##     No Information Rate : 0.2479          
    ##     P-Value [Acc > NIR] : < 2.2e-16       
    ##                                           
    ##                   Kappa : 0.7119          
    ##                                           
    ##  Mcnemar's Test P-Value : NA              
    ## 
    ## Statistics by Class:
    ## 
    ##                      Class: 1 Class: 2 Class: 3 Class: 4 Class: 5 Class: 6
    ## Sensitivity           0.77870   0.8016  0.91951  0.83216  0.68837  0.48693
    ## Specificity           0.98929   0.9534  0.99741  0.96543  0.95175  0.98617
    ## Pos Pred Value        0.85762   0.7621  0.90641  0.73887  0.66873  0.56825
    ## Neg Pred Value        0.98180   0.9627  0.99780  0.97997  0.95572  0.98092
    ## Prevalence            0.07653   0.1570  0.02660  0.10518  0.12396  0.03605
    ## Detection Rate        0.05959   0.1259  0.02446  0.08752  0.08533  0.01755
    ## Detection Prevalence  0.06949   0.1652  0.02699  0.11845  0.12760  0.03089
    ## Balanced Accuracy     0.88399   0.8775  0.95846  0.89879  0.82006  0.73655
    ##                      Class: 7 Class: 8 Class: 9 Class: 10 Class: 11
    ## Sensitivity           0.83954  0.68475 0.820579   0.48668    0.7749
    ## Specificity           0.97376  0.95258 0.999408   0.98460    0.9619
    ## Pos Pred Value        0.71924  0.61938 0.888579   0.60161    0.8703
    ## Neg Pred Value        0.98698  0.96405 0.998968   0.97570    0.9284
    ## Prevalence            0.07413  0.10128 0.005721   0.04559    0.2479
    ## Detection Rate        0.06224  0.06935 0.004695   0.02219    0.1921
    ## Detection Prevalence  0.08653  0.11197 0.005283   0.03688    0.2207
    ## Balanced Accuracy     0.90665  0.81866 0.909993   0.73564    0.8684

# Objective 2:

## Predicting Number of Patients Using Regression

### Creating a regression model based on distance, site type, month, and year

``` r
data.p <- data %>% group_by(Site_Code, Month, Year,
                            Site_Type, Pat_X, Pat_Y, Site_X, Site_Y) %>%
  summarise(n = n(), .groups = "keep")
```

##### Calculating the distance between patients and the site

``` r
data.p <- data.p %>% mutate(Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2))
```

# Random Forest Model

``` r
set.seed(1)
trainp.index <- sample.int(nrow(data.p), 0.6 * nrow(data.p))
trainp <- data.p[trainp.index,]
testp <- data.p[setdiff(1:nrow(data.p), trainp.index),]

model_n <- ranger(n ~ Distance + Site_Type + Month + Year, data = trainp, importance = "impurity")
```

![](md_data/unnamed-chunk-8-1.png)<!-- -->

### Plotting feature importance

![](md_data/unnamed-chunk-10-1.png)<!-- -->

## Trying Coordinates for new site (from heuristic method)

### Coordinates for new site

``` r
coord.new <- c(10640.01507538, 105690.53768844)
```

### Visualize impact

    ## Total Percentage Reduction of attendance to other sites: -0.06184625

![](md_data/unnamed-chunk-13-1.png)<!-- -->

# Optimization Random Forest

## Optimizing the location of a new site using optimization techniques and evaluating its impact

![](md_data/unnamed-chunk-14-1.png)<!-- -->

# Generalized Additive Model (GAM) for Prediction

### Using a Generalized Additive Model (GAM) to predict number of patients

### Evaluate and plot predictions

![](md_data/unnamed-chunk-16-1.png)<!-- -->

## Trying Coordinates for new site (from heuristic method)

### Visualize impact

    ## Total Percentage Reduction of attendance to other sites: -0.06100713

![](md_data/unnamed-chunk-18-1.png)<!-- -->

# Optimization GAM

## Optimizing the location of a new site using optimization techniques and evaluating its impact

``` r
evaluate_new_site_gam <- function(new_site_coords, data = data.p, total_patients = total_patients){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data$Month),
    Year = unique(data$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "ED" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model_gam, newdata = new_site, type = "response")
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute, #This is a proportional approach
           # so the percentage removed from each of the site is constant
           # no matter the new site location. The only thing changing
           # is the magnitude
           diff = new_n-n) 
  
  
  ## Compute Impact insights
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total
  
  return(impact)
}

# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))


objective_function <- function(coords, data, model, total_patients) {
  impact <- evaluate_new_site_gam(
    new_site_coords = coords,
    data = data,
    total_patients = total_patients
  )
  # Change this for maximization/minimization
  return(abs(impact))  # Maximize absolute value
}

optimal_continuous <- optim(
  par = c(mean(x_bounds), mean(y_bounds)),  
  fn = function(coords) -objective_function(coords, data.p, total_patients),  # Negative for maximization
  method = "L-BFGS-B",
  lower = c(x_bounds[1], y_bounds[1]),
  upper = c(x_bounds[2], y_bounds[2])
)

optimal_coords_gam <- data.frame(Site_X = optimal_continuous$par[1], Site_Y = optimal_continuous$par[2])
optimal_impact_gam <- -optimal_continuous$value  

list(coords = optimal_coords_gam, impact = optimal_impact_gam)
```

    ## $coords
    ##   Site_X Site_Y
    ## 1  33537 111593
    ## 
    ## $impact
    ## [1] 0.1738742

``` r
ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = optimal_coords_gam, aes(x = Site_X, y = Site_Y), col = "red", size = 3)
```

![](md_data/unnamed-chunk-19-1.png)<!-- -->

# Poisson Count Model

``` r
# Poisson regression is used because `n` is a count variable
model.glm <- glm(n ~ Site_Type + Month + Year + Distance, 
             data = data.p, 
             family = poisson(link = "log"))
# Summarize the model
summary(model.glm)
```

    ## 
    ## Call:
    ## glm(formula = n ~ Site_Type + Month + Year + Distance, family = poisson(link = "log"), 
    ##     data = data.p)
    ## 
    ## Coefficients:
    ##                      Estimate Std. Error   z value Pr(>|z|)    
    ## (Intercept)         5.907e+00  1.281e-03  4612.343  < 2e-16 ***
    ## Site_TypeMIU/OTHER -1.597e+00  2.752e-03  -580.318  < 2e-16 ***
    ## Month.L             9.428e-02  2.604e-03    36.202  < 2e-16 ***
    ## Month.Q            -8.612e-02  2.582e-03   -33.353  < 2e-16 ***
    ## Month.C            -4.167e-02  2.577e-03   -16.172  < 2e-16 ***
    ## Month^4             5.168e-02  2.582e-03    20.017  < 2e-16 ***
    ## Month^5             1.096e-02  2.590e-03     4.233 2.31e-05 ***
    ## Month^6             2.130e-03  2.597e-03     0.820    0.412    
    ## Month^7            -1.680e-02  2.574e-03    -6.527 6.72e-11 ***
    ## Month^8             4.444e-02  2.564e-03    17.334  < 2e-16 ***
    ## Month^9             8.580e-04  2.565e-03     0.335    0.738    
    ## Month^10            1.005e-02  2.549e-03     3.942 8.10e-05 ***
    ## Month^11            1.808e-02  2.543e-03     7.109 1.17e-12 ***
    ## Year.L              2.043e-01  1.499e-03   136.339  < 2e-16 ***
    ## Year.Q              5.687e-02  1.488e-03    38.211  < 2e-16 ***
    ## Year.C             -1.093e-02  1.484e-03    -7.361 1.83e-13 ***
    ## Distance           -1.586e-04  1.403e-07 -1129.996  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## (Dispersion parameter for poisson family taken to be 1)
    ## 
    ##     Null deviance: 4967402  on 34772  degrees of freedom
    ## Residual deviance: 2476745  on 34756  degrees of freedom
    ## AIC: 2621704
    ## 
    ## Number of Fisher Scoring iterations: 6

## Trying Coordinates for new site (from heuristic method)

Visualize Impact

    ## Total Percentage Reduction of attendance to other sites: -0.05302561

![](md_data/unnamed-chunk-23-1.png)<!-- -->

# Optimization Poisson Model

## Optimizing the location of a new site using optimization techniques and evaluating its impact

``` r
evaluate_new_site_glm <- function(new_site_coords){
  new_x <- new_site_coords[1]
  new_y <- new_site_coords[2]
  
  unique_patients <- unique(data.p[, c("Pat_X", "Pat_Y")])
  unique_time <- expand.grid(
    Month = unique(data.p$Month),
    Year = unique(data.p$Year)
  )
  new_site <- merge(unique_patients, unique_time)
  new_site <- cbind(new_site,
                    Site_Code = "12",
                    Site_X = new_x,
                    Site_Y = new_y,
                    Site_Type = "ED" 
  )
  
  new_site <- new_site %>% mutate(
    Distance = sqrt((Pat_X - Site_X)^2 + (Pat_Y - Site_Y)^2),
    n = 0
  )
  
  new_site$n <- predict(model.glm, newdata = new_site, type = "response")
  
  total_new_site <- sum(new_site$n)
  total <- sum(data.p$n)
  to.redistribute <- total - total_new_site
  
  # Step 3: Analyze the impact of adding the new site
  data.p <- data.p %>%
    mutate(new_n = n / total * to.redistribute,
           diff = new_n-n) 
  
  # Proportionally remove patients from other sites (this could be done in other
  # ways depending on distance)
  
  # Summarize the results
  # Compare original `n` with adjusted `n`
  impact_summary <- data.p %>%
    group_by(Site_Code) %>%
    summarise(diff = sum(diff), percentage_diff = diff/n())
  impact <- sum(impact_summary$diff) / total
  return(impact)
}
# Define bounds for the search 
x_bounds <- c(min(data.p$Pat_X), max(data.p$Pat_X))
y_bounds <- c(min(data.p$Pat_Y), max(data.p$Pat_Y))

objective_function <- function(coords, data, total_patients) {
  impact <- evaluate_new_site_glm(
    new_site_coords = coords
  )
  # Change this for maximization/minimization
  return(abs(impact))  # Maximize absolute value
}

optimal_continuous <- optim(
  par = c(mean(x_bounds), mean(y_bounds)),  
  fn = function(coords) -objective_function(coords),  # Negative for maximization
  method = "L-BFGS-B",
  lower = c(x_bounds[1], y_bounds[1]),
  upper = c(x_bounds[2], y_bounds[2])
)

optimal_coords_glm <- data.frame(Site_X = optimal_continuous$par[1], Site_Y = optimal_continuous$par[2])
optimal_impact_glm <- -optimal_continuous$value  

list(coords = optimal_coords_glm, impact = optimal_impact_glm)
```

    ## $coords
    ##   Site_X Site_Y
    ## 1  33537 111593
    ## 
    ## $impact
    ## [1] 0.1693906

``` r
ggplot(data.p)+
  geom_point(aes(x = Site_X, y = Site_Y), col = "darkgreen", size = 2)+
  geom_point(aes(x = Pat_X, y = Pat_Y), col = "black", alpha =0.6)+
  geom_point(data = optimal_coords_glm, aes(x = Site_X, y = Site_Y), col = "red", size = 3)
```

![](md_data/unnamed-chunk-24-1.png)<!-- -->

# Final Comparison

    ##   Site_X Site_Y Model
    ## 1  33537 111593   GLM
    ## 2  33537 111593    RF
    ## 3  33537 111593   GAM

![](md_data/unnamed-chunk-25-1.png)<!-- -->
