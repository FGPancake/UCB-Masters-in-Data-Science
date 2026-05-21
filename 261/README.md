# MIDS 261 Final Project
Flight Delay Classification final project for DATASCI 261

## Project Overview
This project develops a machine learning pipeline to predict U.S. domestic flight delays within a 2-hour prediction window, classifying delayed flights so air traffic controllers can be prepared before delays materialize.

We joined passenger flight records from the Department of Transportation (DOT) with weather observations from the National Oceanic and Atmospheric Administration (NOAA), using airport reference data and kriging interpolation to impute weather data across sparse station coverage. Significant class imbalance required us to prioritize recall-focused evaluation, using the F2 score as our primary metric alongside MAE.

We established a baseline XGBoost Regressor trained with sliding-window cross-validation, then evaluated multi-stage architectures pairing regressors with downstream classifiers, including 2-tiered XGBoost + Random Forest, 2-tiered XGBoost + MLP, and a multi-tower Deep Neural Network. Feature engineering included temporal aggregates (origin delay in the last 4 hours, average route delay), graph-based airport features (betweenness centrality, closeness centrality), and kriging-interpolated weather variables.

The best-performing model was a two-stage quantile XGBoost model, which concentrated classification efforts on identifying delays near the 15-minute delay threshold cutoff.