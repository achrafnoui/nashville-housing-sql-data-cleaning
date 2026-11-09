-- Step 1 : Explore the Battlefield NashvilleHousing
Select *
From PortfolioProject.dbo.NashvilleHousing;


-- Step 2 : Standardize Date Format

Update NashvilleHousing
SET SaleDate = CONVERT(Date,SaleDate);

-- Step 3 : Populate Property Address data

--testing the cure 
Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

-- implementing the cure 
Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From PortfolioProject.dbo.NashvilleHousing a
JOIN PortfolioProject.dbo.NashvilleHousing b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
Where a.PropertyAddress is null;

-- Step 4 : Breaking out Address into Individual Columns (Address, City, State)
ALTER TABLE dbo.NashvilleHousing
ADD PropertySplitAddress NVARCHAR(255),
    PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET
    PropertySplitAddress = TRIM(
        SUBSTRING(
            PropertyAddress,
            1,
            CHARINDEX(',', PropertyAddress) - 1
        )
    ),

    PropertySplitCity = TRIM(
        SUBSTRING(
            PropertyAddress,
            CHARINDEX(',', PropertyAddress) + 1,
            LEN(PropertyAddress)
        )
    )
WHERE PropertyAddress IS NOT NULL
  AND CHARINDEX(',', PropertyAddress) > 0;

-- test the shit 
SELECT TOP 100 *
FROM NashvilleHousing;

-- Step 5 : Same shit on the OwnerAdress 
SELECT TOP 100 
    OwnerAddress,
    PARSENAME(REPLACE(OwnerAddress,',','.'),1) AS State,
    PARSENAME(REPLACE(OwnerAddress,',','.'),2) AS City,
    PARSENAME(REPLACE(OwnerAddress,',','.'),3) AS Adress
FROM NashvilleHousing
WHERE OwnerAddress IS NOT NULL;

ALTER TABLE dbo.NashvilleHousing
ADD
    OwnerSplitAddress NVARCHAR(255),
    OwnerSplitCity NVARCHAR(255),
    OwnerSplitState NVARCHAR(255);

UPDATE NashvilleHousing
SET
    OwnerSplitState = TRIM(
        PARSENAME(REPLACE(OwnerAddress, ',', '.'), 1)
    ),

    OwnerSplitCity = TRIM(
        PARSENAME(REPLACE(OwnerAddress, ',', '.'), 2)
    ),

    OwnerSplitAddress = TRIM(
        PARSENAME(REPLACE(OwnerAddress, ',', '.'), 3)
    )
WHERE OwnerAddress IS NOT NULL;

-- Step 6 Replace Y and N with Yes and No 

UPDATE NashvilleHousing
SET SoldAsVacant = 
    CASE 
        WHEN SoldAsVacant = 'Y' THEN 'Yes'
        WHEN SoldAsVacant = 'N' THEN 'No'
        ELSE SoldAsVacant
    END;
-- test the cure 
SELECT DISTINCT SoldAsVacant
FROM NashvilleHousing;


-- Step 7 Remove Duplicates
WITH duplicates_sniffer AS (
    SELECT *,
        ROW_NUMBER() OVER (PARTITION BY ParcelID,PropertyAddress,SalePrice,SaleDate,LegalReference ORDER BY UniqueID ) AS row_num
    FROM NashvilleHousing
)
DELETE
FROM duplicates_sniffer
WHERE row_num > 1;

SELECT COUNT(*)
FROM NashvilleHousing;

-- STEP 8 : Delete Unused Columns 

SELECT *
FROM dbo.NashvilleHousing
TABLESAMPLE (1 PERCENT);



ALTER TABLE NashvilleHousing
DROP COLUMN OwnerAddress,TaxDistrict,PropertyAddress,SaleDate