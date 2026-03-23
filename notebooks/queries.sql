-- Total contracts and amendments by year

SELECT
    contract_year AS source_year,
    COUNT(*) AS total_entries,
    SUM(is_amendment) AS total_amendments,
    COUNT(*) - SUM(is_amendment) AS total_contracts
FROM halton.amends
WHERE contract_year BETWEEN 2017 AND 2026
GROUP BY contract_year
ORDER BY contract_year;


-- Total contracts and amendments by fiscal quarter 
SELECT
    clean_reporting_period AS fiscal_year,
    COUNT(*) AS total_entries,
    SUM(is_amendment) AS total_amendments,
    COUNT(*) - SUM(is_amendment) AS total_contracts
FROM halton.amends
GROUP BY clean_reporting_period
ORDER BY clean_reporting_period;


-- Total spending by government
SELECT
    year AS source_year,
    ROUND(SUM(COALESCE(yearly_value, 0)::NUMERIC), 2) AS total_spending
FROM halton.yearly
WHERE year BETWEEN 2017 AND 2026
GROUP BY year
ORDER BY year;



-- Spending by Department 
SELECT *
FROM (
    SELECT
        owner_org_title AS departments,
        year,
        ROUND(SUM(COALESCE(yearly_value, 0)::NUMERIC), 2) AS total_spending,
        RANK() OVER (PARTITION BY year ORDER BY SUM(yearly_value) DESC) AS rnk
    FROM halton.yearly
    WHERE year BETWEEN 2017 AND 2026
    GROUP BY owner_org_title, year
) t
WHERE rnk <= 10
ORDER BY year, total_spending DESC;



-- Intial contracts and entries below and above 25K by Department 
SELECT
    contract_year,
    owner_org_title AS department,

    SUM(CASE 
        WHEN original_value >= 25000 THEN 1 
        ELSE 0 
    END) AS entries_above_25k,

    SUM(CASE 
        WHEN original_value < 25000 THEN 1 
        ELSE 0 
    END) AS entries_below_25k

FROM halton.amends
WHERE is_amendment = 0 AND contract_year >= 2017

GROUP BY contract_year, owner_org_title
ORDER BY contract_year, owner_org_title;


-- Department spending by commodity_type
SELECT
    owner_org_title AS department,
    year,
    commodity_type,
    ROUND(SUM(COALESCE(yearly_value, 0)::NUMERIC), 2) AS total_spending,
    COUNT(*) FILTER (WHERE is_amendment = 0) AS total_contracts
FROM halton.yearly
WHERE year BETWEEN 2017 AND 2026
GROUP BY owner_org_title, year, commodity_type
ORDER BY department, year, total_spending DESC;


-- Department spending by solicitation procedure 
SELECT
    owner_org_title AS department,
    year,
    solicitation_procedure,
    ROUND(SUM(COALESCE(yearly_value, 0)::NUMERIC), 2) AS total_spending,
    COUNT(*) FILTER (WHERE is_amendment = 0) AS total_contracts
FROM halton.yearly
WHERE year BETWEEN 2017 AND 2026
GROUP BY owner_org_title, year, solicitation_procedure
ORDER BY department, year, total_spending DESC;


