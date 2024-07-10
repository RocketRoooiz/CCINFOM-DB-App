DROP SCHEMA IF EXISTS DBAPPSQL;
CREATE SCHEMA IF NOT EXISTS DBAPPSQL;
USE DBAPPSQL;


-- -----------------------------------------------------
-- Table Supplier
-- -----------------------------------------------------
DROP TABLE IF EXISTS Supplier;
CREATE TABLE IF NOT EXISTS Supplier (
supplier_id			INT			NOT NULL,
supplier_name		VARCHAR(45) NOT NULL,
email				VARCHAR(45),
contact_no			BIGINT(10),
avail_Mon			BOOLEAN NOT NULL,
avail_Tues			BOOLEAN NOT NULL,
avail_Wed			BOOLEAN NOT NULL,
avail_Thurs			BOOLEAN NOT NULL,
avail_Fri			BOOLEAN NOT NULL,
avail_Sat			BOOLEAN NOT NULL,
avail_Sun			BOOLEAN NOT NULL,

PRIMARY KEY			(supplier_id),

UNIQUE INDEX		(supplier_name),
UNIQUE INDEX		(email),
UNIQUE INDEX		(contact_no)
);

-- -----------------------------------------------------
-- Table Product
-- -----------------------------------------------------
DROP TABLE IF EXISTS Product;
CREATE TABLE IF NOT EXISTS Product (
prod_id				INT			NOT NULL,
prod_name			VARCHAR(45)	NOT NULL,
prod_price			FLOAT 		NOT NULL,
avail_term1			BOOLEAN 	NOT NULL,
avail_term2			BOOLEAN 	NOT NULL,
avail_term3			BOOLEAN 	NOT NULL,

PRIMARY KEY			(prod_id),

UNIQUE INDEX		(prod_name)
);

-- -----------------------------------------------------
-- Table Ingredient
-- -----------------------------------------------------
DROP TABLE IF EXISTS Ingredient;
CREATE TABLE IF NOT EXISTS Ingredient (
ing_id				INT			NOT NULL,
ing_name			VARCHAR(45) NOT NULL,
ing_price			FLOAT 		NOT NULL,
stock				INT			NOT NULL,
supplier_id			INT			NOT NULL,

PRIMARY KEY			(ing_id),

FOREIGN KEY			(supplier_id)
	REFERENCES		Supplier(supplier_id),
    
UNIQUE INDEX		(ing_name)
);

-- -----------------------------------------------------
-- Table Ingredient_Product
-- -----------------------------------------------------
DROP TABLE IF EXISTS Ingredient_Product;
CREATE TABLE IF NOT EXISTS Ingredient_Product (
ing_id				INT	NOT NULL,
prod_id				INT NOT NULL,
portion				INT	NOT NULL,

PRIMARY KEY			(ing_id, prod_id),

FOREIGN KEY			(ing_id)
	REFERENCES		Ingredient(ing_id),
FOREIGN KEY			(prod_id)
	REFERENCES		Product(prod_id)
);

-- -----------------------------------------------------
-- Table Receipt
-- -----------------------------------------------------
DROP TABLE IF EXISTS Receipt;
CREATE TABLE IF NOT EXISTS Receipt (
receipt_id			INT				NOT NULL,
receipt_type		ENUM('P','I')	NOT NULL,
date_generated		DATE			NOT NULL,

PRIMARY KEY			(receipt_id)
);

-- -----------------------------------------------------
-- Table Prod_Receipt
-- -----------------------------------------------------
DROP TABLE IF EXISTS Prod_Receipt;
CREATE TABLE IF NOT EXISTS Prod_Receipt (
receipt_id			INT 	NOT NULL,
prod_id				INT		NOT NULL,
bought_qty			INT		NOT NULL,
prod_amt			FLOAT 	NOT NULL,

FOREIGN KEY			(receipt_id)
	REFERENCES		Receipt(receipt_id),
FOREIGN KEY			(prod_id)
	REFERENCES		Product(prod_id)
);

-- -----------------------------------------------------
-- Table Ing_Receipt
-- -----------------------------------------------------
DROP TABLE IF EXISTS Ing_Receipt;
CREATE TABLE IF NOT EXISTS Ing_Receipt (
receipt_id			INT 	NOT NULL,
ing_id				INT		NOT NULL,
bought_qty			INT		NOT NULL,
ing_amt				FLOAT 	NOT NULL,

FOREIGN KEY			(receipt_id)
	REFERENCES		Receipt(receipt_id),
FOREIGN KEY			(ing_id)
	REFERENCES		Ingredient(ing_id)
);

-- -----------------------------------------------------
-- Add records to Supplier
-- -----------------------------------------------------
INSERT INTO Supplier
	VALUES 	(1, "Tighnari's Farm", "mushroom@avidya.com", 71604491, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE, TRUE),		
			(2, "Mondstadt General Goods", "anemoarchon@barbatos.com", 81440366, TRUE, TRUE, FALSE, TRUE, TRUE, TRUE, TRUE);
            
-- -----------------------------------------------------
-- Add records to Product table
-- -----------------------------------------------------
INSERT INTO	Product
	VALUES	(1, 'Sisig Silog', 129.00, TRUE, TRUE, TRUE),
			(2, 'Pork Steak Meal', 119.00, TRUE, TRUE, FALSE),
			(3, '4pc Dynamite Meal', 95.00, FALSE, FALSE, TRUE);
            
-- -----------------------------------------------------
-- Add records to Ingredient Table
-- -----------------------------------------------------
INSERT INTO	Ingredient
	VALUES	(1,'Pork', 50.00, 20, 1),
			(2,'Calamansi', 5.00, 20, 1),
			(3,'Chili', 10.00, 4, 1),
			(4,'Canola Oil', 15.00, 20, 2),
			(5,'Lumpia Wrapper', 3.00, 20, 2),
			(6,'Carrot', 10.00, 20, 1),
			(7,'Onion', 5.00, 20, 1),
			(8,'Rice', 10.00, 20, 1),
			(9,'Garlic', 3.00, 20, 1),
			(10,'Salt', 0.50, 20, 2),
			(11,'Pepper', 0.50, 20, 2),
			(12,'Sugar', 0.50, 20, 2),
			(13,'Egg', 5.00, 20, 1),
			(14,'Soy Sauce', 2.00, 20, 2),
			(15,'Vinegar', 2.00, 20, 2);
			
            
-- -----------------------------------------------------
-- Add records to Ingredient_Product
-- -----------------------------------------------------
INSERT INTO	Ingredient_Product
	VALUES	(1,	1,	1),
			(1, 2,	1),
			(1,	3,	1),
			(2,	1,	1),
			(2,	2,	2),
			(3,	1,	1),
			(3,	3,	4),
			(4,	1,	10),
			(4,	3,	1),
			(5,	3,	4),
			(6,	3,	2),
			(7,	1,	1),
			(7,	2,	1),
			(7,	3,	1),
			(8,	1,	1),
			(8,	2,	1),
			(8,	3,	1),
			(9,	2,	2),
			(9,	3,	2),
			(10, 1,	1),
			(10, 2,	1),
			(10, 3,	1),
			(11, 1,	1),
			(11, 2,	1),
			(11, 3,	1),
			(13, 1,	1),
			(13, 3,	1),
			(14, 2,	1),
			(15, 2,	1);

-- -----------------------------------------------------
-- Add records to Receipt
-- -----------------------------------------------------
INSERT INTO Receipt
	VALUES 	(1, 'I', '2023-07-14'),
			(2, 'I', '2023-09-25'),
			(3, 'I', '2023-10-14'),
			(4, 'P', '2023-10-27'),		
			(5, 'P', '2023-12-12'),
			(6, 'P', '2023-12-25'),
			(7, 'P', '2023-12-25');
            
-- -----------------------------------------------------
-- Add records to Prod_Receipt Table
-- -----------------------------------------------------
INSERT INTO	Prod_Receipt
	VALUES	(4, 1, 1, 129.00),
			(4,	3, 1, 95.00),
			(5,	2, 1, 119.00),
			(6,	2, 3, 357.00),
			(7,	1, 2, 258.00);

-- -----------------------------------------------------
-- Add records to Ing_Receipt
-- -----------------------------------------------------
INSERT INTO Ing_Receipt
	VALUES 	(1, 1, 10, 500.00),
			(2, 10, 15, 7.50),
			(2, 11, 15, 7.50),
			(3, 13, 20, 100.00);
            
		