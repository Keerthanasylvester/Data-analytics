CREATE SCHEMA supplychain_opm;
CREATE TABLE `cycledata` (
  `ASSOCPAYLOADNOMINAL` bigint DEFAULT NULL,
  `AT Available Time (iMine)` int DEFAULT NULL,
  `Autonomous` int DEFAULT NULL,
  `Available SMU Time` int DEFAULT NULL,
  `Available Time` int DEFAULT NULL,
  `Completed Cycle Count` int DEFAULT NULL,
  `COMPLETEDCYCLEDURATION` int DEFAULT NULL,
  `Creation Mode` int DEFAULT NULL,
  `CT Calendar SMU Time` int DEFAULT NULL,
  `CT Calendar Time` int DEFAULT NULL,
  `Cycle Duration` int DEFAULT NULL,
  `Cycle SMU Duration` int DEFAULT NULL,
  `Cycle Type` text,
  `Delay Time` int DEFAULT NULL,
  `Down Time` int DEFAULT NULL,
  `DTE Down Time Equipment` int DEFAULT NULL,
  `Dumping Duration` int DEFAULT NULL,
  `Dumping SMU Duration` int DEFAULT NULL,
  `Destination Dumping Start Timestamp (GMT8)` double DEFAULT NULL,
  `Empty EFH Distance` double DEFAULT NULL,
  `Empty EFH Length` double DEFAULT NULL,
  `Empty Expected Travel Duration` int DEFAULT NULL,
  `Empty Fall Height` double DEFAULT NULL,
  `Empty Plan Length` double DEFAULT NULL,
  `Empty Rise Height` text,
  `Empty Slope Distance` double DEFAULT NULL,
  `Empty Slope Length` double DEFAULT NULL,
  `Empty Target Travel Duration` int DEFAULT NULL,
  `Empty Travel Duration` int DEFAULT NULL,
  `End Processor Name` text,
  `Cycle End Timestamp (GMT8)` text,
  `Estimated Fuel Used` int DEFAULT NULL,
  `Fuel Used` double DEFAULT NULL,
  `Full Expected Travel Duration` int DEFAULT NULL,
  `Full Travel Duration` int DEFAULT NULL,
  `IC` int DEFAULT NULL,
  `Idle Duration` int DEFAULT NULL,
  `iMine Availability` int DEFAULT NULL,
  `iMine Engine Hours` int DEFAULT NULL,
  `iMine Load FCTR Truck` text,
  `iMine Operating Hours` int DEFAULT NULL,
  `iMine Utilisation` int DEFAULT NULL,
  `Loading Count` int DEFAULT NULL,
  `Loading Duration` int DEFAULT NULL,
  `Loading Efficiency` text,
  `Source Loading End Timestamp (GMT8)` double DEFAULT NULL,
  `Source Loading Start Timestamp (GMT8)` double DEFAULT NULL,
  `OPERATINGBURNRATE` double DEFAULT NULL,
  `OPERATINGTIME (CAT)` int DEFAULT NULL,
  `OPERHOURSSECONDS` int DEFAULT NULL,
  `Payload (kg)` int DEFAULT NULL,
  `Payload (t)` double DEFAULT NULL,
  `PREVIOUSSECONDARYMACHINE` text,
  `PREVIOUSSINKDESTINATION` text,
  `QUEUEATSINKDURATION` int DEFAULT NULL,
  `Queuing at Sink Duration` int DEFAULT NULL,
  `Queuing at Source Duration` int DEFAULT NULL,
  `Queuing Duration` int DEFAULT NULL,
  `Source Queuing Start Timestamp (GMT8)` double DEFAULT NULL,
  `SD_SCHEDULEDDOWNTIME` int DEFAULT NULL,
  `SDE_SCHEDULEDDOWNEQUIP` int DEFAULT NULL,
  `Cycle Start Timestamp (GMT8)` text,
  `TC` int DEFAULT NULL,
  `TMPH` double DEFAULT NULL,
  `TOTALTIME (CAT)` int DEFAULT NULL,
  `Travelling Empty Duration` int DEFAULT NULL,
  `Travelling Full Duration` int DEFAULT NULL,
  `TRUCKQUEUEATSOURCEDURATION` text,
  `UNSCHEDULEDDOWNCOUNT` int DEFAULT NULL,
  `UNSCHEDULEDDOWNTIME` int DEFAULT NULL,
  `Record Updated Timestamp (GMT8)` text,
  `WAITFORDUMPDURATION` int DEFAULT NULL,
  `WAITFORLOADDURATION` int DEFAULT NULL,
  `WORKINGBURNRATE` double DEFAULT NULL,
  `WORKINGDURATION` int DEFAULT NULL,
  `Source Location Name` text,
  `Source Location Description` text,
  `Source Location is Active Flag` text,
  `Source Location is Source Flag` text,
  `Destination Location Name` text,
  `Destination Location Description` text,
  `Destination Location is Active Flag` text,
  `Destination Location is Source Flag` text,
  `Primary Machine Name` text,
  `Primary Machine Category Name` text,
  `Primary Machine Class Name` text,
  `Secondary Machine Name` text,
  `Secondary Machine Category Name` text,
  `Secondary Machine Class Name` text,
  `Crew OID` bigint DEFAULT NULL,
  `Job Code Description` text,
  `Job Code Name` text,
  `Job Type` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `delaydata` (
  `Delay OID` bigint DEFAULT NULL,
  `Description` text,
  `ECF Class ID` text,
  `Acknowledge Flag` text,
  `Acknowledged Flag` text,
  `Confirmed Flag` text,
  `Engine Stopped Flag` text,
  `Field Notification Required Flag` text,
  `Office Confirm Flag` text,
  `Production Reporting Only Flag` text,
  `Frequency Type` int DEFAULT NULL,
  `Shift Type` text,
  `Target Location` text,
  `Target Road` text,
  `Workorder Ref` text,
  `Delay Class Name` text,
  `Delay Class Description` text,
  `Delay Class is Active Flag` text,
  `Delay Class Category Name` text,
  `Target Machine Name` text,
  `Target Machine is Active Flag` text,
  `Target Machine Class Name` text,
  `Target Machine Class Description` text,
  `Target Machine Class is Active Flag` text,
  `Target Machine Class Category Name` text,
  `Delay Reported By Person Name` text,
  `Delay Reported By User Name` text,
  `Delay Status Description` text,
  `Delay Start Timestamp (GMT8)` text,
  `Delay Finish Timestamp (GMT8)` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
CREATE TABLE `locationdata` (
  `Location_Id` int DEFAULT NULL,
  `Name` text,
  `Latitude` double DEFAULT NULL,
  `Longitude` double DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

USE supplychain_opm;
select * from cycledata;

SELECT DISTINCT ASSOCPAYLOADNOMINAL
FROM cycledata;

/*Imputing null values in assocpayloadnominal with 0*/
UPDATE cycledata
SET ASSOCPAYLOADNOMINAL=0
WHERE ASSOCPAYLOADNOMINAL IS NULL;

SELECT DISTINCT ASSOCPAYLOADNOMINAL
FROM cycledata;

SELECT `AT Available Time (iMine)` , `Available Time` from cycledata;

/*The columns AT Available Time(imine) and Available time represent the available time in seconds for the mine.Hence one of the columns becomes redundant and can be dropped*/

ALTER TABLE cycledata
DROP COLUMN `AT Available Time (iMine)`;


SELECT `CT Calendar SMU Time`,`CT Calendar Time`,`Cycle Duration`,`Cycle SMU Duration`,`COMPLETEDCYCLEDURATION`
from cycledata;

/*Cycle duration is same as regular calendar time*/

SELECT `Delay Time`,`Down Time`,`DTE Down Time Equipment`,`Dumping Duration`,`Dumping SMU Duration` 
FROM cycledata;

/*Delay time wasted in waiting and maintenance time are the same*/

select count(distinct `Dumping Duration`) as dump_time_count,count(distinct `Dumping SMU Duration`) as dump_smu_time from cycledata ;

/* There is no pattern in the values and there are large number of distinct values ,hence null values can be imputed to zero)*/

select count(`Dumping Duration`) as dump_time_count_zero from cycledata where `Dumping Duration`=0 ;

UPDATE cycledata
SET `Dumping Duration`=0 , `Dumping SMU Duration`=0
WHERE `Dumping Duration` & `Dumping SMU Duration` IS NULL;

SELECT `Empty EFH Distance`,`Empty EFH Length`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance`,`Empty Slope Length`,`Empty Target Travel Duration`,`Empty Travel Duration` 
FROM cycledata;

/*Empty rise height represents empty raised height but the values present are in timestamp format.The column has incorrect values and hence can be dropped*/

ALTER TABLE cycledata
DROP COLUMN `Empty Rise Height`;

select count(distinct `Empty EFH Distance`) as EFHD_count,count(distinct `Empty EFH Length`) as EFHL from cycledata ;
select distinct `Empty EFH Distance`,`Empty EFH Length` as EFHL from cycledata ;

/*It can be seen that both Empty efh length and Empty EFH distance columns have the same values.One column becomes redundant and can be dropped.Dropping Empty EFH Length*/
ALTER TABLE cycledata
DROP COLUMN `Empty EFH Length`;

SELECT `Empty EFH Distance`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance`,`Empty Slope Length`,`Empty Target Travel Duration`,`Empty Travel Duration` 
FROM cycledata;

select count(distinct `Empty Slope Distance`) as ESD_count,count(distinct `Empty Slope Length`) as ESL from cycledata ;
select distinct `Empty Slope Distance`,`Empty Slope Length`from cycledata ;

ALTER TABLE cycledata
DROP COLUMN `Empty Slope Length`;

SELECT `Empty EFH Distance`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance`,`Empty Target Travel Duration`,`Empty Travel Duration` 
FROM cycledata;

select distinct `Empty Target Travel Duration` from cycledata;

/*Empty target travel duration has only zero and null values which do not aid in the analysis and can be dropped*/

ALTER TABLE cycledata
DROP COLUMN `Empty Target Travel Duration`;

SELECT `Empty EFH Distance`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance`,`Empty Travel Duration` 
FROM cycledata;

select `Empty Expected Travel Duration`,`Empty Travel Duration` from cycledata
where (`Empty Expected Travel Duration` = 0 ) or (`Empty Travel Duration` = 0 ) ;

/*It can be seen that empty travel duration is null where the empty expected travel duration is null indicating that both the columns are related.Hence let us assume the null values to be zero.*/
UPDATE cycledata
SET `Empty Expected Travel Duration`=0 , `Empty Travel Duration`=0
WHERE `Empty Travel Duration` & `Empty Expected Travel Duration` IS NULL;

SELECT `Empty EFH Distance`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance`,`Empty Travel Duration` 
FROM cycledata;

SELECT ((count(*)-count(`Empty Fall Height`))/count(*))*100 AS efl_NULL_PERCENT,
((count(*)-count(`Empty Plan Length`))/count(*))*100 AS Plan_Length_NULL_PERCENT,
((count(*)-count(`Empty Slope Distance`))/count(*))*100 AS Slope_Distance_NULL_PERCENT,
 ((count(*)-count(`Empty EFH Distance`))/count(*))*100 AS EFH_Distance_NULL_PERCENT FROM cycledata;
 
 /*From the data it can be understood that `Empty EFH Distance`,`Empty Expected Travel Duration`,`Empty Fall Height`,`Empty Plan Length`,`Empty Slope Distance` are null for secondary machine category belonging to truck class.The null values cannot be imputed with average as there may be 
no fall height,plan length or slope distance for this class.Hence these null values should be imputed with zero*/

 UPDATE cycledata
SET `Empty Fall Height`= 0,`Empty Plan Length`= 0,`Empty Slope Distance`=0,`Empty EFH Distance`=0
WHERE `Empty Fall Height` | `Empty Plan Length` | `Empty Slope Distance` | `Empty EFH Distance` IS NULL;
 
SELECT `End Processor Name`,`Cycle End Timestamp (GMT8)` FROM cycledata;
SELECT ((count(*)-count(`End Processor Name`))/count(*))*100 AS End_proc_NULL_PERCENT,
((count(*)-count(`Cycle End Timestamp (GMT8)`))/count(*))*100 AS CycleendTS_NULL_PERCENT
 FROM cycledata;

/* Replacing null values in End Processor name with NA */
UPDATE cycledata
SET `End Processor Name`='NA'
WHERE `End Processor Name` IS NULL;

/*Checking null values in  `Full Expected Travel Duration`,`Full Travel Duration`*/
SELECT `Full Expected Travel Duration`,`Full Travel Duration` FROM cycledata;
SELECT ((count(*)-count(`Full Expected Travel Duration`))/count(*))*100 AS FETDNULL,
((count(*)-count(`Full Travel Duration`))/count(*))*100 AS FTDNULL
 FROM cycledata;
 
 /*Replacing null values in  `Full Expected Travel Duration`,`Full Travel Duration` with 0*/
 UPDATE cycledata
SET `Full Expected Travel Duration`=0 , `Full Travel Duration`=0
WHERE `Full Expected Travel Duration` & `Full Travel Duration` IS NULL;

SELECT `Estimated Fuel Used`,`Fuel Used` FROM cycledata;

UPDATE cycledata
SET `Fuel Used`=0
WHERE `Fuel Used` IS NULL;


SELECT IC ,`Idle Duration` FROM cycledata;
SELECT `iMine Availability`,`iMine Engine Hours`,`iMine Load FCTR Truck`,`iMine Operating Hours`,`iMine Operating Hours` FROM cycledata;
select count(*) from cycledata where `iMine Load FCTR Truck` is null;

UPDATE cycledata
SET `iMine Load FCTR Truck`='NA'
WHERE `iMine Load FCTR Truck` IS NULL;

SELECT `iMine Availability`,`iMine Engine Hours`,`iMine Load FCTR Truck`,`iMine Operating Hours`,`iMine Utilisation` FROM cycledata;

SELECT `Loading Count`,`Loading Duration`,`Loading Efficiency` FROM cycledata;

select * from cycledata where `Loading Count` is null;

SELECT ((count(*)-count(`Loading Count`))/count(*))*100 AS LCNULL,
((count(*)-count(`Loading Duration`))/count(*))*100 AS LDNULL,
((count(*)-count(`Loading Efficiency`))/count(*))*100 AS LENULL
 FROM cycledata;
 
 /*Setting null values in loading count and loading duration as 0 as they do not belong to loader cycle*/
 UPDATE cycledata
SET `Loading Count`=0,`Loading Duration`=0
WHERE `Loading Count` & `Loading Duration` IS NULL;

UPDATE cycledata
SET `Loading Efficiency`=0
WHERE `Loading Efficiency` IS NULL;

SELECT OPERATINGBURNRATE,`OPERATINGTIME (CAT)`,OPERHOURSSECONDS FROM cycledata;
/*Both OPERATINGTIME (CAT)`,OPERHOURSSECONDS  represent operating time in seconds and have the same values.Hence one column can be dropped as it becomes redundant.Dropping OPERHOURSSECONDS*/
select count(distinct `OPERATINGTIME (CAT)`),count(distinct OPERHOURSSECONDS) from cycledata;

ALTER TABLE cycledata
DROP COLUMN OPERHOURSSECONDS;

SELECT ((count(*)-count(`OPERATINGBURNRATE`))/count(*))*100 AS OBRNULL,
((count(*)-count(`OPERATINGTIME (CAT)`))/count(*))*100 AS OTNULL
 FROM cycledata;

/*nO NULL VALUES IN OPERATINGBURNRATE AND OPERATING TIME*/

SELECT OPERATINGBURNRATE,`OPERATINGTIME (CAT)`FROM cycledata;

SELECT `Payload (kg)`,`Payload (t)` FROM cycledata;

SELECT PREVIOUSSECONDARYMACHINE,PREVIOUSSINKDESTINATION FROM cycledata;

SELECT ((count(*)-count(`PREVIOUSSECONDARYMACHINE`))/count(*))*100 AS OBRNULL,
((count(*)-count(`PREVIOUSSINKDESTINATION`))/count(*))*100 AS OTNULL
 FROM cycledata;

SELECT * FROM cycledata where PREVIOUSSECONDARYMACHINE is null;
SELECT DISTINCT PREVIOUSSECONDARYMACHINE FROM cycledata;

SELECT * FROM cycledata where PREVIOUSSINKDESTINATION is null;
SELECT DISTINCT PREVIOUSSINKDESTINATION FROM cycledata;

UPDATE cycledata
SET PREVIOUSSINKDESTINATION='UNKNOWN' ,PREVIOUSSECONDARYMACHINE ='UNKNOWN'
WHERE PREVIOUSSINKDESTINATION | PREVIOUSSECONDARYMACHINE IS NULL;

SELECT QUEUEATSINKDURATION,`Queuing at Sink Duration`,`Queuing at Source Duration`,`Queuing Duration` FROM cycledata;
SELECT count(DISTINCT QUEUEATSINKDURATION),count(DISTINCT `Queuing at Sink Duration`) FROM cycledata;

/*Both QUEUEATSINKDURATION AND `Queuing at Sink Duration` HAVE THE SAME VALUES AND HENCE ONE CAN BE DROPPED*/
ALTER TABLE cycledata
DROP COLUMN QUEUEATSINKDURATION;

SELECT ((count(*)-count(`Queuing at Sink Duration`))/count(*))*100 AS QSINKRNULL,
((count(*)-count(`Queuing at Source Duration`))/count(*))*100 AS QSOURCENULL,
((count(*)-count(`Queuing Duration`))/count(*))*100 AS QDNULL
 FROM cycledata;

select * FROM cycledata WHERE `Queuing Duration`=0;

UPDATE cycledata
SET `Queuing at Sink Duration`=0,`Queuing at Source Duration`=0,`Queuing Duration`=0
WHERE `Queuing at Sink Duration` & `Queuing at Source Duration`& `Queuing Duration` IS NULL;

SELECT SD_SCHEDULEDDOWNTIME, SDE_SCHEDULEDDOWNEQUIP FROM cycledata;
SELECT ((count(*)-count(`SD_SCHEDULEDDOWNTIME`))/count(*))*100 AS sddNULL,
((count(*)-count(`SDE_SCHEDULEDDOWNEQUIP`))/count(*))*100 AS sdeNULL
 FROM cycledata;

select TC,TMPH,`TOTALTIME (CAT)`,`Travelling Empty Duration`,`Travelling Full Duration`,`TRUCKQUEUEATSOURCEDURATION` from cycledata;
select distinct TC from cycledata;

SELECT ((count(*)-count(`TMPH`))/count(*))*100 AS TMPHNULL,
((count(*)-count(`TOTALTIME (CAT)`))/count(*))*100 AS CATNULL,
((count(*)-count(`Travelling Empty Duration`))/count(*))*100 AS TENULL,
((count(*)-count(`Travelling Full Duration`))/count(*))*100 AS TFNULL,
((count(*)-count(`TRUCKQUEUEATSOURCEDURATION`))/count(*))*100 AS TQSNULL
 FROM cycledata;
 
 select distinct TMPH from cycledata;
 select * from cycledata where TMPH IS NOT NULL;
 
 UPDATE cycledata
 SET TMPH=0
 WHERE TMPH IS NULL;
 
 SELECT `Travelling Empty Duration`,`Travelling Full Duration`,`TRUCKQUEUEATSOURCEDURATION` from cycledata;
 SELECT * FROM cycledata WHERE `TRUCKQUEUEATSOURCEDURATION` IS NULL;
 
 UPDATE cycledata
 SET `TRUCKQUEUEATSOURCEDURATION` =0
 WHERE `TRUCKQUEUEATSOURCEDURATION` IS NULL;
 
 SELECT ((count(*)-count(`TMPH`))/count(*))*100 AS TMPHNULL,
((count(*)-count(`TOTALTIME (CAT)`))/count(*))*100 AS CATNULL,
((count(*)-count(`Travelling Empty Duration`))/count(*))*100 AS TENULL,
((count(*)-count(`Travelling Full Duration`))/count(*))*100 AS TFNULL,
((count(*)-count(`TRUCKQUEUEATSOURCEDURATION`))/count(*))*100 AS TQSNULL
 FROM cycledata;
 
 SELECT * FROM cycledata WHERE  `Travelling Empty Duration` IS NULL;
 SELECT * FROM cycledata WHERE  `Travelling Full Duration` IS NULL;
 
 UPDATE cycledata
 SET  `Travelling Empty Duration` =0,`Travelling Full Duration`=0
 WHERE  `Travelling Empty Duration` & `Travelling Full Duration` IS NULL;
 
 SELECT UNSCHEDULEDDOWNCOUNT,UNSCHEDULEDDOWNTIME FROM cycledata;
 
 select distinct UNSCHEDULEDDOWNCOUNT from cycledata;
 select distinct UNSCHEDULEDDOWNTIME from cycledata;
 
 /* Dropping UNSCHEDULEDDOWNCOUNT as all the values are zero and hence cannot contribute anything to analysis*/
ALTER TABLE cycledata
DROP COLUMN UNSCHEDULEDDOWNCOUNT;

SELECT WAITFORDUMPDURATION,WAITFORLOADDURATION,WORKINGBURNRATE,WORKINGDURATION FROM cycledata;

select distinct WAITFORLOADDURATION from cycledata;

/*dropping column WAITFORLOADDURATION as all values were 0 and null*/

ALTER TABLE cycledata
DROP COLUMN WAITFORLOADDURATION;

SELECT DISTINCT WAITFORDUMPDURATION FROM cycledata;
SELECT * FROM cycledata WHERE WAITFORDUMPDURATION IS NULL;

UPDATE cycledata
SET WAITFORDUMPDURATION=0
WHERE WAITFORDUMPDURATION IS NULL;

SELECT `Source Location Name`,`Source Location Description`,
`Source Location is Active Flag`,`Source Location is Source Flag`,`Destination Location Name`,
`Destination Location Description`,`Destination Location is Active Flag`,`Destination Location is Source Flag` FROM cycledata;

UPDATE cycledata
SET `Source Location Description`= 'NA',`Destination Location Name`='NA',`Destination Location Description`='NA'
WHERE `Source Location Description`| `Destination Location Name` |`Destination Location Description` IS NULL;

SELECT ((count(*)-count(`Source Location Name`))/count(*))*100 AS SLNNULL,
((count(*)-count(`Source Location Description`))/count(*))*100 AS SLDNULL,
((count(*)-count(`Source Location is Active Flag`))/count(*))*100 AS SLANULL,
((count(*)-count(`Source Location is Source Flag`))/count(*))*100 AS SLSULL,
((count(*)-count(`Destination Location Name`))/count(*))*100 AS DLNNULL,
((count(*)-count(`Destination Location Description`))/count(*))*100 AS DLNULL,
((count(*)-count(`Destination Location is Active Flag`))/count(*))*100 AS DLANULL,
((count(*)-count(`Destination Location is Source Flag`))/count(*))*100 AS DLDNULL
 FROM cycledata;
 
 UPDATE cycledata
SET `Source Location Name`= 'NA'
where `Source Location Name` IS NULL;

SELECT `Primary Machine Name`,`Primary Machine Category Name`,`Primary Machine Class Name`,
`Secondary Machine Name`,`Secondary Machine Category Name`,`Secondary Machine Class Name` FROM cycledata;

SELECT ((count(*)-count(`Primary Machine Name`))/count(*))*100 AS PMNNNULL,
((count(*)-count(`Primary Machine Category Name`))/count(*))*100 AS PMCNNULL,
((count(*)-count(`Primary Machine Class Name`))/count(*))*100 AS PMCLNNULL,
((count(*)-count(`Secondary Machine Name`))/count(*))*100 AS SMNSULL,
((count(*)-count(`Secondary Machine Category Name`))/count(*))*100 AS SMCNNULL,
((count(*)-count(`Secondary Machine Class Name`))/count(*))*100 AS SMCLNNULL
 FROM cycledata;
 
 SELECT `Crew OID`,`Job Code Description`,`Job Code Name`,`Job Type` FROM cycledata;
 
 select distinct `Job Type` from cycledata;
 select distinct `Job Code Description` from cycledata;
 select distinct `Job Code Name` from cycledata;
 select distinct `Crew OID` from cycledata;
 
 UPDATE cycledata
SET `Job Type`= 'unknown'
where `Job Type` IS NULL;

/*Delay Data*/
select * from delaydata;
Select distinct `Delay OID` from delaydata;
select distinct `Description` from delaydata;
UPDATE delaydata 
SET `Description`='NA'
WHERE nullif(`Description`,'') IS NULL;

SELECT DISTINCT `ECF Class ID` FROM delaydata;

/*only one unique value in ecf class id and hence can be dropped*/

ALTER TABLE delaydata
DROP COLUMN `ECF Class ID`;

SELECT `Acknowledge Flag`,`Acknowledged Flag`,`Confirmed Flag`,`Engine Stopped Flag`,
`Field Notification Required Flag`,`Office Confirm Flag`,`Production Reporting Only Flag` FROM delaydata;

select distinct `Acknowledge Flag`,`Acknowledged Flag`,`Confirmed Flag`,`Field Notification Required Flag`,`Office Confirm Flag`,`Production Reporting Only Flag` from delaydata;

/*Dropping Acknowledge flag column as there are two column representing the same values*/

ALTER TABLE delaydata
DROP COLUMN `Acknowledge Flag`;

SELECT `Acknowledged Flag`,`Confirmed Flag`,`Engine Stopped Flag`,
`Field Notification Required Flag`,`Office Confirm Flag`,`Production Reporting Only Flag` FROM delaydata;

select distinct `Frequency Type` from delaydata;

/*Drop column `Frequency Type` as there is only one unique value*/

ALTER TABLE delaydata
DROP COLUMN `Frequency Type` ;

SELECT distinct `Shift Type`,`Target Location`,`Target Road`,`Workorder Ref` FROM delaydata;

ALTER TABLE delaydata
DROP COLUMN `Shift Type`,
DROP COLUMN `Target Location`,
DROP COLUMN `Target Road`;

SELECT count(`Workorder Ref`) from delaydata where nullif(`Workorder Ref`,'') IS NULL;
ALTER TABLE delaydata
DROP COLUMN `Workorder Ref`;

SELECT `Delay Class Name`,`Delay Class Description`,`Delay Class is Active Flag`,`Delay Class Category Name` from delaydata;

/*Delay class description is not needed and hence can be dropped*/

ALTER TABLE delaydata
DROP COLUMN `Delay Class Description`;

SELECT DISTINCT `Delay Class is Active Flag` FROM delaydata;

SELECT count(`Delay Class is Active Flag`) from delaydata where nullif(`Delay Class is Active Flag`,'') IS NULL;

/*There is only one unique value Y in Delay Class is Active Flag and hence can be dropped*/
ALTER TABLE delaydata
DROP COLUMN `Delay Class is Active Flag`;

SELECT DISTINCT `Delay Class Category Name`,`Delay Class Name` FROM delaydata;

SELECT `Target Machine Name`,`Target Machine is Active Flag`,`Target Machine Class Name`,`Target Machine Class Description`,`Target Machine Class is Active Flag`,`Target Machine Class Category Name` FROM delaydata;

SELECT `Delay Reported By Person Name`,`Delay Reported By User Name`,`Delay Status Description`,`Delay Start Timestamp (GMT8)`,`Delay Start Timestamp (GMT8)` FROM delaydata;

SELECT count(`Delay Reported By User Name`) from delaydata where nullif(`Delay Reported By User Name`,'') IS NULL;

ALTER TABLE delaydata
DROP COLUMN `Delay Reported By Person Name`,
DROP COLUMN `Delay Reported By User Name`;

SELECT `Delay Status Description`,`Delay Start Timestamp (GMT8)`,`Delay Start Timestamp (GMT8)` FROM delaydata;

SELECT distinct `Delay Status Description` from delaydata;

ALTER TABLE delaydata
DROP COLUMN `Delay Status Description`;

SELECT `Location_Id`,`Name`,`Latitude`,`Longitude` FROM locationdata;

/*Null values have been treated in all the columns*/

/*CREATING MASTER TABLES*/
/*Equipment Master*/
CREATE TABLE `Equipment_Master` AS
SELECT `Primary Machine Name`,`Primary Machine Class Name`,`Primary Machine Category Name`,`Secondary Machine Name`,`Secondary Machine Class Name`,`Secondary Machine Category Name`,
`PREVIOUSSECONDARYMACHINE`,`Job Code Name`,`Cycle Type`,`WORKINGDURATION`,`WORKINGBURNRATE`,TC,`TOTALTIME (CAT)`,`TMPH`,`OPERATINGBURNRATE`,`Loading Duration`,`iMine Load FCTR Truck`,`iMine Engine Hours`,`iMine Operating Hours`,`Idle Duration`,
`Full Travel Duration`,`Empty Travel Duration`,`Fuel Used`,`End Processor Name`,`Dumping Duration` ,`Loading Efficiency`,ASSOCPAYLOADNOMINAL 
from 
cycledata;

select * from `Equipment_Master`;

/*Equipment Type Master*/
CREATE TABLE `Equipment Type Master` AS
SELECT `Primary Machine Name`,`Primary Machine Category Name`,`Secondary Machine Category Name`,`Cycle Type`,`Cycle Duration`,`Cycle SMU Duration`,`COMPLETEDCYCLEDURATION`,`Delay Time`,`Down Time`,
`Available Time`,`Available SMU Time`,`Dumping SMU Duration`,`Empty EFH Distance`,`Estimated Fuel Used`,`iMine Availability`,`iMine Utilisation`,`Loading Count`,
`Loading Efficiency`,`Queuing Duration`,`Job Type`
FROM cycledata;

/*Location Master*/
CREATE TABLE `Location Master` AS
SELECT `Primary Machine Name`, `Source Location Name`,`Destination Location Name`,`Destination Dumping Start Timestamp (GMT8)`,`Cycle End Timestamp (GMT8)`,`Source Loading Start Timestamp (GMT8)`,
`Source Loading End Timestamp (GMT8)`,`Queuing at Sink Duration`,`Queuing at Source Duration`,`PREVIOUSSINKDESTINATION`,`TRUCKQUEUEATSOURCEDURATION`
FROM cycledata;

/*Location Type Master*/
CREATE TABLE `Location Type Master` AS
SELECT `Source Location Name`,`Source Location Description`,`Source Location is Active Flag`,`Source Location is Source Flag`,`Destination Location Description`,`Destination Location is Active Flag`,
`Destination Location is Source Flag`,`WAITFORDUMPDURATION`,`Crew OID`
FROM cycledata;

/*Movement data*/
CREATE TABLE `Movement data` AS
SELECT `Primary Machine Name`,`Secondary Machine Name`,`Source Location Name`,`Destination Location Name`,`Payload (kg)`,`Cycle Start Timestamp (GMT8)`,`Cycle End Timestamp (GMT8)`,
`Crew OID`,Location_Id,Latitude,Longitude FROM cycledata as c left join locationdata as l on c.`Destination Location Name`=l.Name;

select * from `Movement data`;


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `CYCLE_DATA`()
BEGIN
SELECT 
`Primary Machine Name`,`Primary Machine Class Name`,`Primary Machine Category Name`,`Secondary Machine Name`,`Secondary Machine Class Name`,
`Secondary Machine Category Name`,`Job Code Name`,`Cycle Type`,`WORKINGDURATION`,TC,`TOTALTIME (CAT)`,`TMPH`,`Payload (kg)`,
`OPERATINGTIME (CAT)`,`Loading Duration`,`iMine Engine Hours`,`Idle Duration`,`Fuel Used`,`Dumping Duration`,`Loading Efficiency` 
from Equipment_Master;
END$$
DELIMITER ;

CALL supplychain_opm.CYCLE_DATA();

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Delay_data`()
BEGIN
select `Delay OID`,`Target Machine Name`,`Delay Class Name`,`Delay Class Category Name`,`Target Machine Class Name`,`Target Machine Class Description`,
`Target Machine Class Category Name`,`Engine Stopped Flag`,`Field Notification Required Flag`,`Production Reporting Only Flag`,`Delay Start Timestamp (GMT8)`,
`Delay Finish Timestamp (GMT8)` from delaydata;
END$$
DELIMITER ;

CALL supplychain_opm.Delay_data();


DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `Movement Data`()
BEGIN
select `Primary Machine Name`,`Secondary Machine Name`,`Source Location Name`,`Destination Location Name`,`Payload (kg)`,`Cycle Start Timestamp (GMT8)`,`Cycle End Timestamp (GMT8)`,
`Crew OID`,Location_Id,Latitude,Longitude from `movement data`;
END$$
DELIMITER ;
CALL supplychain_opm.`Movement data`();

/*Creating table for OEE calculations*/
CREATE TABLE OEE_CALCULATIONS AS
SELECT `Available Time`,`Down Time`,`iMine Operating Hours`,`Idle Duration`,`OPERATINGTIME (CAT)`,
(((`Available Time`-`Down Time`)/`Available Time`)*100) as Availability,
(((`OPERATINGTIME (CAT)`-`Idle Duration`)/`OPERATINGTIME (CAT)`)*100) as Performance,
(((`iMine Operating Hours`-`Down Time`)/(`Down Time`+`Idle Duration`))*100) as Quality,
((((`Available Time`-`Down Time`)/`Available Time`))*(((`OPERATINGTIME (CAT)`-`Idle Duration`)/`OPERATINGTIME (CAT)`))*((`iMine Operating Hours`-`Down Time`)/(`Down Time`+`Idle Duration`)))*100 as OEE
from cycledata;

select * from oee_calculations;

alter table oee_calculations
modify column `Quality` varchar(20);

update oee_calculations
set `Quality` = 'No loss'
where Quality is null;

DELIMITER $$
CREATE DEFINER=`root`@`localhost` PROCEDURE `OEE_CALCULATIONS`()
BEGIN
SELECT `Available Time`,`Down Time`,`iMine Operating Hours`,`Idle Duration`,
`OPERATINGTIME (CAT)`,Availability,Performance,Quality,OEE 
FROM oee_calculations;

END$$
DELIMITER ;
