--This query retrieves a list of actors along with the count of films they have acted in, sorted by the number of films in descending order.

WITH ActorFilmCounts AS (
    SELECT
        a.actor_id,
        CONCAT(a.first_name, ' ', a.last_name) AS actor_name,
        COUNT(fa.film_id) AS film_count
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    GROUP BY a.actor_id, actor_name
)
SELECT
    actor_id,
    actor_name,
    film_count
FROM ActorFilmCounts
ORDER BY film_count DESC;