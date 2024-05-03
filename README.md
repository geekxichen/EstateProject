# EstateProject

## Project Overview
The EstateProject is a data analysis endeavor centered around real estate data sourced from Nashville Housing Data. This project aims to streamline data cleaning and analysis processes using Excel and SQL, providing valuable insights into the Nashville housing market. The project utilizes Excel and SQL queries to organize, clean, and analyze the data from the Nashville Housing Data source.


## Project Structure
The EstateProject comprises the following main components:

- Data Cleaning: Involves the meticulous cleaning and preparation of raw data obtained from the Nashville Housing Data source. Tasks include handling missing values, correcting data formats, and removing duplicates using Excel.

- Data Analysis: Utilizes SQL queries to delve into the cleaned housing data, exploring trends, patterns, and relationships within the dataset. This phase provides valuable insights into the Nashville housing market.

- Documentation: Offers comprehensive documentation, including README files, to guide users through the project's objectives, methodologies, and findings.


## Features
The key features of the EstateProject include:

- Data cleaning techniques using Excel to ensure data accuracy and consistency.
- SQL-based data analysis to uncover trends and patterns within the Nashville housing data.
- Comprehensive documentation to assist users in understanding the project's objectives and methodologies.


## Prerequisites
To utilize the EstateProject, users need:

  1. Access to Microsoft Excel for data cleaning tasks.
  2. Basic knowledge of SQL for data analysis using provided SQL queries.
- *WHERE*:
  SELECT *
  FROM public.housing_data
  WHERE PropertyAddress is null;
- *JOIN*:
  SELECT a.ParcelID, a.PropertyAddress, b.ParcelID AS b_ParcelID, b.PropertyAddress AS b_PropertyAddress, COALESCE(a.PropertyAddress, b.PropertyAddress) AS New_PropertyAddress
FROM public.housing_data a
JOIN public.housing_data b
   ON a.parcelid = b.parcelid
   AND a."uniqueid" <> b."uniqueid"
WHERE a.PropertyAddress IS NULL;
- *CASE WHEN*:
  SELECT SoldAsVacant,
	CASE 
		WHEN SoldAsVacant = 'false' THEN 'NO'
		WHEN SoldAsVacant = 'true' THEN 'Yes'
		ELSE 'Unknown' -- 这里假设如果 SoldAsVacant 不是 'true' 或 'false'
	END AS SoldAsVacant_New
FROM public.housing_data;


## Installation
There is no installation required for the EstateProject. Users can simply download the project files and begin using Excel and SQL tools for data cleaning and analysis.


## Usage
To utilize the EstateProject effectively, follow these steps:

1. Download or clone the project repository.
2. Open the provided Excel file containing the Nashville Housing Data.
3. Follow the data cleaning steps outlined in the project documentation using Excel.
4. Use provided SQL queries to analyze the cleaned data and uncover insights into the Nashville housing market.


## How It Works
The EstateProject leverages Excel for data cleaning tasks, allowing users to handle missing values, correct data formats, and remove duplicates efficiently. Once the data is cleaned, SQL queries are used to analyze the dataset, exploring trends and patterns within the Nashville housing data. This process provides valuable insights into the local real estate market.


## Additional Resources
The primary data source for this project is the Nashville Housing Data, provided by Alex. The original data source can be found here.
For additional resources and support, consider the following:
https://github.com/AlexTheAnalyst/PortfolioProjects

Refer to the original data source for detailed information about the Nashville Housing Data.
Explore the project documentation and code to gain insights into data cleaning and analysis techniques.
Reach out to the project contributors or community for assistance and collaboration opportunities.


## License
This project is licensed under the MIT License.
