SELECT
    actor_id,
    director_id
FROM ActorDirector
GROUP BY actor_id,director_id
HAVING count(*) >= 3
ORDER BY actor_id ASC, director_id ASC;
