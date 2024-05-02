/*
Cleaning Data in SQL Queries
*/

SELECT *
FROM public.housing_data

----------------------------------------------------------------
-- Standardize Date Format

SELECT saledateConverted,CONVERT(Date,saledate)
FROM public.housing_data

Update housing_data
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE housing_data
SET saledateConverted = CONVERT(Date,SaleDate)


----------------------------------------------------------------
--Populate Property Address Data

-- 从 public.housing_data 表中选择所有列，按照 ParcelID 进行排序
SELECT *
FROM public.housing_data
-- WHERE PropertyAddress is null
ORDER BY ParcelID;

-- 使用 JOIN 将 public.housing_data 表自连接，并选择需要的列，同时使用 COALESCE 函数处理 PropertyAddress 为 NULL 的情况
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID AS b_ParcelID, b.PropertyAddress AS b_PropertyAddress, COALESCE(a.PropertyAddress, b.PropertyAddress) AS New_PropertyAddress
FROM public.housing_data a
JOIN public.housing_data b
   ON a.parcelid = b.parcelid
   AND a."uniqueid" <> b."uniqueid"
WHERE a.PropertyAddress IS NULL;

-- 更新 public.housing_data 表中的 PropertyAddress 列，使用 COALESCE 函数处理 PropertyAddress 为 NULL 的情况
UPDATE public.housing_data a
SET PropertyAddress = COALESCE(a.PropertyAddress, b.PropertyAddress)
FROM public.housing_data b
WHERE a.parcelid = b.parcelid
   AND a."uniqueid" <> b."uniqueid"
   AND a.PropertyAddress IS NULL;


-------------------------------------------------------------------
-- Breaking out Address into Individual Columns (Address,city,State)
SELECT PropertyAddress
FROM public.housing_data

SELECT 
SUBSTRING(PropertyAddress, 1 ,POSITION(',' IN PropertyAddress)-1) as PropertySplitAddress,
SUBSTRING(PropertyAddress,POSITION(',' IN PropertyAddress)+1,LENGTH(PropertyAddress)) as PropertySplitCity
FROM public.housing_data;

-- 添加新的 PropertySplitAddress 和 PropertySplitCity 列
ALTER TABLE public.housing_data
ADD COLUMN PropertySplitAddress VARCHAR(255),
ADD COLUMN PropertySplitCity VARCHAR(255);

-- 使用 UPDATE 语句将拆分后的地址信息更新到新添加的列中
UPDATE public.housing_data
SET 
    PropertySplitAddress = SUBSTRING(PropertyAddress, 1, POSITION(',' IN PropertyAddress) - 1),
    PropertySplitCity = SUBSTRING(PropertyAddress, POSITION(',' IN PropertyAddress) + 1, LENGTH(PropertyAddress) - POSITION(',' IN PropertyAddress))

ALTER TABLE public.housing_data
DROP COLUMN propertyaddress1,
DROP COLUMN propertyaddress2;


SELECT *
FROM public.housing_data

--------------------------------------------------------------------

-- Change the owneraddress

SELECT owneraddress
FROM public.housing_data



SELECT 
REPLACE(SPLIT_PART(OwnerAddress, ',', 1), '.', '')
,REPLACE(SPLIT_PART(OwnerAddress, ',', 2), '.', '')
,REPLACE(SPLIT_PART(OwnerAddress, ',', 3), '.', '')
FROM public.housing_data;

-- ADD New OwnerSplitAddress, OwnerSplitCity 和 OwnerSplitState列
ALTER TABLE public.housing_data
ADD COLUMN OwnerSplitAddress VARCHAR(255),
ADD COLUMN OwnerSplitCity VARCHAR(255);
ADD COLUMN OwnerSplitState VARCHAR(255);

-- 使用 UPDATE 语句将拆分后的地址信息更新到新添加的列中
UPDATE public.housing_data
SET 
    OwnerSplitAddress = REPLACE(SPLIT_PART(OwnerAddress, ',', 1), '.', '')
    OwnerSplitCity = REPLACE(SPLIT_PART(OwnerAddress, ',', 2), '.', '')
	OwnerSplitState = REPLACE(SPLIT_PART(OwnerAddress, ',', 3), '.', '')
	
	
	
-- 从 public.housing_data 表中选择所有列，按照 ParcelID 进行排序
SELECT 
REPLACE(SPLIT_PART(OwnerAddress, ',', 1), '.', '') AS OwnerSplitAddress,
REPLACE(SPLIT_PART(OwnerAddress, ',', 2), '.', '') AS OwnerSplitCity,
REPLACE(SPLIT_PART(OwnerAddress, ',', 3), '.', '') AS OwnerSplitState
FROM public.housing_data;

-- 添加新的 OwnerSplitAddress、OwnerSplitCity 和 OwnerSplitState 列
ALTER TABLE public.housing_data
ADD COLUMN OwnerSplitAddress VARCHAR(255),
ADD COLUMN OwnerSplitCity VARCHAR(255),
ADD COLUMN OwnerSplitState VARCHAR(255);

-- 使用 UPDATE 语句将拆分后的地址信息更新到新添加的列中
UPDATE public.housing_data
SET 
    OwnerSplitAddress = REPLACE(SPLIT_PART(OwnerAddress, ',', 1), '.', ''),
    OwnerSplitCity = REPLACE(SPLIT_PART(OwnerAddress, ',', 2), '.', ''),
    OwnerSplitState = REPLACE(SPLIT_PART(OwnerAddress, ',', 3), '.', '');

SELECT *
FROM public.housing_data;
--------------------------------------------------------------------

-- Change Y and N to Yes and No in "Sold as Vacant" field

SELECT DISTINCT(SoldAsVacant),COUNT(SoldAsVacant)
FROM public.housing_data
GROUP BY SoldAsVacant
ORDER BY 2;



SELECT SoldAsVacant,
	CASE 
		WHEN SoldAsVacant = 'false' THEN 'NO'
		WHEN SoldAsVacant = 'true' THEN 'Yes'
		ELSE 'Unknown' -- 这里假设如果 SoldAsVacant 不是 'true' 或 'false'
	END AS SoldAsVacant_New
FROM public.housing_data;


-- 将 SoldAsVacant 字段的数据类型从布尔型修改为字符串型
ALTER TABLE public.housing_data
ALTER COLUMN SoldAsVacant 
SET DATA TYPE VARCHAR(10); -- 或者根据实际需要设置合适的长度

UPDATE public.housing_data
SET SoldAsVacant = 
	CASE 
		WHEN SoldAsVacant = 'false' THEN 'NO'
		WHEN SoldAsVacant = 'true' THEN 'Yes'
		ELSE 'Unknown'
	END;




------------------------------------------------------------
--Remove Duplicates
WITH RowNumCTE AS( 
SELECT *,
    ROW_NUMBER() OVER (
		PARTITION BY ParcelID, 
		PropertyAddress, 
		SalePrice, 
		SaleDate, 
		LegalReference 
		ORDER BY 
			UniqueID) AS row_num
FROM public.housing_data
	
--ORDER BY ParcelID
)


SELECT *
FROM public.housing_data;


------------------------------------------------------------
--Delete Unused Columns
SELECT *
FROM public.housing_data;

ALTER TABLE public.housing_data
DROP COLUMN OwnerAddress,
DROP COLUMN TaxDistrict,
DROP COLUMN PropertyAddress;


