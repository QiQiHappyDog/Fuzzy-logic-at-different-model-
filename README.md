# Fuzzy Logic Relative Humidity Controller: Development & Optimization Analysis

## Overview
[cite_start]This repository explores the development and optimization of a Mamdani Fuzzy Inference System designed to predict Relative Humidity[cite: 62]. **Note:** This repository is structured as a comparative discussion of different model architectures and optimization strategies, rather than a step-by-step "how-to" guide. 

[cite_start]By analyzing the performance of three different model versions against a real-world meteorological dataset, this project highlights how membership function (MF) shape and placement impact the accuracy of environmental modeling[cite: 390].

## System Architecture
[cite_start]The core logic relies on the physical principle that relative humidity is driven by the relationship between ambient temperature and saturation temperature[cite: 147].
* [cite_start]**Dataset:** USA Meridian Meteorological Dataset[cite: 6].
* [cite_start]**Inputs:** Dry Bulb Temperature (5 MFs) & Dew Point Temperature (5 MFs)[cite: 63].
* [cite_start]**Output:** Relative Humidity (5 MFs)[cite: 63].
* [cite_start]**Rule Base:** A comprehensive matrix of 25 diagonal Mamdani-style fuzzy rules using the AND (min) operator[cite: 144, 145].

---

## Model Comparisons & Discussion

We tested the fuzzy logic controller across three distinct iterations to isolate what variables improve predictive accuracy the most.

### Version 1: The Baseline (Even Triangular MFs)
* [cite_start]**Setup:** Membership functions were set as standard Triangles and distributed evenly across the entire temperature range[cite: 117].
* [cite_start]**Result:** Achieved a Mean Error of 27.99%[cite: 118].
* [cite_start]**Analysis:** This baseline proved too rigid[cite: 391]. [cite_start]Because the ranges were partitioned evenly, the controller treated all temperature zones equally and failed to capture the high-density regions where most actual weather patterns occur[cite: 120]. [cite_start]The resulting control surface consisted of large, flat planes that could not track complex fluctuations[cite: 182, 183].

### Version 2: Shape Optimization (Even Gaussian MFs)
* [cite_start]**Setup:** Maintained the even distribution from Version 1, but changed the mathematical shape of the MFs to Gaussian (curved)[cite: 122].
* [cite_start]**Result:** Reduced the Mean Error to 22.06%[cite: 124].
* [cite_start]**Analysis:** Gaussian functions inherently provide continuous gradients and smoother transitions[cite: 127]. [cite_start]This allowed for a more natural overlap between the rules, replacing the rigid planes with a dynamic, wave-like control surface[cite: 128, 211, 214]. [cite_start]While tracking improved, the even distribution meant the system still struggled to catch sharp, sudden environmental spikes[cite: 343, 344].

### Version 3: Placement Optimization (Targeted Density MFs)
* [cite_start]**Setup:** Reverted to Triangular MFs, but manually "compressed" their placement in the middle ranges (10°C to 25°C) to perfectly match the highest concentration of data points observed in the dataset[cite: 45, 137, 263, 393].
* [cite_start]**Result:** Achieved the lowest final Mean Error of 19.95%[cite: 138].
* [cite_start]**Analysis:** This version tracked the real-world data most tightly[cite: 384]. [cite_start]By simply adjusting the resolution to match the physical data density, the overall error dropped by an additional 8.04% compared to the baseline, without altering a single rule[cite: 264].

---

## Key Takeaways
[cite_start]The transition from Version 1 to Version 3 demonstrates a critical engineering principle in fuzzy modeling: **where you place the membership functions is actually more important than their mathematical shape**[cite: 260]. [cite_start]A fuzzy logic system is most powerful when its resolution is strategically tuned to map the physical reality of the target dataset[cite: 265].

## Future Work
[cite_start]While the 25-rule diagonal matrix forms a solid foundation, a two-input temperature model has natural limitations[cite: 395]. [cite_start]To build a more industrial-grade forecasting tool, the next iteration should integrate **Wind Speed** as a third environmental input to account for moisture displacement, closing the remaining gap in tracking extreme weather spikes[cite: 36, 37, 396, 397].
