CREATE TABLE "Favorites"(
    "ProductId" BIGINT NOT NULL,
    "UserId" BIGINT NOT NULL
);
CREATE TABLE "Product"(
    "Id" BIGINT NOT NULL,
    "Name" VARCHAR(255) NOT NULL,
    "Description" VARCHAR(255) NOT NULL,
    "Rating" FLOAT(53) NOT NULL,
    "ProductSubCategoryId" BIGINT NOT NULL,
    "MarketId" BIGINT NOT NULL,
    "Price" FLOAT(53) NULL,
    "PictureURL" VARCHAR(255) NULL,
    "Status" VARCHAR(255) NOT NULL,
    "StorehouseId" BIGINT NOT NULL
);
ALTER TABLE
    "Product" ADD PRIMARY KEY("Id");
CREATE INDEX "product_name_index" ON
    "Product"("Name");
CREATE TABLE "ProductCategory"(
    "Id" BIGINT NOT NULL,
    "Name" CHAR(255) NOT NULL
);
ALTER TABLE
    "ProductCategory" ADD PRIMARY KEY("Id");
CREATE INDEX "productcategory_name_index" ON
    "ProductCategory"("Name");
CREATE TABLE "User"(
    "Id" BIGINT NOT NULL,
    "PickupPointIId" BIGINT NOT NULL,
    "FirstName" VARCHAR(255) NOT NULL,
    "LastName" VARCHAR(255) NOT NULL,
    "SurName" VARCHAR(255) NOT NULL,
    "Birthday" DATE NOT NULL,
    "Email" VARCHAR(255) NOT NULL,
    "PhoneNumber" VARCHAR(255) NOT NULL,
    "Score" BIGINT NULL,
    "Gender" BIGINT NULL,
    "CreateDate" DATE NOT NULL
);
ALTER TABLE
    "User" ADD PRIMARY KEY("Id");
CREATE TABLE "Storehouse"(
    "Id" BIGINT NOT NULL,
    "Place" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "Storehouse" ADD PRIMARY KEY("Id");
CREATE TABLE "Market"(
    "Id" BIGINT NOT NULL,
    "Name" VARCHAR(255) NOT NULL,
    "Rating" FLOAT(53) NULL
);
ALTER TABLE
    "Market" ADD PRIMARY KEY("Id");
CREATE INDEX "market_rating_index" ON
    "Market"("Rating");
CREATE TABLE "SearchHistory"(
    "ProductId" BIGINT NOT NULL,
    "UserId" BIGINT NOT NULL
);
CREATE TABLE "PickupPoint"(
    "Id" BIGINT NOT NULL,
    "Place" BIGINT NOT NULL,
    "TimeToWork" VARCHAR(255) NOT NULL
);
ALTER TABLE
    "PickupPoint" ADD PRIMARY KEY("Id");
CREATE TABLE "PropertiesType"(
    "Name" CHAR(255) NOT NULL,
    "PropertiesId" BIGINT NOT NULL
);
CREATE INDEX "propertiestype_name_index" ON
    "PropertiesType"("Name");
CREATE TABLE "Comment"(
    "Id" BIGINT NOT NULL,
    "CreateDate" DATE NOT NULL,
    "Text" VARCHAR(255) NOT NULL,
    "Rating" FLOAT(53) NULL,
    "ProductId" BIGINT NOT NULL,
    "UserId" BIGINT NOT NULL
);
ALTER TABLE
    "Comment" ADD PRIMARY KEY("Id");
CREATE TABLE "Distance"(
    "Distance" FLOAT(53) NOT NULL,
    "StorehouseId" BIGINT NOT NULL,
    "PickupPointId" BIGINT NOT NULL
);
CREATE INDEX "distance_distance_index" ON
    "Distance"("Distance");
CREATE TABLE "Basket"(
    "ProductId" BIGINT NOT NULL,
    "UserId" BIGINT NOT NULL
);
CREATE TABLE "PaymentDetails"(
    "Id" BIGINT NOT NULL,
    "Type" VARCHAR(255) NOT NULL,
    "CardNumber" VARCHAR(255) NULL,
    "CardName" VARCHAR(255) NULL,
    "CardType" VARCHAR(255) NULL,
    "PhoneNumber" VARCHAR(255) NULL,
    "Verified" BOOLEAN NOT NULL,
    "UserId" BIGINT NOT NULL
);
ALTER TABLE
    "PaymentDetails" ADD PRIMARY KEY("Id");
CREATE TABLE "Properties"(
    "Id" BIGINT NOT NULL,
    "Name" CHAR(255) NOT NULL,
    "ProductSubCategortId" BIGINT NOT NULL
);
ALTER TABLE
    "Properties" ADD PRIMARY KEY("Id");
CREATE INDEX "properties_name_index" ON
    "Properties"("Name");
CREATE TABLE "ProductSubCategory"(
    "Id" BIGINT NOT NULL,
    "Name" CHAR(255) NOT NULL,
    "ProductCategoryId" BIGINT NOT NULL
);
ALTER TABLE
    "ProductSubCategory" ADD PRIMARY KEY("Id");
CREATE INDEX "productsubcategory_name_index" ON
    "ProductSubCategory"("Name");
ALTER TABLE
    "ProductSubCategory" ADD CONSTRAINT "productsubcategory_productcategoryid_foreign" FOREIGN KEY("ProductCategoryId") REFERENCES "ProductCategory"("Id");
ALTER TABLE
    "PaymentDetails" ADD CONSTRAINT "paymentdetails_userid_foreign" FOREIGN KEY("UserId") REFERENCES "User"("Id");
ALTER TABLE
    "Favorites" ADD CONSTRAINT "favorites_userid_foreign" FOREIGN KEY("UserId") REFERENCES "User"("Id");
ALTER TABLE
    "SearchHistory" ADD CONSTRAINT "searchhistory_productid_foreign" FOREIGN KEY("ProductId") REFERENCES "Product"("Id");
ALTER TABLE
    "PropertiesType" ADD CONSTRAINT "propertiestype_propertiesid_foreign" FOREIGN KEY("PropertiesId") REFERENCES "Properties"("Id");
ALTER TABLE
    "Comment" ADD CONSTRAINT "comment_userid_foreign" FOREIGN KEY("UserId") REFERENCES "User"("Id");
ALTER TABLE
    "Basket" ADD CONSTRAINT "basket_userid_foreign" FOREIGN KEY("UserId") REFERENCES "User"("Id");
ALTER TABLE
    "Product" ADD CONSTRAINT "product_productsubcategoryid_foreign" FOREIGN KEY("ProductSubCategoryId") REFERENCES "ProductSubCategory"("Id");
ALTER TABLE
    "Distance" ADD CONSTRAINT "distance_storehouseid_foreign" FOREIGN KEY("StorehouseId") REFERENCES "Storehouse"("Id");
ALTER TABLE
    "Product" ADD CONSTRAINT "product_marketid_foreign" FOREIGN KEY("MarketId") REFERENCES "Market"("Id");
ALTER TABLE
    "User" ADD CONSTRAINT "user_pickuppointiid_foreign" FOREIGN KEY("PickupPointIId") REFERENCES "PickupPoint"("Id");
ALTER TABLE
    "Favorites" ADD CONSTRAINT "favorites_productid_foreign" FOREIGN KEY("ProductId") REFERENCES "Product"("Id");
ALTER TABLE
    "Comment" ADD CONSTRAINT "comment_productid_foreign" FOREIGN KEY("ProductId") REFERENCES "Product"("Id");
ALTER TABLE
    "SearchHistory" ADD CONSTRAINT "searchhistory_userid_foreign" FOREIGN KEY("UserId") REFERENCES "User"("Id");
ALTER TABLE
    "Product" ADD CONSTRAINT "product_storehouseid_foreign" FOREIGN KEY("StorehouseId") REFERENCES "Storehouse"("Id");
ALTER TABLE
    "Properties" ADD CONSTRAINT "properties_productsubcategortid_foreign" FOREIGN KEY("ProductSubCategortId") REFERENCES "ProductSubCategory"("Id");
ALTER TABLE
    "Distance" ADD CONSTRAINT "distance_pickuppointid_foreign" FOREIGN KEY("PickupPointId") REFERENCES "PickupPoint"("Id");
ALTER TABLE
    "Basket" ADD CONSTRAINT "basket_productid_foreign" FOREIGN KEY("ProductId") REFERENCES "Product"("Id");