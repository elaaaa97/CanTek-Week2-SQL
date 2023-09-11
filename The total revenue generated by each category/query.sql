--This query calculates the total revenue generated by each category, considering the payments made for rentals within each category.

WITH CategoryRevenue AS (
    SELECT
        c.category_id,
        c.name AS category_name,
        SUM(p.amount) AS total_revenue
    FROM category c
    JOIN film_category fc ON c.category_id = fc.category_id
    JOIN film f ON fc.film_id = f.film_id
    JOIN inventory i ON f.film_id = i.film_id
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY c.category_id, category_name
)
SELECT
    category_id,
    category_name,
    total_revenue
FROM CategoryRevenue
ORDER BY total_revenue DESC;