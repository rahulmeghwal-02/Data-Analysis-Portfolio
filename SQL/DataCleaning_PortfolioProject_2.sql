
--   Cleaning Data in SQL Queries... -----------------------------

SELECT *
  FROM PortfolioProject..HousingData

----------------------------------------------------------------------------------------------------------------------------------------
-- Standardize Date Format

Select SaleDateUpdated, CONVERT(Date, SaleDate)
FROM PortfolioProject..HousingData

UPDATE HousingData
SET SaleDate = CONVERT(DATE,SaleDate) 
-- this trick work sometimes 

-- new Trick (100% working)
ALTER TABLE PortfolioProject..HousingData
ADD SaleDateUpdated DATE;

UPDATE PortfolioProject..HousingData
SET SaleDateUpdated = CONVERT(DATE,	SaleDate)




---------------------------------------------------------------------------------------------------------------------------------------

-- Populate Property Address Data
SELECT *
FROM PortfolioProject..HousingData
--WHERE PropertyAddress is NULL
ORDER BY ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject..HousingData a
JOIN PortfolioProject..HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL


UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM HousingData a
JOIN HousingData b
	ON a.ParcelID = b.ParcelID
	AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress is NULL



------------------------------------------------------------------------------------------------------------------------------

-- Breaking out Address into individual Columns (Address, City, State) 

SELECT PropertyAddress
FROM PortfolioProject..HousingData


-- first line takes the part before the ',' and to remove comma we MINUS-1 character...
-- 2nd line : is the remaining part (City) of the address after the comma so PLUS 1, mean after comma...
SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 ) AS Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress)) AS Address
FROM PortfolioProject..HousingData


-- 1st update : new column for Address
ALTER TABLE PortfolioProject..HousingData
ADD PropertySplitAddress Nvarchar(255);

UPDATE PortfolioProject..HousingData
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1 )

-- 2nd Update : new column for City
ALTER TABLE PortfolioProject..HousingData
ADD PropertySplitCity Nvarchar(255);

UPDATE PortfolioProject..HousingData
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))


SELECT *
FROM PortfolioProject..HousingData


-- now for OwnerAddress :- ###################
SELECT OwnerAddress 
FROM PortfolioProject..HousingData


-- Simple method :
SELECT 
PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
, PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
FROM PortfolioProject..HousingData


-- # now Updating this data to tabl : NEW COLUMNS

-- # 1
ALTER TABLE PortfolioProject..HousingData
ADD OwnerSplitAddress Nvarchar(255);

UPDATE PortfolioProject..HousingData
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)

-- # 2

ALTER TABLE PortfolioProject..HousingData
ADD OwnerSplitCity Nvarchar(255);

UPDATE PortfolioProject..HousingData
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)

-- # 2

ALTER TABLE PortfolioProject..HousingData
ADD OwnerSplitState Nvarchar(255);

UPDATE PortfolioProject..HousingData
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)



-- SELECTing ...
 SELECT  OwnerSplitAddress, OwnerSplitCity, OwnerSplitState
 FROM PortfolioProject..HousingData




 -------------------------------------------------------------------------------------------------------------------------------------------------------------
 -- Change Y and N to YES and NO in "Sold as Vacant" Field


SELECT DISTINCT(SoldAsVacant), COUNT(SoldAsVacant)
FROM PortfolioProject..HousingData
GROUP BY SoldAsVacant
Order by 2


-- using case to check if it works 
SELECT SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	   WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
  END
FROM PortfolioProject..HousingData



-- updating YES NO
UPDATE PortfolioProject..HousingData
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'YES'
	   WHEN SoldAsVacant = 'N' THEN 'NO'
	   ELSE SoldAsVacant
  END





 -----------------------------------------------------------------------------------------------------------------------------------------------------------------------

 -- Remove Duplicates ... 

 WITH RowNumCTE AS (
 SELECT *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
				) row_num
FROM PortfolioProject..HousingData
--Order BY ParcelID
)

SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress


-- DELETED Duplicates....
DELETE
FROM RowNumCTE
WHERE row_num > 1
--ORDER BY PropertyAddress





----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Delete UnUsed Columns :

SELECT *
FROM PortfolioProject..HousingData


ALTER TABLE PortfolioProject..HousingData
DROP COLUMN PropertyAddress, OwnerAddress, TaxDistrict


ALTER TABLE PortfolioProject..HousingData
DROP COLUMN SaleDate