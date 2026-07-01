# Fuzzy Logic Relative Humidity Controller: Development & Optimization Analysis

## Overview
This repository explores the development and optimization of a Mamdani Fuzzy Inference System designed to predict Relative Humidity. 

**Note:** This repository is structured as a comparative discussion of different model architectures and optimization strategies, rather than a step-by-step tutorial. The goal is to highlight how membership function (MF) shape and placement impact the accuracy of environmental modeling based on real-world data.

## System Architecture
The core logic relies on the physical principle that relative humidity is driven by the relationship between ambient temperature and saturation temperature (dew point).
* **Dataset:** USA Meridian Meteorological Dataset
* **Inputs:** Dry Bulb Temperature (5 MFs) & Dew Point Temperature (5 MFs)
* **Output:** Relative Humidity (5 MFs)
* **Rule Base:** A comprehensive matrix of 25 diagonal Mamdani-style fuzzy rules using the AND (min) operator

---

## Model Comparisons & Discussion

The fuzzy logic controller was tested across three distinct iterations to isolate which variables improve predictive accuracy the most.

### Version 1: The Baseline (Even Triangular MFs)
* **Setup:** Membership functions were set as standard Triangles and distributed evenly across the entire temperature range.
* **Result:** Achieved a Mean Error of 27.99%.
* **Analysis:** This baseline proved too rigid. Because the ranges were partitioned evenly, the controller treated all temperature zones equally and failed to capture the high-density regions where most actual weather patterns occur. The resulting control surface consisted of large, flat planes that could not track complex fluctuations.

### Version 2: Shape Optimization (Even Gaussian MFs)
* **Setup:** Maintained the even distribution from Version 1, but changed the mathematical shape of the MFs to Gaussian (curved).
* **Result:** Reduced the Mean Error to 22.06%.
* **Analysis:** Gaussian functions inherently provide continuous gradients and smoother transitions. This allowed for a more natural overlap between the rules, replacing the rigid planes with a dynamic, wave-like control surface. While tracking improved significantly, the even distribution meant the system still struggled to catch sharp, sudden environmental spikes.

### Version 3: Placement Optimization (Targeted Density MFs)
* **Setup:** Reverted to Triangular MFs, but manually "compressed" their placement in the middle ranges (10°C to 25°C) to perfectly match the highest concentration of data points observed in the dataset.
* **Result:** Achieved the lowest final Mean Error of 19.95%.
* **Analysis:** This version tracked the real-world data most tightly. By simply adjusting the resolution to match the physical data density, the overall error dropped by an additional 8.04% compared to the baseline, without having to alter a single rule.

---

## Key Takeaways
The transition from Version 1 to Version 3 demonstrates a critical engineering principle in fuzzy modeling: **where you place the membership functions is actually more important than their mathematical shape**. A fuzzy logic system is most powerful when its resolution is strategically tuned to map the physical reality of the target dataset.

## Future Work
While the 25-rule diagonal matrix forms a solid foundation, a two-input temperature model has natural limitations. To build a more industrial-grade forecasting tool, the next iteration should integrate **Wind Speed** as a third environmental input. This would account for moisture displacement and help close the remaining gap in tracking extreme weather spikes.
