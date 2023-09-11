--This query retrieves the top 5 films in each category, sorted by rating within each category.

WITH RankedFilms AS (
    SELECT
        fc.category_id,
        f.film_id,
        f.title,
        f.rating,
        ROW_NUMBER() OVER (PARTITION BY fc.category_id ORDER BY f.rating DESC) AS film_rank
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
)
SELECT
    c.name AS category_name,
    rf.title AS film_title,
    rf.rating AS film_rating
FROM RankedFilms rf
JOIN category c ON rf.category_id = c.category_id
WHERE rf.film_rank <= 5
ORDER BY category_name, film_rank;