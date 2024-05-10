CREATE SCHEMA if not exists movie_dw;

Drop table if exists movie_dw.fact_movie;
Drop table if exists movie_dw.dim_movie;
Drop table if exists movie_dw.dim_date;
Drop table if exists movie_dw.dim_genre;
Drop table if exists movie_dw.dim_country;

CREATE TABLE movie_dw.dim_movie (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    imdb_id VARCHAR(20),
    title VARCHAR(255),
    language VARCHAR(50),
    adult BOOLEAN
);

CREATE TABLE movie_dw.dim_date (
    date_id INT AUTO_INCREMENT PRIMARY KEY,
    release_date DATE,
    year INT,
    month INT,
    day INT
);

CREATE TABLE movie_dw.dim_genre (
    genre_id INT AUTO_INCREMENT PRIMARY KEY,
    genre_name VARCHAR(255)
);

CREATE TABLE movie_dw.dim_country (
    country_id INT AUTO_INCREMENT PRIMARY KEY,
    country_name VARCHAR(50)
);

-- Fact Table
CREATE TABLE movie_dw.fact_movie (
    movie_id INT,
    date_id INT,
    genre_id INT,
    country_id INT,
    budget DECIMAL(15,2),
    revenue DECIMAL(15,2),
    runtime INT,
    popularity DECIMAL(10,2),
    avg_rating DECIMAL(3,2),
    people_rated INT,
    FOREIGN KEY (movie_id) REFERENCES movie_dw.dim_movie(movie_id),
    FOREIGN KEY (date_id) REFERENCES movie_dw.dim_date(date_id),
    FOREIGN KEY (genre_id) REFERENCES movie_dw.dim_genre(genre_id),
    FOREIGN KEY (country_id) REFERENCES movie_dw.dim_country(country_id),
    PRIMARY KEY (movie_id,date_id,genre_id,country_id)
);
