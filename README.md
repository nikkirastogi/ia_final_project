# ia_final_project
Team Member :

**Movie Analysis on AWS**

This repository contains the code and configuration files for setting up a movie recommendation system on AWS.

**Overview**

The movie recommendation system is designed to recommend movies to users based on their preferences. It utilizes both structured and unstructured datasets, performs data merging, cleansing, and loading, and leverages AWS services such as S3, Lambda, RDS, Glue, and SNS.

**Setup Instructions**

Create two S3 buckets to store data

Note:- To distribute functionality, you need to create users and assign roles to them.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/95bacfa2-04c1-4468-811a-fb21dccbfdf7)

1\. Structured Dataset

- Download the structured dataset from MovieLens.
- Using Python(movie\_csv.ipynb) to insert the dataset into an S3 bucket named final-project-rawdata-group-5-sec-2.

2\. Unstructured Dataset

- Use Python(api\_call\_upload\_S3.ipynb) to call the TMDB API and obtain the unstructured dataset.
- Insert the dataset into the same S3 bucket (final-project-rawdata-group-5-sec-2).

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/2ad31613-4e5f-4624-a033-cffeee9dde02)

3\. Data Merging with AWS Lambda

- Add the necessary layers in your lambda function(Amazon SDK)
- Assign an IAM role with full access to S3 and use it in the Lambda function.
- Create an AWS Lambda function(s3\_upload\_using\_lambda) to merge and clean the datasets from the S3 bucket and load it into another S3 bucket(final-project-mergedata-group-5-sec-2).
- Configure Lambda triggers to run the function every 30 days(rate(30 days) and on file upload.
- Ensure proper naming conventions for files (api\_movie\_data.csv and movies.csv).
- Utilize Python with Pandas and Numpy for data cleaning and merging.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/657b5afd-3afc-4ea1-bd54-6368b5ec4333)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/35e47041-9f2e-4151-b2bb-3cf8cdb7cb36)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/1ae4af82-234d-440d-8204-4fe1b5fc6d34)

In the below screenshot we can see that the data is successfully loaded in the S3 bucket, to confirm this we can check the time.

Note:- Lambda\_function will replace the old file with the new one.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/caca4c8f-2591-40be-b639-0d79c1b06652)

4\. Database Setup

- Create a Database instance in RDS. (make sure to make a database when creating instance)
- Use .tosql() function in Python to create a table from the merged dataset.
- Insert the table into an RDS instance.
- Design the conceptual model of the database.
- Identify dimensions and facts for the data warehouse schema.
- Define primary keys, foreign keys, and relationships between tables.
- Connected MySQL Workbench to AWS RDS instance
- Created Dimensions and fact table using DDL(create\_table\_OLAP.sql) in RDS 

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/9799c7f2-26f7-428e-9f15-a449b29c4516)

Note:- You have to input your access key and aws secret key.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/6f574c39-a5e2-4b21-8d16-f265c3cf006b)

Let’s check whether the tables are inserted or not. The screenshot given below are the proof that the data is successfully inserted in the table

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/6a79f2ad-38ec-4935-ab68-45c9ce93714d)

<img width="116" alt="image" src="https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/c8b02a5c-8a60-48da-b5cb-0ca62ed81c17">

<img width="468" alt="image" src="https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/289df2a8-e445-4d3d-a323-3f4a0a4c30f2">

5\. AWS Glue Service(ETL)

- Assign appropriate policies to a role and give that role to a user for ETL operations.

Note:- Below are the policies that you need to assign to a role and grant to the user for managing ETL

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/868e8558-d7d9-47c3-8439-8ee86ae000ab)

- Create MySQL connection to the RDS instance in AWS Glue.

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/8293faab-91e5-4693-9eb0-8458f1c59b48)

- Use a crawler to map data to the RDS database and table instance.(use JDBC data source, proper IAM role, frequency as on demand)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/180cdace-c76b-4750-8f87-051e416ecc2b)

- Use Visual ETL to create two ETL jobs: dimension\_job and fact\_job to load data into dimensions and facts, respectively.(First create dimension\_job)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/7b2e1b42-4ce8-4cab-80e5-4924afeebf34)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/01ee4e28-1cf2-4d98-a6a9-f03db6e98ba9)

- Extract the data from movie\_details database, transform it and load into Data warehouse (refer ETL using glue)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/ef3138f0-35ad-43e9-be23-fb669787ab20)

Note:- Below are the diagram which confirms that the data is successfully loaded into the database
![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/19756b11-7956-47e4-b970-e6fab4d0c0e2)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/db76f3cc-3730-476e-bcc3-8bae4a4af2c1)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/5cc43455-3cf7-4c85-bd44-40a8b4f7b028)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/9ad1fa39-b85d-4472-9f1a-4d9fd49f7cfe)

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/3a8bb507-39fa-4806-a296-5bfdb37c46b2)

6\. Email Notifications

- Configure an SNS topic to send emails to team members.
![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/20f52ae9-5316-4462-9839-0e81ef3a12f6)

- Create a subscription to you email

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/3803002d-4639-4de1-9678-2fca53069e61)

- Select the topic you created and create a subscription and confirm the subscription

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/bf9d4913-8328-452b-90e4-8a21569e6bb9)

- In your RDS instance create Event Subscription and choose the SNS topic you created earlier, then update your database to confirm the email

![image](https://github.com/nikkirastogi/Exploratory-Data-Analysis-Using-Matplotlib-Seaborn/assets/146681122/1a4b7e93-e980-49d1-8809-ae2e164f3686)

7\. Visualization with Tableau

- Connect the RDS database to Tableau for visualization.
- Create visualizations to showcase relevant results.(Movie Analysis.twb)

Prerequisites

- AWS account with appropriate permissions.
- Python environment with Pandas and Numpy for Lambda function.
- MySQL Workbench
- Access to Tableau for visualization.

Contributors

- Anupam Semwal
- Bhushan Babar
- Nikki Rastogi





