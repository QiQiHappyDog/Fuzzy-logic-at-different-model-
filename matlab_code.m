% MEC3822 Lab 2 - Question 5: Fuzzy Logic Relative Humidity Prediction
% Dataset: 10-USA-Meridian
clc; clear; close all;

%% 1. Data Acquisition and Pre-processing
filename = '10-USA-Meridian.csv'; 
raw_data = readmatrix(filename);

% Extracting target columns based on datasheet: 
% Column 7: Dry Bulb Temp, Column 8: Dew Point Temp, Column 9: Relative Humidity
Dry_Bulb = raw_data(:, 7); 
Dew_Point = raw_data(:, 8); 
Relative_Humidity = raw_data(:, 9); 

% Data Cleaning: Remove non-numeric values (NaN) to prevent calculation errors
clean_idx = ~isnan(Dry_Bulb) & ~isnan(Dew_Point) & ~isnan(Relative_Humidity);
Dry_Bulb = Dry_Bulb(clean_idx);
Dew_Point = Dew_Point(clean_idx);
Relative_Humidity = Relative_Humidity(clean_idx);

%% 2. Part (a): Preliminary Study with Linear Best Fit Comparison
fprintf('\n--- Input Ranges for Fuzzy Logic Designer ---\n');
fprintf('Dry Bulb Range: [%.2f, %.2f]\n', min(Dry_Bulb), max(Dry_Bulb));
fprintf('Dew Point Range: [%.2f, %.2f]\n', min(Dew_Point), max(Dew_Point));
fprintf('Relative Humidity Range: [%.2f, %.2f]\n', min(Relative_Humidity), max(Relative_Humidity));

figure(1);
% Subplot 1: Dry Bulb vs Humidity with Linear Trendline
subplot(2,1,1);
scatter(Dry_Bulb, Relative_Humidity, 'b.', 'DisplayName', 'Actual Data'); 
hold on;
p1 = polyfit(Dry_Bulb, Relative_Humidity, 1); % Calculate linear coefficients
y_fit1 = polyval(p1, Dry_Bulb);
plot(Dry_Bulb, y_fit1, 'k-', 'LineWidth', 2, 'DisplayName', 'Best Fit Line');
title('Evidence: Dry Bulb Temperature vs Relative Humidity');
xlabel('Dry Bulb Temperature (C)'); ylabel('Relative Humidity (%)');
legend('show'); grid on;

% Subplot 2: Dew Point vs Humidity with Linear Trendline
subplot(2,1,2);
scatter(Dew_Point, Relative_Humidity, 'r.', 'DisplayName', 'Actual Data'); 
hold on;
p2 = polyfit(Dew_Point, Relative_Humidity, 1);
y_fit2 = polyval(p2, Dew_Point);
plot(Dew_Point, y_fit2, 'k-', 'LineWidth', 2, 'DisplayName', 'Best Fit Line');
title('Evidence: Dew Point Temperature vs Relative Humidity');
xlabel('Dew Point Temperature (C)'); ylabel('Relative Humidity (%)');
legend('show'); grid on;

%% 3. Part (b) & (c): Fuzzy Inference System Simulation
try
    % Load the tuned FIS model (ensure 'my_logic.fis' is in the workspace folder)
    fis_model = readfis('my_logic3.fis');
    
    % Execute simulation: Inputting environmental parameters into the Fuzzy Controller
    Simulated_Humidity = evalfis(fis_model, [Dry_Bulb, Dew_Point]);
    
    % Calculate Statistical Error Analysis
    Error_Difference = abs(Simulated_Humidity - Relative_Humidity);
    Percentage_Error = (Error_Difference ./ Relative_Humidity) * 100;
    Mean_Error = mean(Percentage_Error);
    
    % Part (b): Plotting Comparison between Real-world Data and Fuzzy Prediction
    figure(2);
    subplot(2,1,1);
    plot(Relative_Humidity, 'b', 'LineWidth', 1); hold on; 
    plot(Simulated_Humidity, 'r--', 'LineWidth', 1);
    title('Performance Comparison: Measured vs Fuzzy Predicted Humidity');
    legend('Measured Data','Fuzzy FIS Prediction'); grid on;
    ylabel('Relative Humidity (%)'); xlabel('Data Point Index');
    
    % Part (c): Error Distribution Plot
    subplot(2,1,2);
    plot(Percentage_Error, 'g');
    hold on;
    % Plot a constant line for Mean Percentage Error
    plot([1, length(Percentage_Error)], [Mean_Error, Mean_Error], 'r-', 'LineWidth', 2);
    title(['Error Analysis (Final Mean Percentage Error: ', num2str(Mean_Error, '%.2f'), '%)']);
    ylabel('Percentage Error (%)'); xlabel('Data Point Index');
    legend('Individual Error', 'Mean Error Line'); grid on;
    
    fprintf('\nSimulation Successful! Final Mean Error achieved: %.2f%%\n', Mean_Error);
catch
    fprintf('\n[Error] The file "my_logic.fis" was not detected.\n');
    fprintf('Check your file naming or export the FIS from Fuzzy Logic Designer.\n');
end