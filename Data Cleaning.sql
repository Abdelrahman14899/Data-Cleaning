select * from NashvilleHousing;


-- populate property Address data

select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress , ISNULL(a.propertyaddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b on a.ParcelID=b.ParcelID
  and a.[UniqueID ]<> b.[UniqueID ]
 where a.PropertyAddress is null

 update a
 set propertyaddress = ISNULL(a.propertyaddress,b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b on a.ParcelID=b.ParcelID
  and a.[UniqueID ]<> b.[UniqueID ]
 where a.PropertyAddress is null



 --Breaking out address into indivduals columns ( Address,City,State)

 select SUBSTRING(propertyAddress,1,charindex(',',propertyaddress)-1) as Address
 from NashvilleHousing;

 alter table Nashvillehousing
 Add property_Address Nvarchar(255);

 update NashvilleHousing
 set Property_Address=SUBSTRING(propertyAddress,1,charindex(',',propertyaddress)-1);


 select parsename(replace(propertyaddress,',','.'),1) as City
 from NashvilleHousing;

 
 alter table Nashvillehousing
 Add Property_City Nvarchar(255);

 update NashvilleHousing
 set  Property_City=parsename(replace(propertyaddress,',','.'),1) ;


 --for OwnerAddress


select  parsename(replace(OwnerAddress,',','.'),3) as Owner_Address,
		parsename(replace(OwnerAddress,',','.'),2)as Owner_City,
		parsename(replace(OwnerAddress,',','.'),1)as Owner_State
from NashvilleHousing


alter table NashvilleHousing
Add Owner_Address Nvarchar(255);

update NashvilleHousing
set Owner_Address= parsename(replace(OwnerAddress,',','.'),3);


alter table NashvilleHousing
Add Owner_City Nvarchar(255);

update NashvilleHousing
set Owner_City= parsename(replace(OwnerAddress,',','.'),2);



alter table NashvilleHousing
Add Owner_State Nvarchar(255);

update NashvilleHousing
set Owner_State= parsename(replace(OwnerAddress,',','.'),1);



-- Change Y and N to YES and No in "SoldAsVacant"


select distinct soldasvacant , count (soldasvacant)
from Nashvillehousing
group by soldasvacant
order by 2;




Select SoldAsVacant ,
		case when 'SoldAsVacant'='N' then'NO'
			 when 'SoldAsVacant'='Y' then'YES'
		else SoldAsVacant
		end 
from Nashvillehousing

update [NashvilleHousing ]
set SoldAsVacant = case when 'SoldAsVacant'='N' then'NO'
						when 'SoldAsVacant'='Y' then'YES'
						else SoldAsVacant
						end ;




--Delete Unused Columns

ALter Table NashvilleHousing
Drop Column propertyAddress,
			owneraddress
