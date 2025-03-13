# Movie Analysis on AWS

This repository contains the code and configuration files for setting up a movie recommendation system on AWS.

## Overview

The movie recommendation system is designed to recommend movies to users based on their preferences. It utilizes both structured and unstructured datasets, performs data merging, cleansing, and loading, and leverages AWS services such as S3, Lambda, RDS, Glue, and SNS.

## Setup Instructions

### 1. Create two S3 Buckets to store data

**Note:** To distribute functionality, you need to create users and assign roles to them.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/95bacfa2-04c1-4468-811a-fb21dccbfdf7)

#### 1.1 Structured Dataset

- Download the structured dataset from MovieLens.
- Use Python (`movie_csv.ipynb`) to insert the dataset into an S3 bucket named `final-project-rawdata-group-5-sec-2`.

#### 1.2 Unstructured Dataset

- Use Python (`api_call_upload_S3.ipynb`) to call the TMDB API and obtain the unstructured dataset.
- Insert the dataset into the same S3 bucket (`final-project-rawdata-group-5-sec-2`).

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/2ad31613-4e5f-4624-a033-cffeee9dde02)

### 2. Data Merging with AWS Lambda

- Add the necessary layers in your Lambda function (Amazon SDK).
- Assign an IAM role with full access to S3 and use it in the Lambda function.
- Create an AWS Lambda function (`s3_upload_using_lambda`) to merge and clean the datasets from the S3 bucket and load it into another S3 bucket (`final-project-mergedata-group-5-sec-2`).
- Configure Lambda triggers to run the function every 30 days (`rate(30 days)`) and on file upload.
- Ensure proper naming conventions for files (e.g., `api_movie_data.csv` and `movies.csv`).
- Utilize Python with Pandas and Numpy for data cleaning and merging.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/657b5afd-3afc-4ea1-bd54-6368b5ec4333)

In the screenshot below, we can see that the data is successfully loaded in the S3 bucket. To confirm this, check the time.

**Note:** The Lambda function will replace the old file with the new one.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/caca4c8f-2591-40be-b639-0d79c1b06652)

### 3. Database Setup

- Create a Database instance in RDS. (Make sure to create a database when creating the instance.)
- Use the `.tosql()` function in Python to create a table from the merged dataset.
- Insert the table into an RDS instance.
- Design the conceptual model of the database.
- Identify dimensions and facts for the data warehouse schema.
- Define primary keys, foreign keys, and relationships between tables.
- Connect MySQL Workbench to the AWS RDS instance.
- Create Dimensions and Fact tables using DDL (`create_table_OLAP.sql`) in RDS.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/9799c7f2-26f7-428e-9f15-a449b29c4516)

**Note:** You will need to input your AWS access key and secret key.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/6f574c39-a5e2-4b21-8d16-f265c3cf006b)

Let's check whether the tables were inserted successfully. The screenshot below proves that the data has been successfully inserted into the table.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/6a79f2ad-38ec-4935-ab68-45c9ce93714d)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/c8b02a5c-8a60-48da-b5cb-0ca62ed81c17)

### 4. AWS Glue Service (ETL)

- Assign appropriate policies to a role and give that role to a user for ETL operations.

**Note:** Below are the policies that need to be assigned to a role and granted to the user for managing ETL.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/868e8558-d7d9-47c3-8439-8ee86ae000ab)

- Create a MySQL connection to the RDS instance in AWS Glue.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/8293faab-91e5-4693-9eb0-8458f1c59b48)

- Use a crawler to map data to the RDS database and table instance (use JDBC data source, proper IAM role, and frequency set to on-demand).

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/180cdace-c76b-4750-8f87-051e416ecc2b)

- Use Visual ETL to create two ETL jobs: `dimension_job` and `fact_job` to load data into dimensions and facts, respectively. (First, create `dimension_job`.)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/7b2e1b42-4ce8-4cab-80e5-4924afeebf34)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/01ee4e28-1cf2-4d98-a6a9-f03db6e98ba9)

- Extract the data from the `movie_details` database, transform it, and load it into the Data warehouse (refer to ETL using Glue).

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/ef3138f0-35ad-43e9-be23-fb669787ab20)

**Note:** The diagram below confirms that the data has been successfully loaded into the database.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/19756b11-7956-47e4-b970-e6fab4d0c0e2)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/db76f3cc-3730-476e-bcc3-8bae4a4af2c1)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/5cc43455-3cf7-4c85-bd44-40a8b4f7b028)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/9ad1fa39-b85d-4472-9f1a-4d9fd49f7cfe)

### 5. Email Notifications

- Configure an SNS topic to send emails to team members.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/20f52ae9-5316-4462-9839-0e81ef3a12f6)

- Create a subscription to your email.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/3803002d-4639-4de1-9678-2fca53069e61)

- Select the topic you created and create a subscription and confirm the subscription.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/bf9d4913-8328-452b-90e4-8a21569e6bb9)

- In your RDS instance, create an Event Subscription and choose the SNS topic you created earlier. Then update your database to confirm the email.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/1a4b7e93-e980-49d1-8809-ae2e164f3686)

### 6. Visualization with Tableau

- Connect the RDS database to Tableau for visualization.
- Create visualizations to showcase relevant results. (`Movie Analysis.twb`)

---

## Prerequisites

- AWS account with appropriate permissions.
- Python environment with Pandas and Numpy for Lambda function.
- MySQL Workbench.
- Access to Tableau for visualization.
