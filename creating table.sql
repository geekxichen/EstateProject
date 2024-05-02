CREATE TABLE Housing_Data
(
    UniqueID SERIAL PRIMARY KEY,
    ParcelID VARCHAR(255),
    LandUse VARCHAR(255),
    PropertyAddress VARCHAR(255),
    SaleDate DATE,
    SalePrice INTEGER,
    LegalReference VARCHAR(255),
    SoldAsVacant BOOLEAN,
    OwnerName VARCHAR(255),
    OwnerAddress VARCHAR(255),
    Acreage DOUBLE PRECISION, 
    TaxDistrict VARCHAR(255),
    LandValue INTEGER,
    BuildingValue INTEGER,
    TotalValue INTEGER,
    YearBuilt INTEGER,
    Bedrooms INTEGER,
    FullBath INTEGER,
    HalfBath INTEGER
);

COPY Housing_Data FROM 'D:\Desktop\PortfolioProject\Easte Project\CleanedHousingData.csv' DELIMITER ',' CSV;

COPY public."Nashville_Housing_Data"
FROM 'D:\Desktop\PortfolioProject\Easte Project\CleanedHousingData.csv'
CSV HEADER;

ALTER TABLE IF EXISTS public."Housing_Data"
OWNER to postgres;


______________________________________________________________________________________

COPY housing_data (UniqueID, ParcelID, LandUse, PropertyAddress, SaleDate, SalePrice, LegalReference, SoldAsVacant, OwnerName, Acreage, TaxDistrict, LandValue, BuildingValue, TotalValue, YearBuilt, Bedrooms, FullBath, HalfBath
) 
FROM 'D:\Desktop\PortfolioProject\Easte Project\CleanedHousingData.csv' DELIMITER ',' CSV;

ALTER TABLE IF EXISTS public.housing_data
OWNER to postgres;




