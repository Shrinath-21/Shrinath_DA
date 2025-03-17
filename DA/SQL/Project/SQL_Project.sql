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
having Num_of_Genre >1

-- Insights: By using Imdb top 1000 movies data below are the steps and obesvation I have concluded
-- 1) I uploaded csv file through mysql workbench by enabling local_infile as it was default set as protected and disabled.
-- 2) I cleaned up data by working on blank columns and cheking on duplicate entries.
-- 3) Exploring data for optimum and useful insights such as:
-- Explored the highest earning movies based on director and Genre 
-- Explored Peoples choices based on ratings and Metascore to observe and understand what people prefer
-- Explored Directors working on different Genre to direct movies and also based on Genre how many movies are being released in each genre
-- Explored yearwise average Gross income in movie industries