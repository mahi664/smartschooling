DROP TABLE purchase_order_det;
DROP TABLE vendor_receipt_map;
DROP TABLE vendor_det;
DROP TABLE product_igst_map;
DROP TABLE product_cgst_map;
DROP TABLE product_sgst_map;
DROP TABLE igst_rates;
DROP TABLE sgst_rates;
DROP TABLE cgst_rates;
DROP TABLE return_order;
DROP TABLE order_customer_map;
DROP TABLE pending_payment;
DROP TABLE customer_det;
DROP TABLE order_det;
DROP TABLE product_category_map;
DROP TABLE category_det;
DROP TABLE product_discount_map;
DROP TABLE product_det;

CREATE TABLE `product_det` (
  `PRODUCT_ID` INT NOT NULL,
  `PROUCT_NAME` VARCHAR(1000) NOT NULL,
  `DISP_NAME` VARCHAR(500) NOT NULL,
  `DESC` VARCHAR(1000) NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  `RF3` INT NULL,
  `RF4` INT NULL,
  `RF5` INT NULL,
  PRIMARY KEY (`PRODUCT_ID`),
  UNIQUE INDEX `DISP_NAME_UNIQUE` (`DISP_NAME` ASC));


CREATE TABLE `product_discount_map` (
  `PRODUCT_ID` INT NOT NULL,
  `DISCOUNT` DOUBLE NULL,
  `EFF_DATE_SKEY` INT NOT NULL,
  `END_DATE_SKEY` INT NOT NULL,
  `LAST_UPDATE_TIME` DATETIME NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  PRIMARY KEY (`PRODUCT_ID`, `EFF_DATE_SKEY`, `END_DATE_SKEY`),
  CONSTRAINT `FK2`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `product_det` (`PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `category_det` (
  `CATEGORY_ID` INT NOT NULL,
  `NAME` VARCHAR(500) NULL,
  `DISP_NAME` VARCHAR(500) NULL,
  `DESC` VARCHAR(1000) NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  PRIMARY KEY (`CATEGORY_ID`),
  UNIQUE INDEX `NAME_UNIQUE` (`NAME` ASC));


CREATE TABLE `product_category_map` (
  `PRODUCT_ID` INT NOT NULL,
  `CATEGORY_ID` INT NOT NULL,
  `EFF_DATE_SKEY` INT NOT NULL,
  `END_DATE_SKEY` INT NOT NULL,
  `LAST_UPDATE_TIME` DATETIME NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  `RF3` INT NULL,
  PRIMARY KEY (`PRODUCT_ID`, `CATEGORY_ID`, `EFF_DATE_SKEY`, `END_DATE_SKEY`),
  INDEX `FK5_idx` (`CATEGORY_ID` ASC) ,
  CONSTRAINT `FK4`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `product_det` (`PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK5`
    FOREIGN KEY (`CATEGORY_ID`)
    REFERENCES `category_det` (`CATEGORY_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `order_det` (
  `ORDER_ID` INT NOT NULL,
  `PRODUCT_ID` INT NOT NULL,
  `QUANTITY` INT NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  `RF3` INT NULL,
  PRIMARY KEY (`ORDER_ID`, `PRODUCT_ID`),
  INDEX `FK7_idx` (`PRODUCT_ID` ASC),
  CONSTRAINT `FK7`
    FOREIGN KEY (`PRODUCT_ID`)
    REFERENCES `product_det` (`PRODUCT_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `customer_det` (
  `CUSTOMER_ID` INT NOT NULL,
  `NAME` VARCHAR(500) NULL,
  `PHONE` VARCHAR(12) NOT NULL,
  `EMAIL` VARCHAR(500) NULL,
  `ADDRESS` VARCHAR(500) NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  `RF3` INT NULL,
  PRIMARY KEY (`CUSTOMER_ID`,`PHONE`));


CREATE TABLE `pending_payment` (
  `ORDER_ID` INT NOT NULL,
  `PAID` DOUBLE NULL,
  `UNPAID` DOUBLE NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  PRIMARY KEY (`ORDER_ID`),
  CONSTRAINT `FK8`
    FOREIGN KEY (`ORDER_ID`)
    REFERENCES `order_det` (`ORDER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `order_customer_map` (
  `ORDER_ID` INT NOT NULL,
  `CUSTOMET_ID` INT NOT NULL,
  `DATE_SKEY` INT NOT NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  PRIMARY KEY (`ORDER_ID`, `CUSTOMET_ID`, `DATE_SKEY`),
  INDEX `FK11_idx` (`CUSTOMET_ID` ASC),
  CONSTRAINT `FK10`
    FOREIGN KEY (`ORDER_ID`)
    REFERENCES `order_det` (`ORDER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK11`
    FOREIGN KEY (`CUSTOMET_ID`)
    REFERENCES `customer_det` (`CUSTOMER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);


CREATE TABLE `return_order` (
  `NEW_ORDER_ID` INT NOT NULL,
  `RETURN_TYPE` CHAR NULL,
  `OLD_ORDER_ID` INT NOT NULL,
  `DATE_SKEY` INT NOT NULL,
  `RF1` INT NULL,
  `RF2` INT NULL,
  PRIMARY KEY (`NEW_ORDER_ID`, `DATE_SKEY`, `OLD_ORDER_ID`),
  INDEX `FK12_idx` (`NEW_ORDER_ID` ASC, `OLD_ORDER_ID` ASC) ,
  CONSTRAINT `FK12`
    FOREIGN KEY (`NEW_ORDER_ID`)
    REFERENCES `order_det` (`ORDER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK13`
    FOREIGN KEY (`OLD_ORDER_ID`)
    REFERENCES `order_det` (`ORDER_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

ALTER TABLE product_det CHANGE `prouct_name` `PRODUCT_NAME` varchar(1000);
ALTER TABLE product_det CHANGE `DESC` `PRODUCT_DESC` varchar(1000);
ALTER TABLE category_det CHANGE `DESC` `CATEGORY_DESC` varchar(1000);


CREATE TABLE `cgst_rates` ( 
	`GST_RATE`	double not NULL,
	`NAME`    	varchar(100) NULL,
	PRIMARY KEY(`GST_RATE`)
);


CREATE TABLE `sgst_rates` ( 
	`GST_RATE`	double not NULL,
	`NAME`    	varchar(100) NULL,
	PRIMARY KEY(`GST_RATE`)
);


CREATE TABLE `igst_rates` ( 
	`GST_RATE`	double not NULL,
	`NAME`    	varchar(100) NULL,
	PRIMARY KEY(`GST_RATE`)
);

ALTER TABLE product_det CHANGE `RF1` `UNIT` varchar(200);


CREATE TABLE `product_sgst_map` ( 
	`PRODUCT_ID`      	INT not NULL,
	`GST_RATE`        	double not NULL,
	`EFF_DATE_SKEY`   	integer(11) not NULL,
	`END_DATE_SKEY`   	integer(11) not NULL,
	`LAST_UPDATE_TIME`	datetime NULL,
	PRIMARY KEY(`PRODUCT_ID`,`GST_RATE`,`EFF_DATE_SKEY`,`END_DATE_SKEY`)
);
ALTER TABLE `product_sgst_map`
	ADD CONSTRAINT `FK16`
	FOREIGN KEY(`PRODUCT_ID`)
	REFERENCES `product_det`(`PRODUCT_ID`);


CREATE TABLE `product_cgst_map` ( 
	`PRODUCT_ID`      	INT not NULL,
	`GST_RATE`        	double not NULL,
	`EFF_DATE_SKEY`   	integer(11) not NULL,
	`END_DATE_SKEY`   	integer(11) not NULL,
	`LAST_UPDATE_TIME`	datetime NULL,
	PRIMARY KEY(`PRODUCT_ID`,`GST_RATE`,`EFF_DATE_SKEY`,`END_DATE_SKEY`)
);
ALTER TABLE `product_cgst_map`
	ADD CONSTRAINT `FK15`
	FOREIGN KEY(`PRODUCT_ID`)
	REFERENCES `product_det`(`PRODUCT_ID`);


CREATE TABLE `product_igst_map` ( 
	`PRODUCT_ID`      	INT not NULL,
	`GST_RATE`        	double not NULL,
	`EFF_DATE_SKEY`   	integer(11) not NULL,
	`END_DATE_SKEY`   	integer(11) not NULL,
	`LAST_UPDATE_TIME`	datetime not NULL,
	PRIMARY KEY(`PRODUCT_ID`,`GST_RATE`,`EFF_DATE_SKEY`,`END_DATE_SKEY`)
);
ALTER TABLE `product_igst_map`
	ADD CONSTRAINT `FK`
	FOREIGN KEY(`PRODUCT_ID`)
	REFERENCES `product_det`(`PRODUCT_ID`);


CREATE TABLE `vendor_det` ( 
	`VENDOR_ID`  	INT NOT NULL,
	`VENDOR_NAME`	varchar(700) NOT NULL,
	`CITY`       	varchar(500) NULL,
	`DISTRICT`   	varchar(500) NULL,
	`STATE`      	varchar(500) NULL,
	`PHONE`      	varchar(12) NULL,
	`EMAIL`      	varchar(500) NULL,
	`GST_NO`     	varchar(100) NULL,
	`RF1`        	integer(11) NULL,
	`RF2`        	integer(11) NULL,
	`RF3`        	integer(11) NULL,
	PRIMARY KEY(`VENDOR_ID`)
);


CREATE TABLE `vendor_receipt_map` ( 
	`VENDOR_ID` 	INT not NULL,
	`INVOICE_ID`	varchar(200) not NULL,
	`DATE_SKEY`  	integer(11) not NULL,
	PRIMARY KEY(`VENDOR_ID`,`INVOICE_ID`,`DATE_SKEY`)
);


CREATE TABLE `purchase_order_det` ( 
	`PRODUCT_ID` 	INT NOT NULL,
	`INVOICE_ID` 	varchar(200) NOT NULL,
	`BATCH_NO`   	varchar(200) not NULL,
	`QUANTITY`   	integer(11) NULL,
	`PRICE`      	double NULL,
	`COST`       	double NULL,
	`GST`        	double NULL,
	`MFG_DATE`   	datetime NULL,
	`EXP_DATE`   	datetime NULL,
	`BEST_BEFORE`	varchar(300) NULL,
	`RF1`        	integer(11) NULL,
	`RF2`        	integer(11) NULL,	
	`RF3`        	integer(11) NULL,
	`RF4`        	integer(11) NULL,
	`RF5`        	integer(11) NULL,
	PRIMARY KEY(`PRODUCT_ID`,`INVOICE_ID`,`BATCH_NO`)
);

ALTER TABLE `purchase_order_det`
	ADD CONSTRAINT `FK19`
	FOREIGN KEY(`PRODUCT_ID`)
	REFERENCES `product_det`(`PRODUCT_ID`);

RENAME TABLE `sgst_rates` TO `gst_rates`;

ALTER TABLE `purchase_order_det` MODIFY COLUMN `QUANTITY` double(16,4) NULL;

ALTER TABLE `purchase_order_det` MODIFY COLUMN `RF1` double(16,4) NOT NULL;

ALTER TABLE `purchase_order_det` CHANGE COLUMN `RF1` `IN_STOCK` double(16,4) NOT NULL;

ALTER TABLE vendor_det MODIFY COLUMN `GST_NO` VARCHAR NULL;

alter table vendor_receipt_map add column DUE_AMT double null;

alter table vendor_receipt_map add column TOTAL_AMT double null;

alter table vendor_receipt_map add column DISCOUNT double null;

alter table vendor_receipt_map add column PAYMENT_TYPE VARCHAR(200) null;

alter table vendor_receipt_map add column CHEQUE_NO VARCHAR(200) null;

alter table vendor_receipt_map add column GST_AMT double null;

alter table vendor_receipt_map add column ACC_NO varchar(200) null;

create table PRODUCT_STOCK_MAP(
	PRODUCT_ID 	INT NOT NULL,
	AVAIL_STOCK INT not null,
	LAST_UPDATE_TIME datetime null,
	LAST_USER varchar(200) null,
	
	primary key(PRODUCT_ID)
);
ALTER TABLE PRODUCT_STOCK_MAP
	ADD CONSTRAINT `FK20`
	FOREIGN KEY(`PRODUCT_ID`)
	REFERENCES `product_det`(`PRODUCT_ID`);

alter table customer_det drop column address;

alter table customer_det add column village varchar(200) null;
alter table customer_det add column city varchar(200) null;
alter table customer_det add column district varchar(200) null;
alter table customer_det add column state varchar(200) null;
alter table customer_det add column PIN_CODE varchar(200) null;
alter table customer_det add column UID_NO varchar(200) null;
alter table customer_det add column GST_NO varchar(200) null;
alter table customer_det add column PAN_NO varchar(200) null;

alter table vendor_det add column village varchar(200) null;
alter table vendor_det add column PIN_CODE varchar(200) null;
alter table vendor_det add column UID_NO varchar(200) null;
alter table vendor_det add column PAN_NO varchar(200) null;

alter table order_customer_map add column DUE_AMT double null;

alter table order_customer_map add column TOTAL_AMT double null;

alter table order_customer_map add column DISCOUNT double null;

alter table order_customer_map add column PAYMENT_TYPE VARCHAR(200) null;

alter table order_customer_map add column CHEQUE_NO VARCHAR(200) null;

alter table order_customer_map add column GST_AMT double null;

alter table order_customer_map add column ACC_NO varchar(200) null;


alter table order_det add column BATCH_NO VARCHAR(200) null;

alter table order_det add column RATE double null;

alter table order_customer_map rename column CUSTOMET_ID to CUSTOMER_ID

ALTER TABLE product_det CHANGE `RF2` `MRP` double null;
ALTER TABLE product_det CHANGE `RF3` `MANUFACTURER` varchar(200) null;
ALTER TABLE product_det CHANGE `RF4` `SELLING_PRICE` double null;
ALTER TABLE product_det CHANGE `RF5` `PACKAGING` varchar(200) null;

create table alerts(
	ALERT_ID int not null,
	ALERT_NAME varchar(1000) not null,
	ALERT_TYPE char not null,
	ALERT_DISCRIPTION varchar(500) not null,
	
	primary key(ALERT_ID)
);

ALTER TABLE order_customer_map CHANGE `CUSTOMET_ID` `CUSTOMER_ID` int NOT NULL;

delete from alerts where `ALERT_ID` = 1;
INSERT INTO alerts
(`ALERT_ID`, `ALERT_NAME`, `ALERT_TYPE`, `ALERT_DISCRIPTION`)
VALUES(1, 'PUR_ORDR_SUCCESS', 'S', 'Purchase Order Addedd Successfully');

delete from alerts where `ALERT_ID` = 2;
INSERT INTO alerts
(`ALERT_ID`, `ALERT_NAME`, `ALERT_TYPE`, `ALERT_DISCRIPTION`)
VALUES(2, 'PUR_ORDR_ERROR', 'E', 'Error in adding Purchase Order');

delete from alerts where `ALERT_ID` = 3;
INSERT INTO alerts
(`ALERT_ID`, `ALERT_NAME`, `ALERT_TYPE`, `ALERT_DISCRIPTION`)
VALUES(3, 'VEN_RECPT_MAP_ERROR', 'E', 'Error in adding vendor receipt map');

delete from alerts where `ALERT_ID` = 4;
INSERT INTO bni.alerts
(`ALERT_ID`, `ALERT_NAME`, `ALERT_TYPE`, `ALERT_DISCRIPTION`)
VALUES(4, 'PROD_STOCK_MAP_UPDATE_ERROR', 'E', 'Error in updating product stock map');

ALTER TABLE order_det CHANGE `RF1` `GST` double null;

ALTER TABLE order_det CHANGE `RF2` `EXP_DATE` datetime null;
