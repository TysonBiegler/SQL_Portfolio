-------------------------------------------------------------------------------
--Cleaning Data in SQL Queries
Select *
FROM NashvilleHousing
-------------------------------------------------------------------------------
--Standardize Data Format
SELECT SaleDateConverted, CONVERT(Date,SaleDate)
FROM NashvilleHousing

UPDATE NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate)

ALTER TABLE NashvilleHousing
ADD SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)
-------------------------------------------------------------------------------
--populating property address but first replacing black cells with NULL
UPDATE NashvilleHousing
SET PropertyAddress = NULL
WHERE PropertyAddress = ''

 --Checking property addresses against parcelID to see if there is a usable address
SELECT * 
FROM NashvilleHousing
ORDER BY ParcelID


--checking where parcelIDs are the same but rows are different
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL

UPDATE a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM NashvilleHousing a
JOIN NashvilleHousing b
	ON a.ParcelID = b.ParcelID
	AND a.[UniqueID ]<>b.[UniqueID ]
WHERE a.PropertyAddress IS NULL
-------------------------------------------------------------------------------
--Breaking out Address into Individual Columns (Address, City, State)  Methods used -[substring, character index (CHARINDEX)]
SELECT PropertyAddress
FROM NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address -- Singling out the address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))AS City --adding the city name to a seperate column
FROM NashvilleHousing

ALTER TABLE NashvilleHousing
ADD PropertySplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)

ALTER TABLE NashvilleHousing
ADD PropertySplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1, LEN(PropertyAddress))

SELECT *
FROM NashvilleHousing

--Updating blanks to NULL
UPDATE NashvilleHousing
SET OwnerAddress = NULL
WHERE OwnerAddress = ''

SELECT OwnerAddress
FROM NashvilleHousing


--Using Parsename instead of substrings
SELECT
PARSENAME(REPLACE(OwnerAddress, ',', '.'),3) AS Address,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),2) AS City,
PARSENAME(REPLACE(OwnerAddress, ',', '.'),1) AS State
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
ADD OwnerSplitAddress Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.'),3)

ALTER TABLE NashvilleHousing
ADD OwnerSplitCity Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.'),2)

ALTER TABLE NashvilleHousing
ADD OwnerSplitState Nvarchar(255);

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.'),1)

SELECT *
FROM NashvilleHousing
-------------------------------------------------------------------------------
--Change Y and N to Yes and No in "Sold as Vacant" field
SELECT DISTINCT(SoldasVacant)
FROM NashvilleHousing

SELECT SoldAsVacant, COUNT(SoldasVacant)
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

UPDATE NashvilleHousing
SET SoldAsVacant = 'Yes'
WHERE SoldAsVacant = 'Y'

UPDATE NashvilleHousing
SET SoldAsVacant = 'No'
WHERE SoldAsVacant = 'N'

--doing the same thing using CASE
SELECT SoldAsVacant
,CASE
	WHEN SoldasVacant = 'Y' THEN 'Yes'
	WHEN SoldasVacant = 'N' THEN 'No'
	ELSE SoldasVacant
	END
FROM NashvilleHousing

UPDATE NashvilleHousing
Set SoldAsVacant = CASE
	WHEN SoldasVacant = 'Y' THEN 'Yes'
	WHEN SoldasVacant = 'N' THEN 'No'
	ELSE SoldasVacant
	END

SELECT SoldasVacant FROM NashvilleHousing
-------------------------------------------------------------------------------
--Remove Duplicates
	--Using CTE and Window functions
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

FROM NashvilleHousing
--Order BY ParcelID
)

DELETE
FROM RowNumCTE
WHERE row_num > 1

SELECT *
FROM NashvilleHousing

-------------------------------------------------------------------------------
--Deleting Unused Columns
ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate

SELECT *
FROM NashvilleHousing