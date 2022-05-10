-- The following may be added to the CREATE statement
-- Primary Key Syntax (added after field name and NOT NULL)
--     PRIMARY KEY (fieldName)
--          or for compound PK
--     CONSTRAINT PK_compoundFieldName PRIMARY KEY (field1,field2)
-- Foreign Key Syntax (added after field list)
--     FOREIGN KEY (field name) REFERENCES tableName(fieldName)
-- Text Field Max Size
--     Edit (255) to required length
-- Validation of length of text (added after create statement as new statement
--     CHECK (CHAR_LENGTH(fieldName) > value)
-- Range Check (added after field list)
--     CHECK (fieldName >= value)
--     CHECK (fieldName >= value AND fieldName <= value2)
-- Restricted choice
--     CHECK(fieldName in ('value1','value2','value3')) 

-- Note
-- At N5 Check constraints (that are ignored by a MySQL server) 
-- are being used instead of triggers.
-- DROP TABLE IF EXISTS Walker;
--
-- Table structure for table `Planner`
--

CREATE TABLE Planner(
plannerNo int NOT NULL,
forename varchar(25) NOT NULL,
surname varchar(25) NOT NULL,
telNo varchar(12) NOT NULL,
regYear int NOT NULL,
PRIMARY KEY (plannerNo)
);

--
-- Table structure for table `Route`
--

CREATE TABLE Route(
routeID varchar(255) NOT NULL,
distance float(6,2) NOT NULL,
woodName varchar(15) NOT NULL,
footwear varchar(50) NOT NULL,
description varchar(255) NOT NULL,
difficulty varchar(255) NOT NULL,
plannerNo int NOT NULL
);

--
-- Table structure for table `Walk`
--

CREATE TABLE Walk(
walkID int NOT NULL,
routeID varchar(6) NOT NULL,
walkerNo int NOT NULL,
walkDate date NOT NULL
);

--
-- Table structure for table `Walker`
--

CREATE TABLE Walker(
walkerNo int NOT NULL,
forename varchar(25) NOT NULL,
surname varchar(25) NOT NULL,
street varchar(50) NOT NULL,
town varchar(25) NOT NULL,
postcode varchar(9) NOT NULL,
telNo varchar(12) NOT NULL
);
