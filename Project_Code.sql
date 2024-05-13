-- CREATE TABELS AND CONSTRAINTS --

CREATE TABLE CUSTOMERS(
EmailAddress varchar(40) PRIMARY KEY NOT NULL,
FirstName varchar(20) NOT NULL,
LastName varchar(20) NOT NULL,
PhoneNumber varchar(20), 

CONSTRAINT ck_Email CHECK (EmailAddress like '%@%.%'),
CONSTRAINT ck_PhoneNumber CHECK (DATALENGTH(PhoneNumber)>9)
)

CREATE TABLE PREMIUMS(
EmailAddress varchar(40) PRIMARY KEY NOT NULL,
ExpirationDate dateTime NOT NULL,

CONSTRAINT FK_CUSTOMERS FOREIGN KEY (EmailAddress) References CUSTOMERS (EmailAddress),
CONSTRAINT ck_ExpirationDate CHECK ( getDate() < ExpirationDate)
 )

 CREATE TABLE UPGRADES(
 PurchaseNumber varchar(20) PRIMARY KEY NOT NULL,
 UpgradeDate dateTime NOT NULL, 
 Price smallmoney NOT NULL,
 EmailAddress varchar(40) NOT NULL,
 	
CONSTRAINT FK_PREMIUMS FOREIGN KEY (EmailAddress) References PREMIUMS (EmailAddress),
CONSTRAINT Ck_Price
CHECK (Price > 0)
)


 CREATE TABLE POSTERS(
 PosterID varchar(20) PRIMARY KEY NOT NULL,
 Type varchar(20) NOT NULL,
 Size varchar(20) NOT NULL,
 EmailAddress varchar(40) NOT NULL,

CONSTRAINT FK_CUSTOMERS_POSTERS FOREIGN KEY (EmailAddress) References CUSTOMERS (EmailAddress),
 CONSTRAINT ck_POSTERS CHECK (Size like '%X%')
 )

 CREATE TABLE CUSTOMIZES(
 PosterID varchar(20) PRIMARY KEY NOT NULL,
 Photo varchar(100) NULL,
 Elements varchar(20)   NULL,
 background varchar(20)  NULL,
 Media varchar(20) default NULL,
 Layout varchar(20) default NULL,
 EmailAddress varchar(40) NOT NULL,
 
CONSTRAINT FK_PREMIUMS_CUSTOMIZES FOREIGN KEY (EmailAddress) References PREMIUMS (EmailAddress),
CONSTRAINT PK_CUSTOMIZES FOREIGN KEY (PosterID) References POSTERS (PosterID),
CONSTRAINT FK_POSTERS FOREIGN KEY (PosterID) References POSTERS (PosterID)
)


 CREATE TABLE CREDITCARDS(
 CardNumber varchar(16) PRIMARY KEY NOT NULL,
 ExpirationDate date NOT NULL,
 CompanyOfCard varchar(20) NOT NULL,
 CVV varchar(4) NOT NULL,
 OwnerID varchar(20) NOT NULL,
 EmailAddress varchar(40) NOT NULL,

 CONSTRAINT FK_PREMIUMS_CREDITCARDS FOREIGN KEY (EmailAddress) References PREMIUMS (EmailAddress),
 CONSTRAINT CK_CardNumber check (CardNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
 CONSTRAINT CK_ExpirationDT check (year(ExpirationDate) >(year(getdate())) or (year(ExpirationDate)=(year(getdate())) 
 and month(ExpirationDate)>(month(getdate())))),
 CONSTRAINT CK_CVV check (DATALENGTH (CVV)=3 or DATALENGTH (CVV)=4)
 )

  -- LOOK UP TABLE for SIZES --
CREATE TABLE SIZES ( 
Size varchar(20) PRIMARY KEY NOT NULL
)

 --LOOK UP TABLE FOR CARD'S COMPANIES --
 CREATE TABLE COMPANIESOFCARDS(
 CompanyOfCard varchar(20) PRIMARY KEY NOT NULL
 )

 -- INSERT DATA -- 

 INSERT INTO CUSTOMERS VALUES
 ('OdedMenashe@gmail.com', 'Oded', 'Menashe', '052-5555555'),
 ('TalMuseri@walla.com', 'Tal' , 'Museri', '050-3332222'),
 ('KobiMahat@hotmail.com', 'Kobi', 'Mahat', '054-4445555'),
 ('TomAvni@gmail.com', 'Tom', 'Avni', '050-0500500'),
 ('YanivAMagniv@gmail.com', 'Yaniv' , 'TheCool' , '052-4443331'),
 ('MottiLohim@walla.com', 'Motti' , 'Lohim' , '052-9333863'),
 ('OdedPaz@gmail.com', 'Oded' , 'Paz' , '052-9464071'),
 ('KobiFaraj@hotmail.com', 'Kobi' , 'Faraj' , '052-55497620'),
 ('GarryHamborgey@walla.com', 'Garry' , 'Hambu' , '052-7482832'),
 ('IlanRozenfeld@gmail.com', 'Ilan' , 'Rozenfeld' , '050-8892653')


 INSERT INTO PREMIUMS VALUES
 ('TalMuseri@walla.com', '2022-07-05 12:22:13'),
 ('YanivAMagniv@gmail.com','2022-08-03 13:59:11'),
 ('TomAvni@gmail.com', '2022-07-07 21:34:40'),
 ('IlanRozenfeld@gmail.com', '2022-09-09 20:00:01'),
 ('KobiFaraj@hotmail.com', '2022-10-10 13:13:13')

 INSERT INTO UPGRADES VALUES
 ('001', '2022-06-05 12:22:13', '9.95'),
 ('002', '2022-07-03 13:59:11', '9.95'),
 ('003', '2022-06-07 21:34:40', '9.95'),
 ('004', '2022-09-09 20:00:01', '9.95'),
 ('005', '2022-10-10 13:13:13', '9.95')

INSERT INTO POSTERS VALUES
 ('A01', 'Flyer', '2X6' ),
 ('A02', 'Logo', '600X600'),
 ('A03', 'Banner', '760X100'),
 ('B01', 'Label', '1080X1920'),
 ('B02', 'Tag', '600X200'),
 ('B03', 'PostCard', '14.8X10.5'),
 ('C01', 'Poster', '24X36')

 INSERT INTO CREDITCARDS VALUES
 ('1234567898765432','2022-06-02','American Express', '1333', '205592948'),
 ('3061546874651233','2023-07-02','Isracard', '202', '305164230'),
 ('9494948494910201','2025-06-02','VISA', '131', '310582754'),
 ('1054867954567897','2023-03-02','Mastercard', '345', '109888432'),
 ('1234567222254322','2025-10-02','Mastercard', '999', '205592948'),
 ('2023034404545461','2024-12-02','VISA', '133', '325486201')
 
 INSERT INTO CUSTOMIZES VALUES
 ('A01', '1' , 'https://media-cdn.tripadvisor.com/media/photo-s/05/f0/9b/c5/view-from-bears-hump.jpg', 'Square Shape', 'Solid Color-Yellow', 'Follow the sun', 'Classic Table'),
 ('A02', '2', 'http://www.zavit.org.il/wp-content/uploads/2019/02/tincho-franco-unsplash.jpg' , 'Sun Sticker', 'Solid Color-Blue', 'Follow the sun' , 'Classic Menu'),
 ('A03', '3', 'https://media-cdn.tripadvisor.com/media/photo-s/1a/b8/46/6d/london-stock.jpg', 'Menu Sticker', 'Gradient-Grey', 'Maaliyot', 'Modern Menu'),
 ('B01', '4', 'https://i.scdn.co/image/ab67616d0000b2735adf9b02191b35ef47272a62',
 'QR-Code', 'Gradient-Red', 'Classic Music', 'Classic Schedule'),
 ('B02', '5', 'https://www.goya.com/media/7864/hummus.jpg?quality=80', 'Menu Sticker', 'Transparent', 'Bahof Shel Portugal', 'Classic Menu'),
 ('B03', '6', 'https://lorilongbotham.com/wp-content/uploads/2017/07/poker_night.jpg',
 'Cards Sticker', 'Gradinet-Black', 'Jazz Music', 'Modern Schedule'),
 ('C01', '7', 'https://i.ytimg.com/vi/5G-w8LQ5kNY/maxresdefault.jpg', 'Drum Sticker', 'Solid-Black', 'Drum and Bass Music', 'Classic Schedule')



INSERT INTO SIZES 	
SELECT 	DISTINCT Size 
FROM POSTERS

ALTER TABLE POSTERS 	
ADD CONSTRAINT Fk_Size
FOREIGN KEY (Size)  
REFERENCES 	SIZES (Size)

INSERT INTO COMPANIESOFCARDS	
SELECT 	DISTINCT CompanyOfCard 
FROM CREDITCARDS

ALTER TABLE CREDITCARDS 	
ADD CONSTRAINT   Fk_CompanyOfCard
FOREIGN KEY 	(CompanyOfCard)  
REFERENCES	COMPANIESOFCARDS (CompanyOfCard)                                             


-- DROP LOOKUP TABLES AND KEYS --

ALTER TABLE POSTERS
DROP CONSTRAINT Fk_Size

ALTER TABLE CREDITCARDS
DROP CONSTRAINT Fk_CompanyOfCard

ALTER TABLE PREMIUMS
DROP CONSTRAINT FK_CUSTOMERS

ALTER TABLE CUSTOMIZES
DROP CONSTRAINT FK_POSTERS


-- DROP TABLES --
  DROP TABLE SIZES
  DROP TABLE COMPANIESOFCARDS
  DROP TABLE PREMIUMS
  DROP TABLE CUSTOMERS
  DROP TABLE CUSTOMIZES
  DROP TABLE POSTERS
  DROP TABLE CREDITCARDS
  DROP TABLE UPGRADES


 SELECT P.EmailAddress ,FULL_NAME = CC.FirstName + ' ' + CC.LastName ,TOTAL = SUM(U.Price)    
FROM PREMIUMS AS P JOIN UPGRADES AS U ON P.EmailAddress = U.EmailAddress JOIN CREDITCARDS AS C ON P.EmailAddress = C.EmailAddress JOIN CUSTOMERS AS CC ON CC.EmailAddress = P.EmailAddress
WHERE MONTH(U.UpgradeDate) BETWEEN 4 AND 8
GROUP BY P.EmailAddress , CC.FirstName , CC.LastName
ORDER BY TOTAL DESC

--הלקוחות פרמיום שהצטרפו בחצי שנה האחרונה ושילמו הכי הרבה כסף שהשתמשו בתמונות של חיות--
Select P.EmailAddress, U.UpgradeDate, U.Price,
FROM PREMIUMS AS P JOIN UPGRADES AS U ON P.EmailAddress=U.EmailAddress JOIN (Select TOP 15 P1.EmailAddress, SUM = SUM(U1.Price)
                                                                             FROM PREMIUMS as P1 JOIN UPGRADES as U1 on P1.EmailAddress=U1.EmailAddress
																			 group by P1.EmailAddress
																			 Order by SUM DESC) AS P1U1 ON P.EmailAddress=P1U1.EmailAddress 																		
Where Year(U.UpgradeDate)-Year(GetDate())=0 AND MONTH(GetDate())-MONTH(U.UpgradeDate) BETWEEN 0 and 6
INTERSECT
Select C.EmailAddress, U.UpgradeDate, U.Price
FROM CUSTOMIZES AS C JOIN UPGRADES AS U ON C.EmailAddress=U.EmailAddress
Where C.Photo is not null
order by U.Price DESC

select count(*)
from posters

select count(*)
from customizes

select *
From Premiums as P JOIN CUSTOMIZES as C on P.EmailAddress=C.EmailAddress

CREATE VIEW	elements_customize AS
SELECT		C.Elements,Total=count(c.Elements)
FROM		PREMIUMS AS p JOIN CUSTOMIZES AS C ON p.EmailAddress=C.EmailAddress join (select top 3 C.Elements,Total=count(c.Elements)
							from UPGRADES AS u JOIN CUSTOMIZES AS C ON u.EmailAddress=C.EmailAddress
							where C.elements NOT LIKE 'NULL'
							group by c.Elements
							order by Total desc
)as re on re.Elements=C.Elements
GROUP By c.Elements

select *
from elements_customize



--הלקוחות פרמיום שהצטרפו בחודשיים האחרונים ושילמו הכי הרבה כסף שהשתמשו בתמונות של חיות--
Select P.EmailAddress, U.UpgradeDate, U.Price
FROM PREMIUMS AS P JOIN UPGRADES AS U ON P.EmailAddress=U.EmailAddress JOIN (Select TOP 15 P1.EmailAddress, SUM = SUM(U1.Price)
                                                                             FROM PREMIUMS as P1 JOIN UPGRADES as U1 on P1.EmailAddress=U1.EmailAddress
																			 group by P1.EmailAddress
																			 Order by SUM DESC) AS P1U1 ON P.EmailAddress=P1U1.EmailAddress 																		
Where Year(U.UpgradeDate)-Year(GetDate())=0 AND MONTH(GetDate())-MONTH(U.UpgradeDate) BETWEEN 0 and 2
INTERSECT
Select C.EmailAddress, U.UpgradeDate, U.Price
FROM CUSTOMIZES AS C JOIN UPGRADES AS U ON C.EmailAddress=U.EmailAddress
Where C.Photo is not null


Select *
From PREMIUMS as P JOIN CUSTOMIZES as C on P.EmailAddress=C.EmailAddress




Where Year(U.UpgradeDate)-Year(GetDate())=0 AND MONTH(GetDate())-MONTH(U.UpgradeDate) BETWEEN 0 and 2
INTERSECT
Select C.EmailAddress, U.UpgradeDate, U.Price
FROM CUSTOMIZES AS C JOIN UPGRADES AS U ON C.EmailAddress=U.EmailAddress
Where C.Photo is not null


Select  P.EmailAddress
FROM PREMIUMS AS P JOIN UPGRADES AS U ON P.EmailAddress=U.EmailAddress JOIN (Select TOP 100 P1.EmailAddress, SUM = SUM(U1.Price)
                                                                             FROM PREMIUMS as P1 JOIN UPGRADES as U1 on P1.EmailAddress=U1.EmailAddress
																			 group by P1.EmailAddress
																			 Order by SUM DESC) AS P1U1 ON P.EmailAddress=P1U1.EmailAddress 																		
Where Year(U.UpgradeDate)-Year(GetDate())=0 AND MONTH(GetDate())-MONTH(U.UpgradeDate) BETWEEN 0 and 2
Group by P.EmailAddress
order by P.EmailAddress


INTERSECT
Select U.EmailAddress, SUM=SUM(U.Price)
FROM CUSTOMIZES AS C JOIN UPGRADES AS U ON C.EmailAddress=U.EmailAddress
Where C.Photo is not null
Group by U.EmailAddress 
order by SUM DESC



--כל הפוסטרים שאין בהם פוטו--
Select  P.EmailAddress
FROM CUSTOMIZES AS C JOIN PREMIUMS as P ON C.EmailAddress = P.EmailAddress 
Where C.Photo is null
order by P.EmailAddress

--כל הלקוחות שהצטרפו בחודשיים האחרונים וחישוב של כמות הכסף שהרווחנו מהם--
Select P.EmailAddress
FROM PREMIUMS AS P JOIN UPGRADES AS U ON P.EmailAddress=U.EmailAddress JOIN (Select TOP 20 P1.EmailAddress, SUM = SUM(U1.Price)
                                                                             FROM PREMIUMS as P1 JOIN UPGRADES as U1 on P1.EmailAddress=U1.EmailAddress
																			 group by P1.EmailAddress
																			 Order by SUM DESC) AS P1U1 ON P.EmailAddress=P1U1.EmailAddress 																		
Where Year(U.UpgradeDate)-Year(GetDate())=0 AND MONTH(GetDate())-MONTH(U.UpgradeDate) BETWEEN 0 and 6


INTERSECT
--כל לקוחות שהשתמשו בתמונות בפוסטר שלהם--
Select  P.EmailAddress 
FROM CUSTOMIZES AS C JOIN PREMIUMS as P ON C.EmailAddress = P.EmailAddress 
Where C.Photo is not null

--השאילתה הזו מוציאה את כל הלקוחות שהצטרפו בחודשיים האחרונים והשמששו בתמונות בפוסטרים שלהם--

---------TRIGGER----------
--ADD NEW TABLE for CC_Archive	
Create Table CreditCards_Archive(
 CardNumber varchar(16) NOT NULL,
 ExpirationDate date NOT NULL,
 CompanyOfCard varchar(20) NOT NULL,
 CVV varchar(4) NOT NULL,
 OwnerID varchar(20) NOT NULL,
 EmailAddress varchar(40) NOT NULL,
 )


CREATE Trigger UpdatePremiums ON PREMIUMS 
For UPDATE
AS
BEGIN
Declare @Proportion varchar (40)
DECLARE @Sum varchar(40)
Select 
From DELETED 
INSERT INTO CreditCards_Archive
Select *
From DELETED
END

select *
from PREMIUMS

select *
from UPGRADES

--Command for Trigger--
DELETE FROM CREDITCARDS
WHERE EmailAddress in ( SELECT EmailAddress
						FROM PREMIUMS
						WHERE ExpirationDate<getDate())


						SELECT DISTINCT TOP 10 C.EmailAddress , [FULL NAME] = C.FirstName + ' ' + C.LastName , CC.background
FROM CUSTOMERS AS C JOIN CUSTOMIZES AS CC ON C.EmailAddress = CC.EmailAddress
WHERE CC.background IN (
                     SELECT DISTINCT TOP 5  CC.background 
                     FROM PREMIUMS AS P JOIN CUSTOMIZES AS CC ON P.EmailAddress = CC.EmailAddress
					 ORDER BY CC.background 
                     )
GROUP BY C.EmailAddress  , C.FirstName , C.LastName , CC.background
ORDER BY CC.background



SELECT DISTINCT TOP 10 C.EmailAddress , [FULL NAME] = C.FirstName + ' ' + C.LastName , CC.background
FROM CUSTOMERS AS C JOIN CUSTOMIZES AS CC ON C.EmailAddress = CC.EmailAddress
WHERE CC.background IN (
                     SELECT DISTINCT TOP 5  CC.background 
                     FROM PREMIUMS AS P JOIN CUSTOMIZES AS CC ON P.EmailAddress = CC.EmailAddress
					 ORDER BY CC.background 
                     )
GROUP BY C.EmailAddress  , C.FirstName , C.LastName , CC.background
ORDER BY CC.background

Alter Table Customers
add Status varchar(40)

ALTER TABLE CUSTOMERS
drop column status

Select C.EmailAddress, TotalPrice, 
UPDATE Customers
Status = Case
when TotalPrice >= 50 then 'Top Client'
ELSE 'Regular Client'
END
From Customers as C JOIN (Select P.EmailAddress, TotalPrice = Sum(U.price)
                          From Premiums as P JOIN UPGRADES as U ON P.EmailAddress=U.EmailAddress
						  Group By P.EmailAddress) AS PU on C.EmailAddress=PU.EmailAddress

--שאילתה אשר מעדכנת לכל לקוח האם הוא פרמיום או טופ פרמיום בטבלת הלקוחות לפי כמות הכסף שבזבז בחברה

--הוספת עמודת סטטוס--
Alter Table Customers
add Status varchar(40)

--עדכון עמודת סטטוס--
UPDATE Customers set
Status = Case
when TotalPrice >= 50 then 'Top-Premium Client'
when TotalPrice < 50 then'Premium Client'
Else ''
END
From Customers as C JOIN (Select P.EmailAddress, TotalPrice = Sum(U.price)
                          From Premiums as P JOIN UPGRADES as U ON P.EmailAddress=U.EmailAddress
						  Group By P.EmailAddress) AS PU on C.EmailAddress=PU.EmailAddress


/*Select C.EmailAddress, Status, TotalPrice,
Status = case
When FirstName like 'Agna' then 'FAT'
when LastName Like 'Boner' then 'THIN'
else 'c'
end
From Customers as C JOIN (Select TOP 100 P.EmailAddress, TotalPrice = Sum(U.price)
                          From Premiums as P JOIN UPGRADES as U ON P.EmailAddress=U.EmailAddress
						  Group By P.EmailAddress) AS PU on C.EmailAddress=PU.EmailAddress */



select *
from Customers 

select *
from upgrades as u JOIN UPGRADES as U2 on u.EmailAddress=U2.EmailAddress





DELETE FROM CREDITCARDS
WHERE EmailAddress in ( SELECT EmailAddress
						FROM PREMIUMS
						WHERE ExpirationDate<getDate()
						)



						--DROP VIEW CUSTOMERS_SPENDS
CREATE VIEW	elements_customize AS
SELECT		C.Elements,Total=count(c.Elements)
FROM		PREMIUMS AS p JOIN CUSTOMIZES AS C ON p.EmailAddress=C.EmailAddress join (select top 5 C.Elements,Total=count(c.Elements)
							from UPGRADES AS u JOIN CUSTOMIZES AS C ON u.EmailAddress=C.EmailAddress
							where c.Elements is not null
							group by c.Elements
							order by Total desc
)as re on re.Elements=C.Elements
GROUP By c.Elements	


select *
from elements_customize

drop view elements_customize

select top 3 C.Elements,Total=count(c.Elements)
from UPGRADES AS u JOIN CUSTOMIZES AS C ON u.EmailAddress=C.EmailAddress
group by c.Elements
order by Total desc


--FUNCTION 1--
CREATE FUNCTION TOTAL_REVENUE (@today_date dateTime)
RETURNS REAL
AS BEGIN

			DECLARE @OUTPUT_Total Real
			SELECT @OUTPUT_Total =sum(U.Price)
			FROM UPGRADES As U
			WHERE year(U.UpgradeDate)=year(@today_date) and month(U.UpgradeDate)=month(@today_date)
			
			
RETURN @OUTPUT_Total
END

SELECT AMOUNT=dbo.TOTAL_REVENUE('09/29/2022')

drop function TOTAL_REVENUE


--function 2--
CREATE FUNCTION usElement (@element varchar(30))
RETURNS TABLE
AS RETURN
	SELECT  P.EmailAddress,C.PosterID,P.ExpirationDate
	FROM CUSTOMIZES AS C join PREMIUMS AS P on p.EmailAddress = c.EmailAddress
	WHERE C.Elements=@element



	SELECT *
	FROM dbo.usElement('QR-Code')

	drop function usElement

	   


 Select P.EmailAddress, NumOfUpgrades = Count(P.EmailAddress)
       From Premiums as P JOIN UPGRADES as U on P.EmailAddress=U.EmailAddress
	   Group By P.EmailAddress

	   NumOfUpgrades > 1

CREATE TABLE ReturnClients_Archive(
EmailAddress varchar(40) PRIMARY KEY NOT NULL,
NumOfUpgrades int NOT NULL
)





Select P.EmailAddress, NumOfUpgrades = Count(P.EmailAddress)
                         From Premiums as P JOIN UPGRADES as U on P.EmailAddress=U.EmailAddress
						 Group By P.EmailAddress






CREATE Trigger UpdateCreditCards ON CreditCards 
For DELETE
AS
BEGIN
Declare @EmailAddress varchar (40)
Select @EmailAddress= DELETED.EmailAddress
From DELETED 
INSERT INTO CreditCards_Archive
Select *
From DELETED
END




d



CREATE Trigger UpdateReturnClients ON Premiums
For INSERT
AS
INSERT INTO ReturnClients_Archive 
Select EmailAddress, NumOfUpgrades
 FROM inserted 
 where ( Select P.EmailAddress, NumOfUpgrades = Count(P.EmailAddress)
       From Premiums as P JOIN UPGRADES as U on P.EmailAddress=U.EmailAddress
	   Group By P.EmailAddress)
-----------------------------------------
Create TRIGGER UpdateReturnClients ON Premiums
AFTER INSERT
AS 
BEGIN
DECLARE @EmailAddress varchar(40)
DECLARE @NumOfUpgrades int

SELECT @EmailAddress = i.EmailAddress, @NumOfUpgrades=Count(P.EmailAddress)
FROM inserted as i JOIN (Premiums as P JOIN UPGRADES as U on P.EmailAddress=U.EmailAddress) --as PU
--on i.EmailAddress=PU.EmailAddress

    INSERT INTO ReturnClients_Archive
    EmailAddress,NumOfUpgrades
    select @EmailAddress ,@NumOfUpgrades 
	where (@NumOfUpgrades >2)
END


--Trigger--
CREATE Trigger UpdateReturnClients 
	ON UPGRADES
    FOR INSERT
AS
BEGIN

    SELECT INSERTED.EmailAddress , NumOfUpgrades = COUNT(INSERTED.EmailAddress)
	FROM inserted JOIN UPGRADES ON inserted.EmailAddress = UPGRADES.EmailAddress
	WHERE INSERTED.EmailAddress  IN (SELECT H.EmailAddress 
	                        FROM ( Select P.EmailAddress, NumOfUpgrades =
Count(P.EmailAddress)
From Premiums as P JOIN UPGRADES as U on   P.EmailAddress=U.EmailAddress
	                                Group By P.EmailAddress 
	                             ) AS H 
                          		  WHERE H.NumOfUpgrades > 2
	               )
GROUP BY INSERTED.EmailAddress			   
	
		   INSERT INTO ReturnClients_Archive
		   SELECT EmailAddress , NumOfUpgrades=COUNT(inserted.UpgradeDate)
   FROM inserted
          WHERE INSERTED.EmailAddress NOT IN (SELECT R.EmailAddress
	       					    FROM ReturnClients_Archive AS R
								)
  GROUP BY EmailAddress
  
    END


	--table for trigger--
CREATE table ReturnClients_Archive(
EmailAddress varchar(40) primary key not null,
NumOfUpgrades int
)
--execute--
INSERT INTO UPGRADES VALUES
(255, '2022-06-05 12:22:13.000', 9.9500, 'aantoniades1a@ow.ly'),
(249, '2022-06-05 12:22:13.000', 9.9500, 'joneill2@dagondesign.com')
  DROP TRIGGER UPDATERETURNCLIENTS


(249, '2022-06-05 12:22:13.000', '9.9500', 'joneill2@dagondesign.com')


 10	2022-09-07 10:29:00.000	9.9500	ecaberay@oracle.com


 
CREATE TABLE ReturnClients_Archive(
EmailAddress varchar(40)
)

Select *
From ReturnClients_Archive

Select EmailAddress, numofUpgrades=Count(EmailAddress)
From ReturnClients_Archive
group by emailaddress

CREATE TABLE ReturnClients_Archive(
EmailAddress varchar(40) ,
numofupgrades int
)

DROP TABLE RETURNCLIENTS_Archive

Select EmailAddress
FROM CUSTOMERS
EXCEPT
Select EmailAddress
FROM UPGRADES


CREATE VIEW VIEW_POSTERMYWALL AS
SELECT C.EmailAddress,[FULL NAME]=(C.FirstName+' '+C.LastName),C.PhoneNumber,[Expiration Date PREMIUMS]= P.ExpirationDate,CCD.CardNumber,CCD.CompanyOfCard,
CCD.CVV,[Expiration Date CREDIT CARD]=CCD.ExpirationDate,CCD.OwnerID,U.Price,U.PurchaseNumber,U.UpgradeDate,PO.PosterID,PO.Size,PO.Type,
CU.Photo,CU.Elements,CU.background,CU.Media,CU.Layout
FROM CUSTOMERS AS C JOIN PREMIUMS AS P ON C.EmailAddress=P.EmailAddress
JOIN UPGRADES AS U ON C.EmailAddress=U.EmailAddress
JOIN CREDITCARDS AS CCD ON U.EmailAddress=CCD.EmailAddress
JOIN POSTERS AS PO ON C.EmailAddress=PO.EmailAddress
JOIN CUSTOMIZES AS CU ON PO.EmailAddress=CU.EmailAddress





DROP TABLE ReturnClients_Archive

CREATE table ReturnClients_Archive(
EmailAddress varchar(40) primary key not null,
NumOfUpgrades int
)

--Update number of upgrades for clients--
CREATE Trigger UpdateReturnClients 
	ON UPGRADES
    FOR INSERT
AS
BEGIN
    SELECT INSERTED.EmailAddress , NumOfUpgrades = COUNT(INSERTED.EmailAddress)
	FROM inserted JOIN UPGRADES ON inserted.EmailAddress = UPGRADES.EmailAddress
	WHERE INSERTED.EmailAddress  IN (SELECT H.EmailAddress 
	                        FROM ( Select P.EmailAddress, NumOfUpgrades = Count(P.EmailAddress)
                                    From Premiums as P JOIN UPGRADES as U on P.EmailAddress=U.EmailAddress
	                                Group By P.EmailAddress 
	                                ) AS H 
                            WHERE H.NumOfUpgrades > 2
	               )
	GROUP BY INSERTED.EmailAddress
	
	IF DECLARE  @EmailAddres varchar(40) = EmailAddres.inserted
	@EmailAddress  IN (Select EmailAddress
	                                          from ReturnClients_Archive)
									          BEGIN
									          Update ReturnClients_Archive
									          SET ReturnClients_Archive.NumOfUpgrades += 1
									         END
ELSE
BEGIN
				   INSERT INTO ReturnClients_Archive	
				   SELECT EmailAddress , NumOfUpgrades = COUNT(EmailAddress)
                   FROM inserted
				   GROUP BY EmailAddress
END
				   END


				   INSERT INTO UPGRADES VALUES
(328, '2022-06-05 12:22:13.000', 9.9500, 'bdoctor9@xinhuanet.com')


select *
FROM RETURNCLIents_Archive


DROP TRIGGER UpdateReturnClients


select *
from POSTERs

select *
from UPGRADES

Select P.PosterID, P.EmailAddress, P.Type, U.price,
PERCENT_Rank() over (partition by p.type order by P.EmailAddress) as Precent_Rank 
From POSTERS as p join UPGRADES as U on P.EmailAddress=U.EmailAddress

select*
from customers as c join posters as p on c.emailaddress = p.emailaddress


select c.emailaddress , totalposters=count(c.emailaddress)
from customers as c join posters as p on c.emailaddress = p.emailaddress
where c.emailaddress like 'bkintish3u@github.com'
group by c.emailaddress

select c.emailaddress ,p.type , NumOfTypes=count(p.type)
from posters as p join customers as c on p.emailaddress=c.emailaddress
where c.emailaddress like 'bkintish3u@github.com'
group by c.emailaddress, p.type



---------sheilta tova---------------
select  p1.emailaddress , p2.type ,p1.TotalPosters, p2.NumOfTypes ,PrecentbyType=(100* PERCENT_RANK() over (order by p2.numoftypes))
from (select c.emailaddress , totalposters=count(c.emailaddress)
      from customers as c join posters as p on c.emailaddress = p.emailaddress
      group by c.emailaddress
      ) as p1
join (
      select c.emailaddress ,p.type , NumOfTypes=count(p.type)
      from posters as p join customers as c on p.emailaddress=c.emailaddress
      group by c.emailaddress, p.type
       ) as p2 on p1.emailaddress = p2.emailaddress

	   order by p1.emailaddress
	   

select *
from UPGRADES

select *
from posters
-----------------------------
Select TotalPrice=sum(price)
From upgrades 

Select distinct  BigQuery.emailaddress, BigQuery.TotalByClient, BigQuery.Precent ,LowerElement=(Select Find_lower_element.elements
                                                                                              From (Select Lag_for_Lower_Element.EMailaddress, Lag_for_Lower_Element.Elements
                                                                                                    From (Select Find_Elements_Count.emailaddress, Find_Elements_Count.elements, lowerElement=LAG(Find_Elements_Count.ElementsCount,1,-1) OVER (partition by Find_Elements_Count.emailaddress order by Find_Elements_Count.elements)
                                                                                                          From (Select cus.emailaddress ,cus.elements ,ElementsCount = count(cus.elements)
                                                                                                                From CUstomizes as Cus JOIN upgrades as U on cus.emailaddress=u.emailaddress 
                                                                                                                where Cus.elements is not null
                                                                                                                group by cus.emailaddress,cus.elements) as Find_Elements_Count
                                                                                                                )as Lag_for_Lower_Element
																									    
                                                                                                    where (Lag_for_Lower_Element.lowerElement=-1)) as Find_lower_element
                                                                                             where (BigQuery.emailaddress=Find_lower_element.emailaddress)) 
From (Select Find_PrecentRankToClient.emailaddress, Find_PrecentRankToClient.TotalByClient,  Find_PrecentRankToClient.precent, Cus.Elements, cus.posterID
       From Customizes as Cus JOIN (select PU.emailaddress, PU.TotalbyClient, Precent= Round(100* (PERCENT_RANK() over (order by pu.totalbyclient)),2)
                                    From (select p.emailaddress, TotalbyClient=sum(u.price)
                                           from Posters as p join upgrades as u on p.emailaddress=u.emailaddress
                                            group by p.emailaddress) as PU) as Find_PrecentRankToClient on Cus.emailaddress=Find_PrecentRankToClient.emailaddress
                                            where (Cus.elements is not null) ) as BigQuery
where (BigQuery.Precent > 50)
order by Emailaddress 



Select Cusu3.elements
From (Select CUSU2.EMailaddress, CUSU2.Elements
From (Select CUSU.emailaddress, CUSU.elements, lowerElement=LAG(CUSU.ElementsCount,1,-1) OVER (partition by cusu.emailaddress order by CUSU.elements)
From (Select cus.emailaddress ,cus.elements ,ElementsCount = count(cus.elements)
From CUstomizes as Cus JOIN upgrades as U on cus.emailaddress=u.emailaddress 
where Cus.elements is not null
group by cus.emailaddress,cus.elements) as CUSU
)as CUSU2

where (CUSU2.lowerElement=-1)) as CUSU3





select *
from customizes







CREATE VIEW VIEW_POSTERMYWALLPrediction AS
SELECT C.EmailAddress,[FULL NAME]=(C.FirstName+' '+C.LastName),[Expiration Date PREMIUMS]= P.ExpirationDate,U.Price,U.PurchaseNumber,U.UpgradeDate,
po.posterID--count=count(cu.EmailAddress)
FROM PREMIUMS AS P JOIN  UPGRADES AS U ON P.EmailAddress=U.EmailAddress
JOIN CUSTOMERS AS C ON P.EmailAddress=C.EmailAddress
join POSTERS AS PO ON C.EmailAddress=PO.EmailAddress
join CUSTOMIZES AS CU ON PO.EmailAddress=CU.EmailAddress
--group by CU.EmailAddress,[FULL NAME],U.Price,U.PurchaseNumber,U.UpgradeDate,po.posterID

select *
from upgrades

DROP VIEW VIEW_POSTERMYWALLPrediction


CREATE VIEW VIEW_POSTERMYWALLPrediction AS
SELECT C.EmailAddress,[FULL NAME]=(C.FirstName+' '+C.LastName),[Expiration Date PREMIUMS]= P.ExpirationDate,U.Price,U.PurchaseNumber,U.UpgradeDate,
po.posterID
FROM PREMIUMS AS P JOIN  UPGRADES AS U ON P.EmailAddress=U.EmailAddress
JOIN CUSTOMERS AS C ON P.EmailAddress=C.EmailAddress
join POSTERS AS PO ON C.EmailAddress=PO.EmailAddress
join CUSTOMIZES AS CU ON PO.EmailAddress=CU.EmailAddress

CREATE VIEW view_customersAndPosters
Select ccc.EmailAddress, P.POSTERID, ccc.firstname, cus.lastname
 From Customers as cus JOIN (from  POSTERS as P join(Select EmailAddress
                                                     from CUSTOMERS
                                                     EXCEPT
                                                     Select EmailAddress
                         FROM PREMIUMS) as RegularClients ON P.EmailAddress=RegularClients.EMailAddress as ccc
						                                           on ccc.Emailaddress=cus.EmailAddress





----------------------WITH Part----------------------
select *
from customizes as c inner join upgrades as u on c.emailaddress=u.emailaddress join posters as p on p.emailaddress=c.emailaddress

