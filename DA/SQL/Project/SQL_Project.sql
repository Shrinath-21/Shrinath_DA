use try;

CREATE TABLE movie (
    
    Series_Title VARCHAR(255),
    Released_Year INT,
    Runtime INT,
    Genre VARCHAR(255),
    IMDB_Rating DECIMAL(3, 1),
    Director VARCHAR(255),
    Star1 VARCHAR(255),
    No_of_Votes INT,
    Gross DECIMAL(20, 2),
    Metascore varchar(20)
);
  

load data infile "C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\imdb-top-1000.csv"
into table movie
fields terminated by ','
enclosed by '"'
lines terminated by '\n'
ignore 1 rows;


select * from movie;
SHOW VARIABLES LIKE 'secure_file_priv';

drop table movie;
show variables like 'local_infile';

SET GLOBAL local_infile = 1;

-- Find the most popular movie in terms of votes.
select Series_Title,No_of_Votes from movie
where No_of_Votes = (select max(No_of_Votes) from movie);

-- Find all movies with an IMDB rating above 7.5 and released after 2015.
select Series_Title,IMDB_Rating,Released_Year from movie
where IMDB_Rating > 7.5 and Released_Year > '2015';

-- Identify the directors with the highest average IMDB rating.
select Director,avg(IMDB_Rating) as Avg_Ratings from movie
group by Director
order by Avg_Ratings desc;

-- List the genres with the highest average IMDB rating.
select Genre,avg(IMDB_Rating) as Avg_Ratings from movie
group by Genre
order by Avg_Ratings DESC;

-- Find the movies where the Metascore is NULL and the IMDB_Rating is above 8.
select Series_Title,IMDB_Rating,Metascore from movie
where metascore is null and IMDB_Rating > 8;

-- Find the top 5 movies based on gross earnings (highest first), and show their Series_Title and Gross
select Series_Title,IMDB_Rating,Gross from movie
order by Gross desc
limit 5;

-- Find the average Gross for all movies released in the year 2010.
select avg(Gross) as  Avg_gross,Released_Year from movie
where  Released_Year = 2010 
group by Released_Year;

-- Identify the movies that have a Metascore less than 40 and list their Series_Title and Metascore.
select Series_Title,Metascore from movie
where metascore < 40;

-- For each genre, find the number of movies in that genre.

select genre,count(Genre) as Genre_count from movie
group by Genre
order by Genre_count desc;

-- Find the movies that have both IMDB_Rating above 8.5 and Gross above 100 million.
select Series_Title,IMDB_Rating,gross from movie
where IMDB_Rating > 8.5 and  Gross > 100000000;

-- Find the Directors Who Have Directed Movies in Multiple Genres
select director, count(distinct genre) as Num_of_Genre from movie
group by Director
having Num_of_Genre >1;

-- Top Grossing movies by years
SELECT Series_Title, IMDB_Rating, gross, Released_Year
FROM movie m1
WHERE gross = (
    SELECT MAX(m2.gross)
    FROM movie m2
    WHERE m2.Released_Year = m1.Released_Year
)
ORDER BY Released_Year;

-- highest earning  Genre
select genre,count(genre) as  Count_genre, avg(gross) as Top_earning_Genre from movie
group by genre
limit 3;

-- Top 3 Genre with public votes
SELECT  sum(No_of_Votes) as Total_votes, genre from movie
group by genre
order by total_Votes desc
limit 5;

-- All time Longest movie
select * from movie;
select Series_Title, Runtime as Longest_Movie_Alltime, Released_Year from movie
where runtime = (select max(runtime) from movie);

-- Avg runtime by year
select Released_Year,  Runtime as Avg_Runtime from movie
order by Released_Year;

-- Top 
-- insights
-- The most popular movie in terms of votes by Viewers - The Shawshank Redemption(2343110 Votes)
-- Top rated movies in 2015 -Talvar-8.2 & Drishyam-8.2 
-- The directors with the highest average IMDB rating- Frank Darabont-8.95
-- Top 3 genres with the highest average IMDB rating - Western-8.3,Crime-8.0,Fantasy-7.97
-- the top 5 movies based on gross earnings Star Wars: Episode VII - The Force Awakens,Sholay,Die Welle,Bonnie and Clyde,Raazi.
-- Top 3 Genre with movies produced - Drama-289,Action-172,Comedy-155
-- Most versetile Director- Akira Kurosawa (4 Different Genre)
-- The movie that have both IMDB_Rating above 8.5 and Gross above 100 million - Soorarai Pottru-8.6 Gross-556 Million
-- Highest earning Genre by Average :1.Drama -122525861.73,2.Crime 78996559.88,3.Action 189722449.5
-- Higest Voted Genre is Action with 72282412 votes