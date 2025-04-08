# 📊 Netflix SQL Data Analysis Project

This project demonstrates how to use SQL to perform real-world business analysis on a Netflix dataset. It covers various analytical tasks such as content distribution, genre classification, and actor/director insights.

---

## DATASET 
LINK : https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download




## 📌 Project Description

The goal of this project is to explore and extract valuable insights from a Netflix dataset using SQL. By answering 15 business-focused questions, this project demonstrates data cleaning, aggregation, filtering, and transformation using SQL queries.

---

## 🛠 Technologies Used

- PostgreSQL
- SQL (DDL & DML)
- Git/GitHub

---

## 🗃 Database Schema

The dataset is stored in a single table named `netflix` with the following columns:

| Column Name     | Data Type     | Description                          |
|------------------|----------------|--------------------------------------|
| show_id          | VARCHAR(6)     | Unique identifier for the content    |
| type             | VARCHAR(10)    | Movie or TV Show                     |
| title            | VARCHAR(150)   | Title of the content                 |
| director         | VARCHAR(208)   | Name of the director                 |
| casts            | VARCHAR(1000)  | List of cast members                 |
| country          | VARCHAR(150)   | Country of production                |
| date_added       | VARCHAR(50)    | Date when content was added          |
| release_year     | INT            | Year of release                      |
| rating           | VARCHAR(10)    | Age rating (e.g., TV-MA, PG, etc.)   |
| duration         | VARCHAR(15)    | Duration (minutes or seasons)        |
| listed_in        | VARCHAR(100)   | Genre/category                       |
| description      | VARCHAR(250)   | Description or summary               |

---

## 💼 Business Questions Solved

1. Count of Movies vs TV Shows with most common rating per type  
2. Most common rating overall  
3. Movies released in a specific year (e.g., 2020)  
4. Top 5 countries with the most content  
5. Longest movie on the platform  
6. Content added in the last 5 years  
7. All content directed by 'Rajiv Chilaka'  
8. TV shows with more than 5 seasons  
9. Number of content items per genre  
10. Top 5 years with highest content release in India  
11. All movies that are documentaries  
12. Content without a director  
13. Movies with 'Salman Khan' in the last 10 years  
14. Top 10 actors in Indian movies  
15. Categorization of content as "Good" or "Bad" based on keywords

---

