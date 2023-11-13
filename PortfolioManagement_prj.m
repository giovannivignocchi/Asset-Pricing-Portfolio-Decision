%  ----------------------  GENERAL PLOT SETTINGS  ----------------------

% Asset statistics summary
barchart_adj_facecolour = "#000080";
barchart_adj_width = 0.7;
barchart_noadj_facecolour = "#C5E7F3";
barchart_noadj_facealpha = 0.4;
chart_size_factor = 0.2;
barchart_sbj_premium = '#00807C';


%  ---------------------  RETURN TRANSFORMATION SETTING--------------------

% Specific premium for target asset
%
% INDA
% We add a additional premium to the monthly return to the INDA ETF to factor
% in our subjective believes that the indian market will growth
% substaintially in the next years.
%
% ICLN
% We add a additional  premium to the monthly return to the ICLN ETF to factor
% in our subjective believes that the renewable sector will growth
% substaintially in the next years.

sbj_premium_ticker = ["INDA", "ICLN"];
sbj_premium_amount = [ 0.002, 0.0015];


% Penalisation factor associated with the different years
%                      2016   2017   2018   2019  covid   2021-2023
period_start_month = [   12     01     01     12     02     10];
period_start_year =  [ 2015   2017   2018   2018   2020   2021];
period_end_month =   [   01     01     01     02     10     05];
period_end_year =    [ 2017   2018   2019   2020   2021   2023];
period_weight =      [0.700  0.800  0.900  1.000  0.500  1.000];

weight_table = table(period_start_month', period_start_year', period_end_month', period_end_year',  period_weight','VariableNames', {'Month_Start', 'Year_Start', 'Month_End', 'Year_End', 'Weight'});


%  ---------------------  RETURN TRANSFORMATION SETTING--------------------

% Annual Risk free return (U.S. 10 Year Treasury Note @ 13/06/2023)
last_rf_return = 0.038;

% OBSERVATION STEP - Frequency with wich we observe prices in the dataset ("Yearly", "Monthly", "Weekly", "Daily").
observation_step = "Monthly";


% -----------------------------  UPLOAD DATA  -----------------------------
% 
% The files Excel need to be stored in the same follder where the MATLAB
% script is. In order to run the script is necessary to have two files:
% 
% 1) PRICE FILE - The excel file need to have the following format:
%
% |     DATE     |  S&P500 | Asset_1 | Asset_2 | ... | Asset_n |
% |  01/01/2020  |   0.13  |   22.2  |   21.9  | ... |   12.8  |    
% |  01/02/2020  |   0.14  |   21.2  |   23.9  | ... |    9.6  | 
% |  01/03/2020  |   0.15  |   20.5  |   22.5  | ... |   11.1  |
%
% - Dataset composed of historical prices (use dot for decimal for MATLAB compatibility)
% - Historical prices in descending order
% - First column is the date of the prices (header needs to be DATE)
% - Second column is reserved for the risk-free rate
% - Third column is reserved for S&P500 (Market Price)
%
% The parameter 'observation_step' needs to be tuned accordingly with the
% PRICE FILE uploaded.
%
% 2) FAMA-FRENCH FILE - The excel file need to have the following format
%
% |     DATE     | MKT-RF |  SMB  |  HML  |  RMW  |  CMA  |   RF  |
% |  01/01/2020  |  0.13  |  22.2 |  21.9 |  45.7 |  12.8 |  12.8 |    
% |  01/02/2020  |  0.14  |  21.2 |  23.9 |  35.9 |   9.6 |  13.7 | 
% |  01/03/2020  |  0.15  |  20.5 |  22.5 |  36.8 |  11.1 |  14.9 |
%

fprintf('\n--- SET UP PORTFOLIO OPTIMIZATION  ---\n');

% Import PRICE DATA
price = readtable("Price Dataset.xlsx");
disp('PRICE DATA IMPORT: SUCCESSFULL');

% Convert cell values to double
columnNames = price.Properties.VariableNames;
for i = 1:numel(columnNames)
    if columnNames{i} ~= "DATE"
        column = price.(columnNames{i});
        price.(columnNames{i}) = cellfun(@str2double, column);
    end
end

% Get the tickers of the assets (first is the date, Secondo is S&P500)
asset_tickers = price.Properties.VariableNames;
asset_tickers = asset_tickers(:,3:end);

% Get the number of total assets
number_of_assets = length(asset_tickers);
disp(['ASSET UNDER ANALYSIS: ', num2str(number_of_assets)]);

% First and last observation date for prices
first_date = price.DATE(1);
last_date = price.DATE(end);
disp(['FIRST PRICE OBSERVATION: ', char(first_date)]);
disp(['LAS PRICE OBSERVATION:   ', char(last_date)]);

% Import FAMA-FRENCH DATA
FF = readtable("FF Dataset.xlsx");
disp('FAMA FRENCH DATA IMPORT: SUCCESSFULL');

% ---------------------------  COMPUTE RETURNS  --------------------------- 

% Compute continuous returns (assets - start at column )
returns = log(price(2:end,2:end) ./ price(1:end-1,2:end));

% Array with the date where the price data are reported (1st point excluded)
returns_observation_date = price.DATE(2:end);


% -----------------------  COMPUTE ADJUSTED RETURNS  ----------------------
% We want to adjust the historical returns in order to:
%
% 1) Factor in our subjective analysis of the market and future trends.
%   Specifically giving a premium to the ETF tracking Indian market and the
%   renewable market as we believe these market will undergo a substantial
%   growth in the future.
%
% 2) Penalise past observations: adjusting returns to give different weights 
%    to more recent observation and penalis years during covid-19.

fprintf('\n\n--- COMPUTE ADJUSTED RETURNS ---');
adjusted_returns = returns;

% 1) --- Adjust returns considering investor's view
fprintf('\n1) SUBJECTIVE PREMIUM FACTORS\n');

sbj_prem_vector = zeros(number_of_assets,1);
sbj_premium = table(asset_tickers', sbj_prem_vector, 'VariableNames', {'Ticker', 'Premium'});
for i=1:numel(sbj_premium_ticker)
    sbj_premium(matches(sbj_premium.Ticker,sbj_premium_ticker(i)),:).Premium = sbj_premium_amount(i);
end

for i = 1:height(sbj_premium)
    ticker = sbj_premium.Ticker{i};
    premium = sbj_premium.Premium(i);
    if ismember(ticker, adjusted_returns.Properties.VariableNames)
        adjusted_returns.(ticker)= adjusted_returns.(ticker) + premium;
    end
    disp(['- ' ticker ': ' num2str(premium)])
end

% 2) --- Penalise past observations
fprintf('\n2) YEAR PENALISATION FACTORS\n');
disp('|   Begin   |    End    |   Weight   |')
for i = 1:height(weight_table)
    period_month_start = weight_table.Month_Start(i);
    period_month_end = weight_table.Month_End(i);
    period_year_start = weight_table.Year_Start(i);
    period_year_end = weight_table.Year_End(i);
    w = weight_table.Weight(i);
    str = sprintf('|  %i-%2.i  |  %i-%2.i  |    %.3f   |', period_year_start, period_month_start, period_year_end, period_month_end, w);
    disp(str)
end

% 2.1) Compute the weights associated with the differnt years
years_penalisation_factors = compute_years_penalisation_factors(returns_observation_date, weight_table);

% 2.2) Compute the weights associated with the differnt years
adjusted_returns = adjusted_returns .* years_penalisation_factors';

% Asset Returns - Transform table into array to streamline computations
adjusted_returns_assets = table2array(adjusted_returns(:,2:end));
returns_assets = table2array(returns(:,2:end));

% S&P500 Returns - Transform table into array to streamline computations
adjusted_returns_SEP500 = table2array(adjusted_returns(:,1));
returns_SEP500 = table2array(returns(:,1));


% ----------------------  PLOT RETURNNS S&P500  ------------------------

figure();
hold on

% Plot returns S&P500 and S&P500 Adjusted
plot(returns_observation_date, returns_SEP500, 'b')
plot(returns_observation_date, adjusted_returns_SEP500, 'r') 

% Vertical lines to highlight the different periods
max_ret = max(max(returns_SEP500),max(adjusted_returns_SEP500));
for p=1:height(weight_table)
    % Plot the vertical line
    p_month_s = weight_table.Month_Start(p);
    p_year_s  = weight_table.Year_Start(p);
    p_month_e = weight_table.Month_End(p);
    p_year_e  = weight_table.Year_End(p);
    p_weight = weight_table.Weight(p);
    xl = xline(datetime(p_year_s, p_month_s, 1), '-');
    % Plot the Weight associated to the time interval
    p_title = sprintf('%.3f', p_weight);
    middle_date = mean([datetime(p_year_s, p_month_s, 1), datetime(p_year_e, p_month_e, 1)]);
    text(middle_date, max_ret + 0.005, p_title, 'VerticalAlignment', 'bottom', 'HorizontalAlignment', 'center');
    xl.LabelVerticalAlignment = 'top';
end

% Chart Customisation
title('Returns S&P500 - Real vs Adjusted');
ylabel('Return');
legend('Real Return', 'Adjusted Return', 'Location', 'southwest');

% S&P500 Adjusted return statistics
adj_sep500_sr_month = (mean(adjusted_returns_SEP500) - last_rf_return/12) / sqrt(var(adjusted_returns_SEP500));
adj_sep500_sr_year = (mean(adjusted_returns_SEP500) * 12 - last_rf_return/12) / (sqrt(12) * sqrt(var(adjusted_returns_SEP500)));
fprintf('\n\n--- S&P500 ADJUSTED ---\n');
disp(['EXPECTED RETURN: ', num2str(mean(adjusted_returns_SEP500))]);
disp(['STD. DEV:        ', num2str(sqrt(var(adjusted_returns_SEP500)))]);
disp(['SHARPE RATIO MONTH:    ', num2str(adj_sep500_sr_month)]);
disp(['SHARPE RATIO YEAR:    ', num2str(adj_sep500_sr_year)]);

% S&P500 return statistics
sep500_sr_month = (mean(returns_SEP500) - last_rf_return/12) / sqrt(var(returns_SEP500));
sep500_sr_year = (mean(returns_SEP500) * 12 - last_rf_return/12) / (sqrt(12) * sqrt(var(returns_SEP500)));
fprintf('\n\n--- S&P500 REAL ---\n');
disp(['EXPECTED RETURN:    ', num2str(mean(returns_SEP500))]);
disp(['STD. DEV:           ', num2str(sqrt(var(returns_SEP500)))]);
disp(['SHARPE RATIO MONTH: ', num2str(sep500_sr_month)]);
disp(['SHARPE RATIO YEAR : ', num2str(sep500_sr_year)]);

% 6) ------------------  COMPUTE SUMMARY STATISTICS ------------------ 

% 6.1) Expected Returns
expected_ret = mean(adjusted_returns_assets);
expected_ret_no_adj = mean(returns_assets);

% 6.2) Sample Variance
asset_variance = var(adjusted_returns_assets);
asset_variance_no_adj = var(returns_assets);

% 6.3) Standard Deviation
asset_stddev = sqrt(asset_variance);
asset_stddev_no_adj = sqrt(asset_variance_no_adj);

% 6.4) Sample VarianceCovariance Matrix
cov_matrix = shrinkage_cov(adjusted_returns_assets);

% 6.5) Correlation Matrix
corr_matrix = corrcoef(adjusted_returns_assets);
corr_matrix_no_adj = corrcoef(returns_assets);


% 6) ---------------------  PLOT SUMMARY STATISTICS --------------------- 
% Create a table to sort Asset by descending Expected return
asset_stats = table(asset_tickers', expected_ret', expected_ret_no_adj', asset_variance', asset_variance_no_adj', asset_stddev', asset_stddev_no_adj');
asset_stats.Properties.VariableNames = {'Ticker', 'Exp_Ret', 'Exp_Ret_No_Adj', 'Var', 'Var_No_Adj', 'StdDev', 'StdDev_No_Adj'};

% EXPECTED RETURNS REAL vs ADJUSTED RETURN
    % Plot Expected returns
    figure;
    hold on;
    bar(asset_stats.Exp_Ret_No_Adj,'FaceColor', barchart_noadj_facecolour, 'FaceAlpha', barchart_noadj_facealpha);
    bar(asset_stats.Exp_Ret, 'BarWidth', barchart_adj_width, 'FaceColor', barchart_sbj_premium);
    bar(asset_stats.Exp_Ret - sbj_premium.Premium,'BarWidth', barchart_adj_width,'FaceColor', barchart_adj_facecolour);

    % Add value labels on top of each bar
    for i = 1:number_of_assets
        difference = ( asset_stats.Exp_Ret(i) - asset_stats.Exp_Ret_No_Adj(i)) / asset_stats.Exp_Ret_No_Adj(i) * 100;
        y_location = max(asset_stats.Exp_Ret_No_Adj(i), asset_stats.Exp_Ret(i));
        if difference > 0
            difference_txt = sprintf('+%.2f', difference);
            text(i, y_location, difference_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7, 'Color', '#22B24F');
        else
            difference_txt = sprintf('%.2f', difference);
            text(i, y_location, difference_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7, 'Color', 'r');
        end
    end

    % Chart customisation
    title('Assets Expected Return - Real vs Adjusted');
    ylabel('Expected Return');
    set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
    xtickangle(90)
    legend('Expected Return', 'Subjective Additional Premium', 'Adjusted Expected Return', 'Location', 'northwest');
    chart_lower_border = min(0,min(min(asset_stats.Exp_Ret_No_Adj), min(asset_stats.Exp_Ret)));
    chart_upper_border = max(max(asset_stats.Exp_Ret_No_Adj), max(asset_stats.Exp_Ret));
    ylim([chart_lower_border*(1+chart_size_factor), chart_upper_border*(1+chart_size_factor)]);
    grid on;

% EXPECTED ADJUSTED RETURNS
    figure;
    hold on;
    bar(asset_stats.Exp_Ret, 'BarWidth', barchart_adj_width, 'FaceColor', barchart_adj_facecolour);
    
    % Chart customisation
    title('Assets Expected Return');
    ylabel('Expected Return');
    set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
    xtickangle(90)
    chart_lower_border = min(0,min(asset_stats.Exp_Ret));
    chart_upper_border = max(asset_stats.Exp_Ret);
    ylim([chart_lower_border*(1+chart_size_factor), chart_upper_border*(1+chart_size_factor)]);
    grid on;

% STANDARD DEVIATION REAL vs ADJUSTED RETURN
    % Plot Standard Deviation
    figure;
    hold on;
    bar(asset_stats.StdDev_No_Adj,'FaceColor', barchart_noadj_facecolour, 'FaceAlpha', barchart_noadj_facealpha);
    bar(asset_stats.StdDev, 'BarWidth', barchart_adj_width, 'FaceColor', barchart_adj_facecolour);

    % Add value labels on top of each bar
    for i = 1:number_of_assets
        difference = ( asset_stats.StdDev(i) - asset_stats.StdDev_No_Adj(i)) / asset_stats.StdDev_No_Adj(i) * 100;

        y_location = max(asset_stats.StdDev_No_Adj(i), asset_stats.StdDev(i));
        if difference > 0
            difference_txt = sprintf('+%.2f', difference);
            text(i, y_location, difference_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7, 'Color', 'r');
        else
            difference_txt = sprintf('%.2f', difference);
            text(i, y_location, difference_txt, 'HorizontalAlignment', 'center', 'VerticalAlignment', 'bottom', 'FontSize', 7, 'Color', '#22B24F');
        end
    end

    % Chart customisation
    title('Asset Std. Deviation - Real vs Adjusted');
    ylabel('Std. Deviation');
    set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
    xtickangle(90)
    legend('Adjusted Std Deviation', 'Std Deviation', 'Location', 'northwest');
    ylim([0, max(max(asset_stats.StdDev_No_Adj), max(asset_stats.StdDev))*(1+chart_size_factor)]);
    grid on;

% STANDARD DEVIATION ADJUSTED RETURN
    figure;
    bar(asset_stats.StdDev, 'BarWidth', barchart_adj_width, 'FaceColor', barchart_adj_facecolour);
    
    % Chart customisation
    title('Assets Std. Deviation');
    ylabel('Std. Deviation');
    set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
    xtickangle(90)
    ylim([0, max(asset_stats.StdDev)*(1+chart_size_factor)]);
    grid on;

% VARIANCE COVARIANCE MATRIX
    figure;
    min_cov_matrix = min(min(cov_matrix));
    max_cov_matrix = max(max(cov_matrix));
    hm = heatmap(asset_tickers, asset_tickers, cov_matrix);
    colormap(turbo)
    clim([0, max_cov_matrix*1.2]);
    hm.Title = "Variance-Covariance Matrix";
    hm.ColorbarVisible = 'off';
    hm.CellLabelFormat = '%.4f';

% CORRELATION MATRIX
    % Correlation Matrix - adjusted returns
    figure;
    hm = heatmap(asset_tickers, asset_tickers, corr_matrix);
    clim([-1, 1]);
    colormap(turbo)
    hm.Title = "Correlation Matrix";
    hm.ColorbarVisible = 'off';
    hm.CellLabelFormat = '%.2f';

    % Correlation Matrix - adjusted returns vs real returns
    figure;
    corr_diff = (corr_matrix - corr_matrix_no_adj) ./ corr_matrix_no_adj * 100;
    hm = heatmap(asset_tickers, asset_tickers, corr_diff);
    colormap(white);
    clim([-max(abs(corr_diff(:))) max(abs(corr_diff(:)))]);
    hm.Title = "Correlation Change(%) - Real vs Adjusted";
    hm.ColorbarVisible = 'off';
    hm.CellLabelFormat = '%.2f';

% 7) ------------------------  GVMP NO CONSTRAINTS -----------------------
% We set up the optimization procedure to minimise the variance without 
% imposing any contrains

GMVP_uncons_weights = minimise_variance(cov_matrix, [], [], [], []);
GMVP_uncons_expret = GMVP_uncons_weights * expected_ret';
GMVP_uncons_stddev = sqrt(GMVP_uncons_weights * cov_matrix * GMVP_uncons_weights');

fprintf('\n\n--- GVMP NO CONSTRAINTS  ---\n');
disp(['EXPECTED RETURN: ', num2str(GMVP_uncons_expret)]);
disp(['STD. DEV: ', num2str(GMVP_uncons_stddev)]);

% Plot weights of the GMVP NO CONSTRAINTS
figure;
bar(GMVP_uncons_weights, 'FaceColor', barchart_adj_facecolour);
title('Weights GMVP NO CONSTRAINTS');
set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
xtickangle(90)
grid on;

% 8) -----------------------  GVMP FULLY INVESTED ------------------------

Dummy_weights = ones(1,number_of_assets);
GMVP_fi_weights = Dummy_weights * inv(cov_matrix) / (Dummy_weights * inv(cov_matrix) * Dummy_weights');
GMVP_fi_expret = GMVP_fi_weights * expected_ret';
GMVP_fi_stddev = sqrt(GMVP_fi_weights * cov_matrix * GMVP_fi_weights');

fprintf('\n\n--- GVMP FULLY INVESTED ---\n');
disp(['EXPECTED RETURN: ', num2str(GMVP_fi_expret)]);
disp(['STD. DEV: ', num2str(GMVP_fi_stddev)]);

% Plot weights of the GMVP FULLY INVESTED
figure;
bar(GMVP_fi_weights, 'FaceColor', barchart_adj_facecolour);
title('Weights GMVP FULLY INVESTED');
set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
xtickangle(90)
grid on;

% ----------------  PLOT THE EFFICIENT FRONTIER AND ASSET  ----------------

% Compute the efficient frontier
efficient_frontier = compute_frontier(expected_ret, cov_matrix, 0, 0.0001, 0.15);

% Plot the efficient forntier
figure;
plot(efficient_frontier.StdDev, efficient_frontier.Exp_Ret, 'b')
ylabel('Expected Return');
xlabel('Std. Deviation');
title('Assets in the Mean-Variance Space');
xlim([-0.05, 0.2]);
ylim([-0.05, 0.2]);

% Plot the Assets in the Mean-variance Space
for i=1:height(asset_stats)
    hold on;
    plot(asset_stats.StdDev(i), asset_stats.Exp_Ret(i), 'ro', 'MarkerSize', 4);
    text(asset_stats.StdDev(i), asset_stats.Exp_Ret(i), cell2mat(asset_stats.Ticker(i)), 'VerticalAlignment', 'bottom', 'FontSize', 6);
end

% 9.a&c) --------------------  3 EFFICIENT PORTFOLIOS -------------------

number_of_efficient_portfolios = 3;

% Select target returns that lies between the expexcet return
% of the GMVP and the highest expected return associated with one of the
% assets. Needed to create a step variable in order to avoid to  pick the return 
% associated with the GMVP as target return.
min_exp_ret = GMVP_fi_expret;
max_exp_ret = max(expected_ret);
step = (max_exp_ret - min_exp_ret) / (number_of_efficient_portfolios);
target_returns = [];
for i=1:number_of_efficient_portfolios
    target_returns = [target_returns min_exp_ret+i*step];
end

% Array that collects data related to the efficient portfolio
efficient_portfolios_weights = [];
efficient_portfolios_expret = [];
efficient_portfolios_stdev = [];
efficient_portfolios_sharp_ratio = [];

fprintf('\n\n--- EFFICIENT PORTFOLIOS ---\n');

% For each target return identy the portfolio that attains such return.
for i=1:number_of_efficient_portfolios

    weights = minimise_variance(cov_matrix, [], [], [ones(1,number_of_assets); expected_ret], [1; target_returns(i)]);
    efficient_portfolios_weights(:,i) = weights';
    efficient_portfolios_expret(:,i)  = weights * expected_ret';
    efficient_portfolios_stdev(:,i)  = sqrt(weights * cov_matrix * weights');
    efficient_portfolios_sr(:,i) = efficient_portfolios_expret(:,i)/efficient_portfolios_stdev(:,i);

    fprintf('PORTFOLIO %i \n', i);
    disp(['EXPECTED RETURN: ', num2str(efficient_portfolios_expret(:,i))]);
    disp(['STD. DEV: ', num2str(efficient_portfolios_stdev(:,i))]);
    disp(['SHARPE RATIO: ', num2str(efficient_portfolios_sr(:,i))]);
    fprintf('\n');

    % Plot weights of the portfolio
    figure;
    bar(efficient_portfolios_weights(:,i), 'FaceColor', barchart_adj_facecolour);
    titleText = ['Weights Porfolio ', num2str(i)];
    title(titleText);
    set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
    xtickangle(90)
    grid on;

end

% 9.b) -------------------  PLOT THE EFFICIENT FRONTIER ------------------

% Compute the efficient frontier
efficient_frontier = compute_frontier(expected_ret, cov_matrix, GMVP_fi_expret, 0.00005, 0.1);

% Plot the efficient forntier
figure;
plot(efficient_frontier.StdDev, efficient_frontier.Exp_Ret, 'b')
ylabel('Expected Return');
xlabel('Std Deviation');
title('Mean-Variance Efficient Frontier');
xlim([-0.05, 0.2]);
ylim([-0.05, 0.2]);

% Plot the 3 Efficient Portfolios
for i=1:number_of_efficient_portfolios
        hold on;
        plot(efficient_portfolios_stdev(i), efficient_portfolios_expret(i), 'ro', 'MarkerSize', 8);
        text(efficient_portfolios_stdev(i), efficient_portfolios_expret(i), sprintf('Portfolio %i', char(i)), 'VerticalAlignment', 'bottom');
end

% Plot the GMVP
hold on;
plot(GMVP_fi_stddev, GMVP_fi_expret, 'ro', 'MarkerSize', 8);
text(GMVP_fi_stddev, GMVP_fi_expret, 'GMVP', 'VerticalAlignment', 'bottom');


% 10) -----------------------  INTRODUCE THE RF ASSET  --------------------

% Set the Risk free return to match the data at hand
if observation_step == "Yearly"
    current_rf_return = last_rf_return;
elseif observation_step == "Monthly"
    current_rf_return = last_rf_return/12;
elseif observation_step == "Weekly"
    current_rf_return = last_rf_return/52;
elseif observation_step == "Daily"
    current_rf_return = last_rf_return/250;
end 

% Compute the market portfolio
mkt_portf_weights = maximise_sharp_ratio(expected_ret, cov_matrix, current_rf_return, [], [], [ones(1,number_of_assets)], 1);
mkt_portf_expret = mkt_portf_weights * expected_ret';
mkt_portf_stddev = sqrt(mkt_portf_weights * cov_matrix * mkt_portf_weights');
mkt_portf_sr = (mkt_portf_expret - current_rf_return)/mkt_portf_stddev;

fprintf('\n--- MARKET PORTFOLIO ---\n');
disp(['EXPECTED RETURN: ', num2str(mkt_portf_expret)]);
disp(['STD. DEV: ', num2str(mkt_portf_stddev)]);
disp(['SHARPE RATIO: ', num2str(mkt_portf_sr)]);

% Plot weights of the MKT PORTFOLIO
figure;
bar(mkt_portf_weights, 'FaceColor', barchart_adj_facecolour);
title('Weights Market Portfolio');
set(gca, 'xticklabel',asset_stats.Ticker,'xtick',1:numel(asset_stats.Ticker));
xtickangle(90)
grid on;

fprintf('\n');

% 10.a&b) --------------  PLOT THE EFFICIENT FRONTIER WITH RF  -------------

% Initialise the Plot
figure;
efficient_frontier = compute_frontier(expected_ret, cov_matrix, 0, 0.00005, 0.1);
plot(efficient_frontier.StdDev, efficient_frontier.Exp_Ret, 'color', [.5 .5 .5])
ylabel('Expected Return');
xlabel('Std. Deviation');
title('Mean-Variance Efficient Frontier');
xlim([0, 0.5]);
ylim([-0.05, 0.2]);

% Plot the Market Portfolio
hold on;
plot(mkt_portf_stddev, mkt_portf_expret, 'ro', 'MarkerSize', 8);
text(mkt_portf_stddev, mkt_portf_expret, 'MKT', 'VerticalAlignment', 'bottom');

% Plot the Risk Free Asset
hold on;
plot(0, current_rf_return, 'ro', 'MarkerSize', 8);
text(0, current_rf_return, 'RF', 'VerticalAlignment', 'bottom');

% Ploth the CML
hold on;
m = (mkt_portf_expret - current_rf_return) / mkt_portf_stddev;
b = current_rf_return;
x = linspace(0, 0.3, 200);
y = m * x + b;
plot(x, y, 'b')

% Write the equation of the CML
hold on;
equation = sprintf('CML = %.4fx + %.4f', m, b);  % Format the equation with calculated values
text(0.07, current_rf_return, equation, 'FontSize', 12, 'Color', 'b')  % Add equation text at the starting point


% 11) ---------------  3 EFFICIENT PORTFOLIO ON THE CML  -----------------

portfolio_on_CML_weight = [];
portfolio_on_CML_expret = [];
portfolio_on_CML_stdev = [];
portfolio_on_CML_sr = [];

fprintf('\n--- 3 PORTFOLIOS ON THE CML ---\n');

% For each portfolio compute the weight for the Risk Free asset and the market
% portfolio. Then compute expected return, std. dev. and sharpe ratio 
for i=1:number_of_efficient_portfolios

    portfolio_on_CML_weight(1,i) = (target_returns(i) - mkt_portf_expret) / (current_rf_return - mkt_portf_expret); % Allocation on Rf
    portfolio_on_CML_weight(2,i) = 1 - portfolio_on_CML_weight(1,i);

    portfolio_on_CML_expret(i) = portfolio_on_CML_weight(:,i)' * [current_rf_return; mkt_portf_expret];
    portfolio_on_CML_stdev(i) = portfolio_on_CML_weight(2,i) * mkt_portf_stddev;
    portfolio_on_CML_sr(i) = (portfolio_on_CML_expret(i) - current_rf_return) / portfolio_on_CML_stdev(i);

    fprintf('PORTFOLIO %i \n', i);
    disp(['EXPECTED RETURN: ', num2str(portfolio_on_CML_expret(:,i))]);
    disp(['STD. DEV: ', num2str(portfolio_on_CML_stdev(:,i))]);
    disp(['SHARPE RATIO: ', num2str(portfolio_on_CML_sr(:,i))]);
    fprintf('\n');

    % Plot weights of the portfolio
    figure;
    bar(portfolio_on_CML_weight(:,i), 'FaceColor', barchart_adj_facecolour);
    titleText = ['Weights Porfolio ', num2str(i)];
    title(titleText);
    ylim([0, 1.2]);
    set(gca, 'xticklabel',{'Risk Free', 'Market Portfolio'});
    grid on;

end

% 11) ------------  PLOT THE 3 EFFICIENT PORTFOLIO ON THE CML -------------

% Initialise the Plot
figure;
plot(efficient_frontier.StdDev, efficient_frontier.Exp_Ret, 'color', [.5 .5 .5])
ylabel('Expected Return');
xlabel('Std. Deviation');
title('Mean-Variance Efficient Frontier');
xlim([0, 0.15]);
ylim([0, 0.15]);

% Plot the Risk Free Asset
hold on;
plot(0, current_rf_return, 'ro', 'MarkerSize', 8);
text(0, current_rf_return, 'RF', 'VerticalAlignment', 'bottom');

% Ploth the CML
hold on;
m = (mkt_portf_expret - current_rf_return) / mkt_portf_stddev;
b = current_rf_return;
x = linspace(0, 0.3, 200);
y = m * x + b;
plot(x, y, 'b')

% Plot the 3 Efficient Portfolios
for i=1:number_of_efficient_portfolios
        hold on;
        plot(portfolio_on_CML_stdev(i), portfolio_on_CML_expret(i), 'ro', 'MarkerSize', 8);
        text(portfolio_on_CML_stdev(i), portfolio_on_CML_expret(i), sprintf('Portfolio %i', char(i)), 'VerticalAlignment', 'bottom');
end


% 12) -----------------  COMPUTE THE SECURITY MARKET LINE -----------------

% 12.1) Transform the Fama-French dataset 

    %  Convert cell values to double and divide values by 100 as FF data are expressed in percentage
    columnNames = FF.Properties.VariableNames;
    for i = 1:numel(columnNames)
        if columnNames{i} ~= "DATE"
            column = FF.(columnNames{i});
            FF.(columnNames{i}) = cellfun(@str2double, column);
            FF.(columnNames{i}) = FF.(columnNames{i}) / 100;
        end
    end
    
    % Cut off the FF dataset to align it to the Price data
    index_y = find(year(FF.DATE) == year(returns_observation_date(1)));
    index_m = find(month(FF.DATE) == month(returns_observation_date(1)));
    target_row = intersect(index_y, index_m);
    FF = FF(target_row:end, :);

    % Check whether the last observation of dataset Price and FF are equal
    index_y = max(year(FF.DATE)) == max(year(returns_observation_date));
    index_m = max(month(FF.DATE)) == max(month(returns_observation_date));
    if not(index_y && index_m)
        fprintf('WARNING: MISSMATCH BETWEEN FAMA FRENCH AND PRICE DATA\n');
    end

% 12.2) Estimate Beta and Alpha for each of the three portfolio
beta_formula = [];
beta_regression = [];
pvalue_beta = [];
alpha = [];
pvalue_alpha = [];

returns_rf = FF.RF;
returns_mkt = FF.MKT_RF + FF.RF;

for i=1:number_of_efficient_portfolios

    % Calculate portfolio returns
    returns_mkt_portfolio = adjusted_returns_assets * mkt_portf_weights';
    returns_portfolio = portfolio_on_CML_weight(1,i) * returns_rf + (1-portfolio_on_CML_weight(1,i)) * returns_mkt_portfolio;
    
    % Compute Beta using the formula
    covariance = cov(returns_mkt, returns_portfolio);
    beta_formula(i) = covariance(1,2) / var(returns_mkt);
    
    % Compute Beta and Alpha using regression analysis 
    excess_returns_portfolio = returns_portfolio - returns_rf;
    excess_mkt_returns = FF.MKT_RF;
    estimated_model = fitlm(excess_mkt_returns, excess_returns_portfolio);
    coefficients = estimated_model.Coefficients;
    beta_regression(i) = coefficients{"x1","Estimate"};
    pvalue_beta(i) = coefficients{"x1","pValue"};
    alpha(i) = coefficients{"(Intercept)","Estimate"};
    pvalue_alpha(i) = coefficients{"(Intercept)","pValue"};

    % Scatter Plot to estimate Beta and Alpha
    figure()
    hold on;
    scatter(excess_mkt_returns, excess_returns_portfolio, 'filled');
    xlabel('Excess Market Return');
    yText = ['Excess Return Porfolio ', num2str(i)];
    ylabel(yText);
    titleText = ['Estimate of Beta and Alpha - Porfolio ', num2str(i)];
    title(titleText);
    ylim([-0.06 0.12]);
    grid on;

    % Plot the esitmated line
    % Generate x-values for regression line
    min_val = min(min(excess_mkt_returns),min(excess_returns_portfolio));
    max_val = max(max(excess_mkt_returns),max(excess_returns_portfolio));
    x_regression = linspace(min_val, max_val, 100);
    
    % Calculate y-values for regression line
    y_regression = alpha(i) + beta_regression(i) * x_regression;
    
    % Plot regression line
    plot(x_regression, y_regression, 'r-', 'LineWidth', 2);

    % Add regression statistics as text annotations
    beta_text_position = prctile(excess_returns_portfolio, 98);
    beta_text = sprintf('Beta: %.3f - Pvalue: %.5f', beta_regression(i), pvalue_beta(i));
    alpha_text_position = prctile(excess_returns_portfolio, 100);
    alpha_text = sprintf('Alpha: %.3f - Pvalue: %.5f', alpha(i), pvalue_alpha(i));
    text(min(x_regression), 0.11, beta_text);
    text(min(x_regression), 0.10, alpha_text);

end

% 12.3) Plot the three portfolios on the SML

% Plot the three portfolio
figure()

expected_excess_ret_market = mean(excess_mkt_returns);

portfolio_on_SML = [];
for i=1:number_of_efficient_portfolios
    portfolio_on_SML(i) = current_rf_return + beta_regression(i) * expected_excess_ret_market;
end
scatter(beta_regression,portfolio_on_SML, 'ro');
for i=1:number_of_efficient_portfolios
    hold on;
    text(beta_regression(i), portfolio_on_SML(i), sprintf('Portfolio %i', char(i)), 'VerticalAlignment', 'bottom');
end

% Plot the SML
hold on;
x = linspace(0,max(beta_regression)+max(beta_regression)*0.4,100);
y = current_rf_return + x * expected_excess_ret_market;
plot(x, y, 'b');

% Chart Customisation
xlabel('Beta');
ylabel('Expected Return');
title('Position on the SML');

% 12.4) Plot the three portfolios expected return against the SML

% Plot the three portfolio
figure()

scatter(beta_regression,portfolio_on_CML_expret, 'ro');
for i=1:number_of_efficient_portfolios
    hold on;
    text(beta_regression(i), portfolio_on_CML_expret(i), sprintf('Portfolio %i', char(i)), 'VerticalAlignment', 'bottom');
end

% Plot the SML
hold on;
x = linspace(0,max(beta_regression)+max(beta_regression)*0.4,100);
y = current_rf_return + x * expected_excess_ret_market;
plot(x, y, 'b');

% Chart Customisation
xlabel('Beta');
ylabel('Expected Return');
title('Position on the SML');


% ------------------------------  FUNCTIONS ----------------------------


function weigths = compute_years_penalisation_factors(returns_observation_date, weight_table)
% Function used to compute the weights that will be used to penalise the
% bservation associated with past years wrt to the more recent ones.

    returns_observations = height(returns_observation_date);
    number_of_interval = height(weight_table);
    weigths = -ones(1,returns_observations);

    for i=1:returns_observations
        observation_month = month(returns_observation_date(i));
        observation_year = year(returns_observation_date(i));
        observation_date = observation_year * 100 + observation_month;
        
        for p=1:number_of_interval
            period_start = weight_table.Year_Start(p) * 100 + weight_table.Month_Start(p);
            period_end = weight_table.Year_End(p) * 100 + weight_table.Month_End(p);
            if observation_date >= period_start  && observation_date < period_end
                weigths(1, i) = weight_table.Weight(p);
            end
        end

        if weigths(1, i) == - 1
            disp('[Warning - Compute_years_penalisation_factors]: Bad definition of interval, change values');
        end

    end

end


function efficient_frontier = compute_frontier(expected_ret, cov_matrix, min, step, max)
% Function used to compute the different point of the efficient frontier
% Minimising the variance requiring a minimum return we compute the points
% of the efficient forntier in the mean-variance space.

    number_of_assets = length(expected_ret);
    frontier_values_ret = [];
    frontier_values_stddev = [];

    for mu = min : step : max
        weights = minimise_variance(cov_matrix, [], [], [ones(1,number_of_assets); expected_ret], [1; mu]);
        frontier_values_ret(end+1) = weights * expected_ret';
        frontier_values_stddev(end+1) = sqrt(weights * cov_matrix * weights');
    end

efficient_frontier = table(frontier_values_ret', frontier_values_stddev');
efficient_frontier.Properties.VariableNames = {'Exp_Ret', 'StdDev'};

end


function weights = minimise_variance(cov_matrix, A, b, Aeq, beq)
% Function that compute the weights of the portfolio that minimise the variance, 
% eventually it is possible to introduce additional constraints
    
    % The total number of variables (weights of the portfolio)
    number_of_variables = length(cov_matrix);

    % Objective function
    obj_fun = @(x) x * cov_matrix * x';

    % Starting guess
    x0 = ones(1,number_of_variables) ./ number_of_variables;

    options = optimoptions('fmincon', 'Display', 'off');
    weights = fmincon(obj_fun, x0, A,b, Aeq, beq, [], [], [], options);

end


function weights = maximise_sharp_ratio(expected_ret, cov_matrix, current_rf_return, A, b, Aeq, beq)
% Function that compute the weights of the portfolio that maximise the sharp ratio,
% eventually it is possible to introduce additional constraints
    
    % The total number of variables (weights of the portfolio)
    number_of_variables = length(cov_matrix);

    % Objective function - negative sharp ratio as we will minimise it
    obj_fun = @(x) -(expected_ret * x' - current_rf_return) / sqrt(x * cov_matrix * x');

    % Starting guess
    x0 = ones(1,number_of_variables) ./ number_of_variables;

    options = optimoptions('fmincon', 'Display', 'off');
    weights = fmincon(obj_fun, x0, A, b, Aeq, beq, [], [], [], options);

end


