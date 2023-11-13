# Asset-Pricing-Portfolio-Decision
his project is a strategic exercise in asset selection and risk assessment, utilizing historical data. It involves building the Global Minimum Variance Portfolio, balancing various constraints, and exploring the integration of risk-free assets, all within the framework of the Capital Asset Pricing Model.

## Strategy and Horizon
For this project, our investment strategy is a 5-year “buy and hold”. We believe that, despite the uncertainty that the markets currently have, markets will eventually resume their upward trend. As a result, for the upcoming 5-year period, we are moderately risk-seeking and comfortable with high volatility. It took ~5 years for the United States’ (US) market to recover from the Dot-com bubble, ~4 years from the 2008 crisis, and half a year from the 2020 COVID crash. Additionally, the US market has not gone below the pre-COVID market high since recovery. Therefore, we have faith in the market’s growing resilience and its ability to make sufficient gains to justify a 5-year “buy and hold” strategy.

<img width="457" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/da2ba1d6-00e6-48ba-841b-4f186ec0d44d">

## Economic and Business Environment
In the US, Jerome Powell had recently announced that the Federal Reserve’s aim is currently to increase rates (June 21st, 2023)1. This comes as the US market continues to hang on his every word to gauge how much economic pain the market will continue to experience. Though the announcement indicates that the Federal Reserve’s contractionary policy has not ended, it does come with some positive news. The following statements were mentioned in the recent meeting: “Inflation has moderated somewhat since the middle of last year”; “[Inflation expectations are] well-anchored”. Since inflation has been falling since July ’22, while the S&P500 has roughly grown by 6% since the same point, we believe that the US market may be able to weather further tightening without losing its capability to grow within 5 years.

The Congressional Budget Office (CBO) projects that inflation as measured by the Personal Consumption Expenditures (PCE) price index will be 3.3% in 2023 and 2.4% in 20242. PCE inflation is projected to continue declining thereafter, approaching the Federal Reserve’s long-run goal of 2% by 2026. Additionally, the CBO also projects that Gross Domestic Product (GDP) growth, though it will come to a halt in early 2023 due to interest rate hikes, will resume at a slow pace soon. For 2023, real GDP (inflation-adjusted) is projected to grow by just 0.1%. However, real GDP growth is projected to speed up thereafter, averaging 2.4% a year from 2024 to 2027, in response to predicted future rate cuts. Furthermore, the Manufacturing Purchasing Managers’ Index (MPMI) in the US is expected to reach 49.70 points by the end of this quarter, according to Trading Economics global macro models and analyst expectations3. In the long-term, the United States Manufacturing PMI is projected to trend around 53.00 points in 2024 and 52.00 points in 2025, according to Trading Economics’ econometric models. Generally speaking, a PMI value that is above 50 points towards economic growth. Though there is uncertainty for the near future, the US’s broad economic outlook is positive.

In Europe, the European Central Bank (ECB) sees inflation moderating and decreasing to 2.9% in 2024 and 2.1% in 20254. It also projected that annual average GDP growth will slow to 1% in 2023 before rebounding to 1.6% in 2024 and 2025. This is in contrast with the US economy which will see its economy halt its growth in 2023, but possibly achieve better growth from 2024 to 2027. Though real GDP growth is expected to be positive, but lower than the US’s, Europe inflation outlook is better and points to the continent as potentially being less uncertain in the near future. MPMI in Europe is projected to reach 45.20 points by the end of Q4 2023. However, it is also expected to trend around 52.50 in 2024 and 51.00 in 2025, which points towards growth and supports the belief that the European economy with have a positive trend.
India, which is a country of interest to us, is expected to grow by 5.9% in 2023 and by 6.1% on average over the next five years according to the International Monetary Fund (IMF)5. The Organization for Economic Co-operation and Development (OECD), predicts that the country will experience real GDP growth of 6% between 2023 and 2024, and 7% between 2024 and 20256.

India, though it has experienced a slowdown during COVID and is currently facing inflation of 4.7% as of April 2023, has a mainly positive macroeconomic outlook7. The Central Bank of India will halt rate increases in 2023 and will keep them steady until mid-2024, when it will begin cutting rates according to OECD data, since inflation is within their acceptable range of 2% to 6%8. Additionally, the country benefitted greatly from the rise in demand of services exports. India saw services exports rise by 35% in 2022-20239. Even though goods exports decreased by 40% in the same period India still had growing net exports, which we believe will continue. Services exports will likely continue to rise as companies will keep outsourcing while others will begin outsourcing, because of widespread economic pain and businesses aiming to cut their costs.

The business environment, globally, is still difficult and uncertain, as heightened interest rates dampens growth to the point where companies have been downsizing or cost-cutting quite aggressively. However, that trend affect some countries better than others as the general trend of outsourcing, which has been amplified by recent cost-cutting efforts, has led to net export growth in India. Rates are predicted to increase soon in the US and remain elevated in both India and Europe, therefore we can only expect the business environment to remain the same or worsen in the immediate future. Banks in Europe have reported significant tightening on credit standards, credit terms, and loans to firms in Q4 2022, which is expected to continue in Q1 202310. India remains focused on anchoring inflation expectations within the Central Bank of India’s acceptable range. This will lead to dampened or halted economic growth for a time. However, there are good outcomes to look forward to, as higher rates in both Europe and India are expected to lead to bringing inflation back down to ~2% within 2 years11. This would help our Europe and India rid themselves of the problem of excessive inflation and thus appease investors’ unease. Moreover, the US is now notoriously known for the resilience of its markets. Given the economic expectations that we currently have, we are optimistic and believe that the US will have see better growth within the next 5 years. As economic growth resumes in 2024 in all 3 regions of interest, or perhaps a year or two later if we are to be pessimistic, the business environment will loosen and allow for our bullish strategy to be supported by resumed company growth. In India, due to global warming and the need to safeguard people and cities as much as possible from its effects, there will also likely be greater investment in infrastructure which should temporarily boost the economy.

# Portfolio Assets
Our chosen asset classes are stocks and ETFs. To simplify our portfolio, we have elected to gain exposure to non-stock assets via ETFs. Our portfolio will be composed of:

**Healthcare:**

• IUHC (iShares S&P 500 Health Care Sector UCITS ETF)
• IBB (iShares Biotechnology ETF)
• LLY – US (Eli Lilly and Co)

Healthcare is somewhat stable in downturns and has the potential of above average returns when you factor in Biotech. Considering the recent pandemic that the world went through, we also believe that there will be increased attention towards health care infrastructure and products.
Eli Lilly and Co is a drug manufacturing business that is known for its numerous acquisitions, and thus its very diverse product offerings12. Its acquisitions strategy has been successful so far as the company’s return on equity has not been lower than 25% since 2018 and lower than 64% since 201913. We believe that including Eli Lilly in our portfolio is in our interest since the company seeks to acquire firms that are innovative instead of risking more of their own capital to attempt to innovate themselves, which helps them circumvent the typical healthcare innovation uncertainty.

**Renewables:**

• ICLN (iShares Global Clean Energy ETF)

ICLN focuses on global clean energy, a growing segment of the energy sector that is predicted to grow significantly over the next few years. Global renewable electricity capacity is expected to increase over 60% from 2020 by 202614. This ETF contains the main players in the segment with the highest growth. We believe that this growth will persist due to global interest in clean energy and the increasing attention that is given to Sustainable and Responsible Investing.

**Tech:**

• ROBO (Global X Robo Global Robotics and Automation ETF)
• AAPL (Apple Inc.)
• MSFT (Miscrosoft Corp)

ROBO ETF focuses on artificial intelligence, automation, and robotics. The first is a booming industry predicted to grow significantly over the next few years15. The other two, though they are not the greatest objects of focus in the market, may generate outsized returns in the future as they are one of the catalysts for continued productivity growth and cost-minimization via technological innovation.

Apple is the biggest company by market capitalization. It has a large and very loyal customer base and it continuously innovates. Therefore, we believe that including Apple in our portfolio can be to our benefit.

Microsoft is the largest provider of computer operating systems, it provides the Microsoft Office Suite, and provides a cloud computing platform which helped it earn a commanding market share in the space16. Most recently, it also began investing heavily in AI, which is an industry of interest to us and that we seek exposure to.

**REIT:**

• STAG (STAG Industrial)

STAG has a portfolio of industrial properties and warehouses/distributions centres. The reasoning behind the choice of this REIT is that we believe they hold properties that generate stable income with low probability of defaulting on payments. Additionally, due to REITs distribution policy we can generate passive income that may offset any downturn in the price of the stock.

**Commodities:**

• SLV (iShares Silver Trust)

Silver ETFs should experience an uptrend within the short term as economic uncertainty persists. Since gold and silver prices are inversely correlated with market uptrends, exposure to silver will help us hedge against longer-than-expected economic uncertainty and downturns.

**Consumer Discretionary:**

• RMS – FR (Hermes International SCA)

Hermes, a luxury brand, tends to have strong price performance even during recessions. Luxury brands typically perform well regardless of economic conditions thanks to inelastic demand. The stock’s performance over time has been extremely reliable, and we have some faith that the brand will be able to continue generating high levels of returns thanks to the popularity of the brand and customer loyalty.

**Index:**

• INDA (iShares MSCI India ETF)

This ETF provides country-wide exposure to the Indian market. As mentioned beforehand, the country’s economy is expected to growth significantly and consistently over the next 5 years. Additionally, as supported by Arcano Research and Professor Ignacio de la Torre of IE Business School, India has the potential to become the 3rd biggest economy in the next 5 years. 18

Our goal with this choice of assets is to take advantage of a likely bull market over the next 5 years by picking the blue chip and resilient stocks, while accounting for possible bad surprises. As this portfolio is resilient to adverse conditions and diversified, we believe that it can generate above average returns.

## Data Description
We have chosen **monthly data** to ensure that we capture an adequate amount, according to our subjective perspective, of general market trends and volatility. **Our primary outputs also contain monthly data**. This includes all charts. All annual data is derived from monthly, assuming no monthly compounding. Our data is taken from FactSet and contains price information from November 2015 until May 2023. We believe that this period captures enough of the post-2008 growth, COVID, and more recent market trends.
However, because we have elected to use data from such a long time period, we also decided to use factors to penalize time periods that we believe are not as relevant and should not be fully reflected in the calculations of expected returns and standard deviation. Post-COVID until our last data point in April, as well as pre-COVID but post-2018, have a factor of 1. In other words, we believe that it is highly relevant with regards to computing expected return (given the fact that we “can estimate expected returns and standard deviation based on historical information). For the COVID drop and recovery between February 2020 and September 2020, we used a factor of 0.5 as the loss is a result of a black swan and the uncommonly rapid recovery is a result of aggressive economic stimulus. For 2018, 2017, and 2016, we applied a factor of 0.9, 0.8, and 0.7 respectively as we believe the data from those periods to be relevant but less so than more recent data.

Additionally, because we are using past data to compute our asset’s expected returns, they may not reflect some assets’ true return potential or expected returns. Specifically, ICLN (global clean energy) and INDA (India ETF) do not have computed expected returns that reflect what we truly expect its returns to potentially be in the future19, 20. The performance of both baskets of assets have been heavily affected by ongoing economic pains and investors’ flight to safety. To remedy the disconnect, without being too optimistic in our subjective point of view, we have elected to apply premiums to the two ETFs’ return data to compute an expected return that converges towards our beliefs (0.2% monthly for INDA and 0.15% monthly for ICLN). India’s economy is projected to growth significantly over the next 5 years and global clean energy is being spurred onwards by both government incentives and geopolitics. We believe that those premiums are conservative and consider the possibility that future expectations are inflated.

<img width="440" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/f16ce42d-3928-40dd-b48a-1f3c63acaabb">

Note: the adjusted expected returns and standard deviations values are lower than the unaltered data due to the fact that we applied a 0.5 factor to all data from the COVID drop and recovery.

To elaborate on our positive outlook on renewable energy, the US’s Inflation Reduction Act (IRA) has already allocated about $95.6 billion USD for renewable energy sources as of February 202321. According to BlackRock, the IRA with provide “investors with long-term certainty, such as the 10-year investment and production tax credits for wind and solar”22. Additionally, the European Union (EU) has provided €72 billion annually on average since 201523. The EU currently has two large incentives to continue subsidizing renewable energy: the US’s IRA is attracting clean energy companies; and the Ukraine war has encouraged the EU to decouple itself from relying on Russian gas.

Before diving into our various portfolio combinations and potential portfolio results, a few monthly details on our benchmark the S&P500 index (using the same time period factors that will be applied to asset past returns):

<img width="298" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/db0f90a6-1a63-4eda-abcc-4bd59257d6c4">

## Variance, Covariance & Correlation Matrix

<img width="318" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/3720b433-ee6c-4de9-a0e7-a2e98df17bdd">

<img width="315" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/ce642d4c-60e3-4758-8ce9-3266b4915b2c">

In order to mitigate estimation errors and achieve more reliable portfolio selections, we computed the variance-covariance matrix using shrinkage algorithm improvement of the Ledoit-Wolf (LW) method.

## GMVP, No Constraints
<img width="503" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/b59574d2-d3f3-4cd5-a74d-fa235f7543f1">

## GMVP, Fully Invested
<img width="499" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/d82692ab-df39-46ce-9268-678080f7b428">

## 3 Efficient Portfolios with minimum returns
For our 3 portfolios, we defined min returns by using steps: step = (max ret – GMVP ret) / # of portfolios.

**Minimum Return 1: 1.08%**

<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/b8817405-53bd-4e9d-b3b9-1381d1b12caa">

**Minimum Return 2: 1.33%**

<img width="499" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/b6f5c023-d4a6-41e0-8594-4ab48a300ed5">

**Minimum Return 3: 1.59%**


<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/77c1a1b4-0eba-4f1e-ade1-dbed2339f6c2">

**Efficient Frontier**

<img width="448" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/170cb0e4-544c-4650-92d1-c69e9d0c02ea">

**GMVP – Min Returns (Still GMVP but would not invest due to min required returns)**

<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/9debf5f4-29e9-4739-93fc-4f77d776c38b">

**Comparing GMVP vs. Previous 2 GMVPs**

The Global Minimum Variance Portfolio, or GMVP, will always be the same if the constraints that we have are consistent. We sought three GMVPs: one where there are no constraints (we do not invest), one where we are fully invested, and another where we have minimum required returns. The first is evidently different from the rest as it requires us to invest so little that we essentially have no holdings. The other two must be identical, as the only difference between both circumstances is that in the last, we seek minimum required returns. However, applying a minimum required return only moves us along the efficient frontier. The lowest volatility portfolio that we have as an option is different, but it is not a new Global Minimum Variance Portfolio, it is only the lowest volatility portfolio given the requirements.

## Efficient Frontier with a Risk-Free Asset

**Efficient Frontier and CML Functional Form with Intercept and Slope**
After using the risk-free asset to calculate the capital market line, we can see all the feasible portfolios of the highest Sharpe ratio or risk-adjusted returns possible (given our chosen assets), which are all combinations of our market portfolio and a risk-free asset. What combination an investor would choose – holding one, holding both, shorting one while holding the other – depends entirely on the risk tolerance of the investor and / or their minimum, required return.
The CML also shows that to generate higher returns, you must take more risk.

<img width="259" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/c7ffa3ed-6ccf-4c54-94a9-42e4128383bd">

<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/e36af84f-445a-4dac-931c-d7f0e82f8a61">

## 3 CML Portfolios

**Minimum Return 1: 1.08%**

Weight of Market Portfolio: 22.9%; weight of the risk-free asset: 77.1%

<img width="502" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/7e55267c-e763-49ec-b83d-d7f0c658907c">

**Minimum Return 2: 1.33%**

Weight of Market Portfolio: 30.4% weight of the risk-free asset: 69.6%

<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/2b236736-21d3-4390-9db0-60c883bc4436">

**Minimum Return 3: 1.59%**

Weight of Market Portfolio: 37.9% weight of the risk-free asset: 62.1%

<img width="500" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/56982b28-4c58-468f-841f-326f027dacf7">

<img width="284" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/9275390a-a2b9-4242-bfc0-a9120d41a1fb">

## SML Position & Betas and Alphas of the 3 Portfolios

Using a regression, we find the following Beta and Alpha values for our 3 min return portfolios.

<img width="458" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/ef9c35d2-3f3c-4b81-97dc-56874d6ab73d">

<img width="227" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/3652a505-1acc-4daa-bb49-4846550c81e3">

The significant alpha indicates that the asset returns have a component that is not explained by the market risk factors. Though the value of alpha is small, it can be an opportunity for investors to earn abnormal returns. However, the non-significant beta suggests that the asset's returns do not exhibit a consistent relationship with the market returns. Hence, the CAPM might not be an appropriate model to explain the asset's performance, and alternative models or additional factors may be needed to better understand the asset's behavior.

However, the non-significant beta suggests that the asset's returns do not exhibit a consistent relationship with the market returns. Hence, the CAPM might not be an appropriate model to explain the asset's performance, and alternative models or additional factors may be needed to better understand the asset's behavior.
Using the Beta formula, we get the following: 0.0510 (portfolio 1), 0.0682 (portfolio 2), 0.0855 (portfolio 3), which are very close to the Beta values that the regression model found.

“Define the position on the SML of the three portfolios” implies that the three portfolios are on the SML and therefore that there is no mispricing with regards to Beta.
By using the risk-free, market risk premium (MRP), and the portfolio Beta, we get much lower expected returns than we do using our model. Because the expected returns are lower using the SML, our portfolios are underpriced.
Note: For the MRP, we used the Fama-French data from “Testing the CAPM” as it has monthly market performance and risk-free rate. We felt it was most appropriate as our benchmark only represents a part of the market and because our risk-free rate for portfolio building is forward-looking.

<img width="442" alt="image" src="https://github.com/giovannivignocchi/Asset-Pricing-Portfolio-Decision/assets/32396630/20f82a3d-caae-4d40-a73b-b0934957152a">

Using the portfolios’ actual expected returns, we get these positions above the SML. Again, the conclusion is that the portfolios are underpriced considering their Beta values.

## Results
Based on our results, which are heavily based on past data, we can observe that our strategy and portfolio selection can help us generate outsized returns. However, it comes at a cost in the form of risk, which we can tolerate given our moderate risk tolerance profile in this project. Additionally, if we were to invest in any of our portfolios, we could potentially beat the S&P500 in terms of returns and risk-adjusted returns.

With regards to strategy, our moderate risk-seeking preferences have been satisfied as we are given the potential to obtain high reward for mild risk (see 3 CML portfolios). If our overall economic and business expectations hold true for the next 5 years, we should be able to execute a successful strategy. Nevertheless, we can observe that the optimal asset allocations, in all our portfolios along the efficient frontier and on the CML, are not fully consistent with the rationales behind each asset that we chose to include. This can easily be explained by the fact that the portfolio model that we have is only concerned with expected returns, standard deviation, and very few constraints such as full portfolio investment and minimum expected returns. If we were to execute a strategy that is wholly consistent with not only our strategy but also our thinking behind each portfolio asset, then we would have to set a constraint that all allocations should be greater or equal to zero at the very least.Furthermore, we have to comment on the fact that our model is, again, heavily based on past data. In this project we are assuming that past data is reliable enough to help us determine expected returns and standard deviation. However, that is not a reflective of reality.

In conclusion, within the scope of the project, we are satisfied with the different portfolio returns and standard deviation values that we obtained. Outside of the scope of the project, we are not wholly satisfied with the asset allocations that we obtained, and we are more skeptical of the expected returns and standard deviation values that we found.

## References

Bloomberg. (n.d.). Eli Lilly & Co - company profile and news. Bloomberg.com. https://www.bloomberg.com/profile/company/LLY:US#xj4y7vzkg

Bravo, R. (2023a, February 26). Europe incentives on clean energy rival Biden’s green subsidies. Bloomberg.com. https://www.bloomberg.com/news/articles/2023-02-26/europe-incentives-on-clean-energy-rival-biden-s-green-subsidies#xj4y7vzkg

Bravo, R. (2023b, February 26). Europe incentives on clean energy rival Biden’s green subsidies. Bloomberg.com. https://www.bloomberg.com/news/articles/2023-02-26/europe-incentives-on-clean-energy-rival-biden-s-green-subsidies#xj4y7vzkg

Brazier, A. (2023, January). How the U.S. transition policy impacts investing. BlackRock. https://www.blackrock.com/us/individual/insights/blackrock-investment-institute/publications/us-transition-policy-implications#macro-and-investment-implications

Chen, Y., Wiesel, A., Eldar, Y. C., & Hero, A. O. (2010, June 14). Shrinkage algorithms for MMSE covariance estimation | IEEE journals ... https://ieeexplore.ieee.org/abstract/document/5484583/

Cox, J. (2023, June 21). Powell expects more fed rate hikes ahead as inflation fight “has a long way to go.” CNBC. https://www.cnbc.com/2023/06/21/powell-expects-more-fed-rate-hikes-ahead-as-inflation-fight-has-a-long-way-to-go.html

Eli Lilly Roe 2010-2023: LLY. Macrotrends. (2023). https://www.macrotrends.net/stocks/charts/LLY/eli-lilly/roe

European Central Bank. (2023, March 16). ECB staff macroeconomic projections for the euro area, March 2023. European Central Bank. https://www.ecb.europa.eu/pub/projections/html/ecb.projections202303_ecbstaff~77c0227058.en.html#toc1

Heineke, F., Janecke, N., Kl&auml;rner, H., K&uuml;hn, F., Tai, H., & Winter, R. (2022, October 28). Renewable-energy development in a net-zero world. McKinsey & Company. https://www.mckinsey.com/industries/electric-power-and-natural-gas/our-insights/renewable-energy-development-in-a-net-zero-world

IEA: More Than a third of the world’s electricity will come from renewables in 2025. World Economic Forum. (2023, March 16). https://www.weforum.org/agenda/2023/03/electricity-generation-renewables-power-iea/#:~:text=Renewable%20energy%20will%20produce%2035,2025%3A%20IEA%20%7C%20World%20Economic%20Forum

India and the IMF. IMF. (2023, January 13). https://www.imf.org/en/Countries/IND

India Economic Snapshot - OECD. (n.d.). https://www.oecd.org/economy/india-economic-snapshot/

Swagel, P. L. (2023, February). The Economic Outlook for 2023 to 2033 in 16 charts. Congressional Budget Office. https://www.cbo.gov/publication/58957#:~:text=growth%20of%20productivity.-,Projections%20of%20Income %20for%202023%20to%202033,percent%20from%202026%20to%202033

Taylor, P. (2023, February 27). Desktop Operating System Market Share 2013-2023. Statista. https://www.statista.com/statistics/218089/global-market-share-of-windows-7/

Thormundsson, B. (2023, May 3). Artificial Intelligence Market Size 2030. Statista. https://www.statista.com/statistics/1365145/artificial-intelligence-market-size/#:~:text=Global%20artificial%20intelligence%20market%20size%202021-

Torre, I. de la. (2023, June 1). Ignacio de la Torre on linkedin: #india #sectores #obstáculos #política #riesgos #research #economía... Ignacio de la Torre on LinkedIn: #india #sectores #obstáculos #política #riesgos #research #economía... https://www.linkedin.com/feed/update/urn:li:activity:7069949120450375680?updateEntityUrn=urn%3Ali%3Afs_feedUpdate%3A%28V2%2Curn%3Ali%3Aactivity%3A7069949120450375680%29

United States Manufacturing pmimay 2023 data - 2012-2022 historical - june forecast. United States Manufacturing PMI - May 2023 Data - 2012-2022 Historical - June Forecast. (2023, June). https://tradingeconomics.com/united-states/manufacturing-pmi#:~:text=In%20the%20long-term%2C%20the,according%20to%20our%20econometric%20models.

Vergolina, V. (2023, June 22). Microsoft’s investment in AI is paying off: Big take podcast. Bloomberg.com. https://www.bloomberg.com/news/articles/2023-06-22/microsoft-s-big-investment-in-ai-is-paying-off-big-take-podcast




