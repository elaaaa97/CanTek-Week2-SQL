--This query retrieves the top 10 customers based on their total payments and includes information about the city and country of each customer's address.

WITH CustomerPayments AS (
    SELECT
        c.customer_id,
        c.first_name,
        c.last_name,
        a.city_id,
        ct.city,
        co.country,
        SUM(p.amount) AS total_payments
    FROM customer c
    JOIN address a ON c.address_id = a.address_id
    JOIN city ct ON a.city_id = ct.city_id
    JOIN country co ON ct.country_id = co.country_id
    LEFT JOIN payment p ON c.customer_id = p.customer_id
    GROUP BY c.customer_id, c.first_name, c.last_name, a.city_id, ct.city, co.country
)
SELECT
    customer_id,
    CONCAT(first_name, ' ', last_name) AS customer_name,
    city,
    country,
    total_payments
FROM CustomerPayments
ORDER BY total_payments DESC
LIMIT 10;