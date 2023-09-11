--This query retrieves films with the longest total duration (sum of lengths) in each category.

WITH CategoryFilmDurations AS (
    SELECT
        fc.category_id,
        f.film_id,
        f.title,
        f.length,
        SUM(f.length) OVER (PARTITION BY fc.category_id) AS total_duration
    FROM film_category fc
    JOIN film f ON fc.film_id = f.film_id
)
SELECT
    c.name AS category_name,
    cfd.title AS film_title,
    cfd.length AS film_length,
    cfd.total_duration AS category_total_duration
FROM CategoryFilmDurations cfd
JOIN category c ON cfd.category_id = c.category_id
WHERE cfd.length = (SELECT MAX(length) FROM CategoryFilmDurations WHERE category_id = cfd.category_id);