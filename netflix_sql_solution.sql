-- ===============================================
-- Netflix Data Analysis Project
-- ===============================================
-- This SQL script performs a variety of exploratory data analysis tasks
-- on a Netflix dataset using PostgreSQL. It includes schema creation,
-- descriptive statistics, and solutions to 15 business-related queries.
-- ===============================================

-- Drop existing table if it exists
DROP TABLE IF EXISTS netflix;

-- Create Netflix table
CREATE TABLE netflix (
    show_id        VARCHAR(6),
    type           VARCHAR(10),
    title          VARCHAR(150),
    director       VARCHAR(208),
    casts          VARCHAR(1000),
    country        VARCHAR(150),
    date_added     VARCHAR(50),
    release_year   INT,
    rating         VARCHAR(10),
    duration       VARCHAR(15),
    listed_in      VARCHAR(100),
    description    VARCHAR(250)
);

-- Preview the dataset
SELECT * FROM netflix;

-- Get the total number of content items
SELECT COUNT(*) AS total_content FROM netflix;

-- ===============================================
-- 15 Business Questions and Their Solutions
-- ===============================================

-- 1. Count the number of Movies vs. TV Shows with the most common rating for each type
SELECT type, rating FROM (
    SELECT
        type,
        rating,
        COUNT(*) AS count,
        RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS ranking
    FROM netflix
    GROUP BY type, rating
) AS subquery
WHERE ranking = 1;

-- 2. Most common rating overall
SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
ORDER BY total DESC
LIMIT 1;

-- 3. List all movies released in a specific year (e.g., 2020)
SELECT title, release_year
FROM netflix
WHERE release_year = 2020 AND type = 'Movie';

-- 4. Top 5 countries with the most content on Netflix
SELECT country, COUNT(*) AS total
FROM netflix
GROUP BY country
ORDER BY total DESC
LIMIT 5;

-- 5. Identify the longest movie
SELECT *
FROM netflix
WHERE type = 'Movie'
AND duration = (SELECT MAX(duration) FROM netflix WHERE type = 'Movie');

-- 6. Find content added in the last 5 years
SELECT *
FROM (
    SELECT *, TO_DATE(date_added, 'Month DD, YYYY') AS added_date
    FROM netflix
) AS sub
WHERE added_date >= CURRENT_DATE - INTERVAL '5 years';

-- 7. Find all content by director 'Rajiv Chilaka'
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons
SELECT *
FROM (
    SELECT *, SPLIT_PART(duration, ' ', 1)::INT AS number_of_seasons
    FROM netflix
    WHERE type = 'TV Show'
) AS sub
WHERE number_of_seasons > 5;

-- 9. Count the number of content items in each genre
SELECT genre, COUNT(*) AS total
FROM (
    SELECT show_id, UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre
    FROM netflix
) AS sub
GROUP BY genre
ORDER BY total DESC;

-- 10. Top 5 years with highest average content released in India
SELECT 
    EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
    COUNT(*) AS total,
    ROUND(COUNT(*)::NUMERIC / (SELECT COUNT(*) FROM netflix WHERE country = 'India') * 100, 2) AS avg_content_per_year
FROM netflix
WHERE country = 'India'
GROUP BY year
ORDER BY avg_content_per_year DESC
LIMIT 5;

-- 11. List all movies that are documentaries
SELECT *
FROM (
    SELECT *, UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS category
    FROM netflix
) AS sub
WHERE category ILIKE '%Documentaries%' AND type = 'Movie';

-- 12. Find all content without a director
SELECT *
FROM netflix
WHERE director IS NULL;

-- 13. Count how many movies actor 'Salman Khan' appeared in the last 10 years
SELECT *
FROM netflix
WHERE casts ILIKE '%Salman Khan%'
AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 14. Top 10 actors in Indian movies (based on frequency)
SELECT COUNT(*) AS total_movies, TRIM(actor) AS actor
FROM (
    SELECT UNNEST(STRING_TO_ARRAY(casts, ',')) AS actor
    FROM netflix
    WHERE country = 'India' AND type = 'Movie'
) AS sub
GROUP BY actor
ORDER BY total_movies DESC
LIMIT 10;

-- 15. Categorize content as 'Good' or 'Bad' based on description keywords
SELECT 
    COUNT(*) AS total,
    CASE
        WHEN description ILIKE '%kill%' OR description ILIKE '%violence%' THEN 'Bad'
        ELSE 'Good'
    END AS category
FROM netflix
GROUP BY category;
