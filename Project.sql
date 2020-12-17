CREATE TABLE CUSTOMER(
ID CHAR(8) PRIMARY KEY,
FirstName VARCHAR(15) NOT NULL,
MiddleName VARCHAR(15) NOT NULL,
LastName VARCHAR(15) NOT NULL,
Country VARCHAR(30) NOT NULL,
City VARCHAR(30) NOT NULL,
Building VARCHAR(15),
Street  VARCHAR(15),
DD  NUMBER(2) NOT NULL CHECK(DD>0 AND DD<=31),
MM  NUMBER(2) NOT NULL CHECK(MM>0 AND MM<=12),
YYYY  NUMBER(4) NOT NULL CHECK(YYYY>1900 AND YYYY<2003),
Accompanying_people_nbr INT NOT NULL CHECK(Accompanying_people_nbr>=0 AND  Accompanying_people_nbr<=30),
Stranger  NUMBER(1),
Butterfly  NUMBER(1),
TrueFriend  NUMBER(1),
Barnacle  NUMBER(1),
Ticket_Nb  CHAR(8),
SSCode  CHAR(8),
FOREIGN KEY(Ticket_Nb) REFERENCES TICKET (Ticket_Number),
FOREIGN KEY(SSCode) REFERENCES EMPLOYEE (NSSF));


CREATE TABLE EMPLOYEE (
NSSF CHAR(8),
Salary INT NOT NULL CHECK(Salary>0),
FirstName VARCHAR(8) NOT NULL,
MiddleName VARCHAR(8),
LastName VARCHAR(8) NOT NULL,
Country VARCHAR(8),
City VARCHAR(8),
Building VARCHAR(15),
Street VARCHAR(25),
DD INT,
MM INT,
YYYY INT,
Email VARCHAR(25) NOT NULL,
Phone_Number VARCHAR(15) NOT NULL,
Martial_Status CHAR(1),
Gender CHAR(1),
Super_NSSF CHAR(8),
Dep_Nbr CHAR(8),
PRIMARY KEY (NSSF),
FOREIGN KEY (Super_NSSF) REFERENCES EMPLOYEE(NSSF),
FOREIGN KEY (Dep_Nbr) REFERENCES DEPARTMENT(Department_nb) );


CREATE TABLE DEPARTMENT (
Department_nb CHAR(8) NOT NULL,
Name VARCHAR(30) NOT NULL,
Description  VARCHAR(200) NOT NULL,
Manager_NSSF CHAR(8),
Expense_ID CHAR(8),
PRIMARY KEY(Department_nb),
FOREIGN KEY(Manager_NSSF) REFERENCES EMPLOYEE (NSSF),
FOREIGN KEY(Expense_ID) REFERENCES EXPENSE (ID));



CREATE TABLE EXPENSE(
ID CHAR(8)  PRIMARY KEY,
Salary INT,
Partner_cost INT NOT NULL);


CREATE TABLE DESTINATION(
Id CHAR(8) PRIMARY KEY,
Issuance_nb CHAR(8),
Country VARCHAR(15) NOT NULL,
City VARCHAR(15) NOT NULL,
FOREIGN KEY (Issuance_nb) REFERENCES VISA (Issuance_Number));
￼


CREATE TABLE SITE(
Name VARCHAR(100)  PRIMARY KEY,
Address VARCHAR (30) NOT NULL,
City VARCHAR (20) NOT NULL,
world_rank NUMBER(3)  ,
Category VARCHAR(15),
Phone_nb VARCHAR(15),
description VARCHAR(200),
DID CHAR (8),
FOREIGN KEY (DID) REFERENCES DESTINATION (Id));



CREATE TABLE PACKAGE (
Trip_nb char(8),
Description VARCHAR(20) NOT NULL,
Cost INT NOT NULL,
Start_date DATE,
End_date DATE,
Dep_nbr CHAR(8),
PRIMARY KEY (Trip_nb),
FOREIGN KEY (Dep_nbr) REFERENCES DEPARTMENT(Department_nb) );


CREATE TABLE OFFER(
Coupon_Code CHAR(8),
Active_duration TIMESTAMP NOT NULL,
Description  VARCHAR(100) NOT NULL,
Required_pts INT,
LC_NB CHAR(8),
PRIMARY KEY(Coupon_Code),
FOREIGN KEY(LC_NB) REFERENCES LOYALTY_CARD (Loyalty_card_nb));


LOYALTY_CARD
CREATE TABLE LOYALTY_CARD(
Loyalty_card_nb CHAR(8) PRIMARY KEY,
money_spent INT,
Nb_of_previous_trips INT,
Loyalty_points INT);


CREATE TABLE ACCOMMODATION (
ID CHAR(8) PRIMARY KEY,
Dest_ID CHAR(8),
Res_ID CHAR(8),
Price NUMBER(6,2) NOT NULL,
Size VARCHAR (15) NOT NULL,
Building VARCHAR (15),
Street VARCHAR (15),
Apartment VARCHAR (15) NOT NULL,
Facility VARCHAR (15) NOT NULL,
Room_type VARCHAR (15) NOT NULL,
Meal_Plan VARCHAR (15),
FOREIGN KEY (Dest_ID) REFERENCES DESTINATION (Id),
FOREIGN KEY (Res_ID) REFERENCES RESERVATION (ID));


CREATE TABLE RESERVATION(
ID CHAR(8) PRIMARY KEY,
Reservation_Name VARCHAR(15),
Time TIMESTAMP NOT NULL,
Date_ DATE NOT NULL,
Location VARCHAR(15) NOT NULL,
Trip_Nbr CHAR(8),
Site_Name VARCHAR(100),
FOREIGN KEY (Trip_Nbr) REFERENCES PACKAGE(Trip_nb),
FOREIGN KEY (Site_Name) REFERENCES SITE(Name));



CREATE TABLE TICKET (
Ticket_Number CHAR(8),
Bill INT NOT NULL,
Airline_Name VARCHAR(20) NOT NULL,
Arrival_time TIMESTAMP NOT NULL,
Departure_time TIMESTAMP NOT NULL,
PRIMARY KEY (Ticket_Number));



CREATE TABLE SURVEY (
ID CHAR(8),
Rating  INT NOT NULL CHECK(Rating>=0 AND Rating<=5),
Feedback VARCHAR(100),
PRIMARY KEY(ID));


CREATE TABLE PARTNERSHIP(
Name VARCHAR(100) PRIMARY KEY,
Dep_ID CHAR(8),
Function VARCHAR(100) NOT NULL,
Bill FLOAT,
Contact_number VARCHAR(22) NOT NULL,
Service_validity DATE,
FOREIGN KEY(Dep_ID) REFERENCES DEPARTMENT (Department_nb));



CREATE TABLE VISA(
Issuance_Number CHAR(8) PRIMARY KEY,
Expiration_Date DATE NOT NULL,
Status VARCHAR(15) NOT NULL,
Embassy VARCHAR(15) NOT NULL,
Purpose VARCHAR(15) NOT NULL,
Nationality VARCHAR(15) NOT NULL);



CREATE TABLE CONTRACT(
Reference_Nb CHAR(8)  PRIMARY KEY,
Currency VARCHAR(20) NOT NULL,
Policy VARCHAR(20),
details VARCHAR(100),
Date_of_payment DATE,
Amount_paid NUMBER(6,2) NOT NULL CHECK(Amount_paid>0),
Payment_method VARCHAR(15) CHECK (Payment_method IN('CASH','LOAN','ACCOUNT','CREDIT CARD')),
CID CHAR(8),
FOREIGN KEY (CID) REFERENCES CUSTOMER (ID));


CREATE TABLE LOAN (
Loan_Nbr CHAR(8),
Cust_ID CHAR(8),
Interest_Rate INT NOT NULL,
Monthly_Payment INT NOT NULL,
PRIMARY KEY (Loan_Nbr,Cust_ID),
FOREIGN KEY(Cust_ID) REFERENCES CUSTOMER(ID));


CREATE TABLE TRIP_SCHEDULE(
Trip_Number CHAR(8) NOT NULL,
Trip_Name VARCHAR(30) NOT NULL,
Duration  INT NOT NULL,
PRIMARY KEY(Trip_Number,Trip_Name),
FOREIGN KEY (Trip_Number) REFERENCES PACKAGE (Trip_nb));


CREATE TABLE MEDICAL_RECORD(
MR_ID CHAR(8),
CID CHAR(8),
Blood_Type VARCHAR(3) NOT NULL,
PCR_Test NUMBER(1) NOT NULL,
Emergency_Number VARCHAR(15) NOT NULL,
PRIMARY KEY(MR_ID,CID),
FOREIGN KEY(CID) REFERENCES CUSTOMER(ID));


CREATE TABLE RELATED_PEEP(
PEEP_ID CHAR(2),
CID CHAR(8),
Email VARCHAR(30),
Phone_nb VARCHAR(15),
Relation VARCHAR(15) NOT NULL,
MM NUMBER(2) NOT NULL CHECK(MM>0 AND MM<=12),
YYYY NUMBER(4) NOT NULL CHECK(YYYY>1900 AND YYYY<2021),
DD NUMBER(2) NOT NULL CHECK(DD>0 AND DD<=31),
FirstName VARCHAR(15) NOT NULL,
MiddleName VARCHAR(15) NOT NULL,
LastName VARCHAR(15) NOT NULL,
Country VARCHAR(30),
City VARCHAR(30),
Building VARCHAR(15),
Street  CHAR(15),
PRIMARY KEY(PEEP_ID,CID)
FOREIGN KEY (CID) REFERENCES CUSTOMER (ID));


21.	HAS_A2
CREATE TABLE HAS_A2(
CUSTOMER_ID CHAR(8) PRIMARY KEY,
CARD_Nb CHAR(8) UNIQUE,
FirstName VARCHAR(15) NOT NULL,
MiddleName VARCHAR(15) NOT NULL,
LastName VARCHAR(15) NOT NULL,
Country VARCHAR(30) NOT NULL,
City VARCHAR(30) NOT NULL,
Building VARCHAR(15),
Street  VARCHAR(15),
DD NUMBER(2) NOT NULL CHECK(DD>0 AND DD<=31),
MM NUMBER(2) NOT NULL CHECK(MM>0 AND MM<=12),
YYYY NUMBER(4) NOT NULL CHECK(YYYY>0 AND YYYY<2020),
Accompanying_people_nbr INT NOT NULL CHECK(Accompanying_people_nbr>=0 AND  Accompanying_people_nbr<=30),
Stranger NUMBER(1),
Butterfly NUMBER(1),
TrueFriend NUMBER(1),
Barnacle NUMBER(1),
Nb_of_previous_trips INT,
Loyalty_point INT,
Money_spent INT,
FOREIGN KEY (CUSTOMER_ID) REFERENCES CUSTOMER(ID),
FOREIGN KEY (CARD_Nb) REFERENCES LOYALTY_CARD (Loyalty_card_nb));

22.	FILLS
CREATE TABLE FILLS(
Customer_ID CHAR(8) NOT NULL,
SID CHAR(8),
FirstName VARCHAR(15) NOT NULL,
MiddleName VARCHAR(15) NOT NULL,
LastName VARCHAR(15) NOT NULL,
Country VARCHAR(30) NOT NULL,
City VARCHAR(30) NOT NULL,
Building VARCHAR(15),
Street VARCHAR(15),
DD NUMBER(2) NOT NULL CHECK(DD>0 AND DD<=31),
MM NUMBER(2) NOT NULL CHECK(MM>0 AND MM<=12),
YYYY NUMBER(4) NOT NULL CHECK(YYYY>1900 AND YYYY<2003),
Accompanying_people_nbr INT NOT NULL CHECK(Accompanying_people_nbr>=0 AND  Accompanying_people_nbr<=30),
Stranger NUMBER(1) DEFAULT 0 CHECK(Stranger IN (1,0)),
Butterfly NUMBER(1) DEFAULT 0 CHECK(Butterfly IN (1,0)),
TrueFriend NUMBER(1) DEFAULT 0 CHECK(TrueFriend IN (1,0)),
Barnacle NUMBER(1) DEFAULT 0 CHECK(Barnacle IN (1,0)),
Rating INT NOT NULL CHECK(Rating>=0 AND Rating<=5),
Feedback VARCHAR(100),
PRIMARY KEY(Customer_ID),
FOREIGN KEY (SID) REFERENCES SURVEY (ID),
FOREIGN KEY (Customer_ID) REFERENCES CUSTOMER (ID));


HAS A5
CREATE TABLE HAS_A5(
Ticket_nb CHAR(8),
Peep_id CHAR(2),
CID CHAR(8),
Email VARCHAR(30),
Phone_nb VARCHAR(15),
Relation VARCHAR(15) NOT NULL,
YYYY NUMBER(4) NOT NULL CHECK(YYYY>1900 AND YYYY<2021),
MM NUMBER(2) NOT NULL CHECK(MM>0 AND MM<=12),
DD NUMBER(2) NOT NULL CHECK(DD>0 AND DD<=31),
FirstName VARCHAR(15) NOT NULL,
MiddleName VARCHAR(15) NOT NULL,
LastName VARCHAR(15) NOT NULL,
Country VARCHAR(30),
City VARCHAR(30),
Building VARCHAR(15),
Street VARCHAR(15),
Arrival_time TIMESTAMP NOT NULL,
Departure_time TIMESTAMP NOT NULL,
Airline_Name VARCHAR(20) NOT NULL,
Bill FLOAT NOT NULL,
PRIMARY KEY (Ticket_nb),
FOREIGN KEY (Peep_id,CID) REFERENCES RELATED_PEEP (PEEP_ID,CID),
FOREIGN KEY(Ticket_nb) REFERENCES TICKET(Ticket_Number),
CONSTRAINT composite_key_PC UNIQUE(Peep_id,CID));



BUYS
CREATE TABLE BUYS(
Customer_id CHAR(8),
Trip_nbr  CHAR(8),
PRIMARY KEY (Customer_id,Trip_nbr),
FOREIGN KEY (Customer_id) REFERENCES  CUSTOMER(ID),
FOREIGN KEY (Trip_nbr) REFERENCES  PACKAGE(Trip_nb));

RESERVES
CREATE TABLE RESERVES(
EmpNSSF CHAR(8),
ResID CHAR(8),
PRIMARY KEY(EmpNSSF,ResID),
FOREIGN KEY (EmpNSSF) REFERENCES EMPLOYEE (NSSF),
FOREIGN KEY (ResID) REFERENCES RESERVATION (ID));

CUST_EMAIL
CREATE TABLE CUST_EMAIL (
C_Email VARCHAR(40),
C_ID CHAR(8),
PRIMARY KEY (C_Email,C_ID),
FOREIGN KEY(C_ID) REFERENCES CUSTOMER(ID));

PHONE_NBR
CREATE TABLE PHONE_NBR(
C_Phone CHAR(15),
C_ID  CHAR(8),
PRIMARY KEY(C_Phone,C_ID),
FOREIGN KEY(C_ID) REFERENCES CUSTOMER(ID));


MR_MEDICINE
CREATE TABLE MR_MEDICINE(
MR_MEDICINE VARCHAR(20),
Med_Id CHAR(8),
Cust_Id CHAR(8),
PRIMARY KEY(MR_MEDICINE,Med_Id,Cust_Id),
FOREIGN KEY(Med_Id,Cust_Id) REFERENCES MEDICAL_RECORD(MR_ID,CID));


MED_ALLERGY
CREATE TABLE MED_ALLLERGY(
Mr_Allergy VARCHAR(20),
Med_Id CHAR(8),
Cust_Id CHAR(8),
PRIMARY KEY(Mr_Allergy,Med_Id,Cust_Id),
FOREIGN KEY(Med_Id,Cust_Id) REFERENCES MEDICAL_RECORD(MR_ID,CID));



MED_INJURY
CREATE TABLE MED_INJURY(
MR_Injury VARCHAR(20),
Med_Id CHAR(8),
Cust_Id CHAR(8),
PRIMARY KEY(MR_Injury,Med_Id,Cust_Id),
FOREIGN KEY(Med_Id,Cust_Id) REFERENCES MEDICAL_RECORD(MR_ID,CID));

MED_CHRONIC
CREATE TABLE MED_CHRONIC(
MR_Chronic VARCHAR(20),
Med_Id CHAR(8),
Cust_Id CHAR(8),
PRIMARY KEY(MR_Chronic,Med_Id,Cust_Id),
FOREIGN KEY(Med_Id,Cust_Id) REFERENCES MEDICAL_RECORD(MR_ID,CID));

TRIP_ACTIVITY
CREATE TABLE TRIP_ACTIVITY(
TS_Name VARCHAR(20),
TS_Activity VARCHAR(20),
TS_Number CHAR(8),
PRIMARY KEY(TS_Activity,TS_Name,TS_Number),
FOREIGN KEY(TS_Number,TS_Name) REFERENCES TRIP_SCHEDULE(Trip_Number,Trip_Name));


IX.	INSERTING DATA:
CUSTOMER
INSERT INTO CUSTOMER VALUES
(ID, FirstName, MiddleName, LastName, Country, City, Building, Street,DD, MM, YYYY, Stranger, Butterfly, TrueFriend, Barnacle, Ticket_Nb, SSCode);
INSERT INTO CUSTOMER VALUES ('20397649', 'Renee', 'Honywill', 'Bert', 'Malaysia', 'Kuching', 'Tower Bldg', '58', 21 ,01 ,2000,0,1, 0, 0, 0, '07691915', 'EMP-0006');
INSERT INTO CUSTOMER VALUES ('30675402', 'Clareta', 'Spare', 'Romney', 'Cuba', 'Remedios', 'Kamel Bldg', '2239', 30, 12, 1989,0,0, 1, 0, 0, '31831850', 'EMP-0014');
INSERT INTO CUSTOMER VALUES ('70864186', 'Carree', 'Stammler', 'Jeggo', 'Portugal', 'Monte Agudo', 'XYZ Bldg', '8', 04, 06, 1999,0, 1, 0, 0, 0, '83282911', 'EMP-0006');
INSERT INTO CUSTOMER VALUES ('81565234', 'Ikey', 'Popplewell', 'Lempenny', 'Chile', 'Talcahuano', 'Hanoi Tower', '3', 29, 08, 1993,0, 0, 1, 0, 0, '21615125', 'EMP-0005');
INSERT INTO CUSTOMER VALUES ('81919972', 'Devi', 'Grigoire', 'Duerden', 'United States', 'Lancaster', 'Lancaster bldg', '1', 19, 12, 2001,2,1, 0, 0, 0, '68962709', 'EMP-0014');
INSERT INTO CUSTOMER VALUES ('68464201', 'Catlee', 'Cotterell', 'Latham', 'Qatar', 'Madīnat ash Shamāl', 'Salman Bldg', '481', 12, 03, 1969,3,0, 0, 0, 1, '09314230', 'EMP-0014');
INSERT INTO CUSTOMER VALUES ('28034052', 'Tamarra', 'Scamal', 'Antrobus', 'Canada', 'Beloeil', 'Beloeil Bldg', '25', 15, 01, 2002,0, 0, 0, 0, 1, '42719959', 'EMP-0005');
INSERT INTO CUSTOMER VALUES ('20725761', 'Silvie', 'Hellcat', 'Peplow', 'Estonia', 'Tartu', 'EST BLDG04', '283', 07, 12, 1979,0, 0, 1, 0, 0, '49440922', 'EMP-0005');
INSERT INTO CUSTOMER VALUES ('73587399', 'Noelani', 'Coole', 'Jedrzaszkiewicz', 'Russia', 'Sobinka', 'Basel Bldg', '68', 19, 08, 1960,2,0, 1, 0, 0, '51667681', 'EMP-0006');
INSERT INTO CUSTOMER VALUES ('16951576', 'Del', 'Matfin', 'Sacco', 'Indonesia', 'Timurjaya', 'wkwk bldg', '54317', 08,12, 1993,3,1,0,0,0,'79668008','EMP-0014');
INSERT INTO CUSTOMER VALUES ('60484923', 'Nedda', 'Bewick', 'Pattini', 'Nigeria', 'Uba', 'Osas bldg', '933', 13, 02, 1989,0, 0, 0, 0, 1, '80109491', 'EMP-0014');
INSERT INTO CUSTOMER VALUES ('63276737', 'Biddie', 'McLaughlan', 'Caramuscia', 'Sweden', 'Umeå', 'Sky bldg', '11', 29, 04, 1970,0, 0, 1, 0, 0, '10372901', 'EMP-0006');



EMPLOYEE

INSERT INTO EMPLOYEE VALUES('EMP-0001', 2000, 'Lucy', 'Paula', 'Casey', 'Lebanon', 'Beirut', 'Sama Beirut','Ashrafieh',20,11,1986,'l.casey@fakhrtours.com','+961-72-865-549','M','F',NULL,'35547933');

INSERT INTO EMPLOYEE VALUES('EMP-0003',2700,'Dominik','Alan','Farrell','Lebanon','Beirut','Sama Beirut','Ashrafieh',01,10,1993,'d.farrell@fakhrtours.com','+961-71-025-550','M','M',NULL,'02945082');

INSERT INTO EMPLOYEE VALUES('EMP-0002', 2000, 'Jenna', 'Matilda', 'Mason', 'Lebanon', 'Beirut', 'Sama Beirut', 'Ashrafieh', 23, 01, 1990, 'j.mason@fakhrtours.com', '+961-70-333-615', 'M', 'F','EMP-0003','02945082');

INSERT INTO EMPLOYEE VALUES('EMP-0004', 1082, 'Alan', 'Jeffrey', 'Walter', 'Lebanon', 'Beirut', 'Sama Beirut', 'Ashrafieh', 23, 01, 1989, 'a.jeffrey@fakhrtours.com', '+961-81-202-112', 'M', 'M','EMP-0001','35547933');

INSERT INTO EMPLOYEE VALUES('EMP-0005', 1700, 'Harold', 'Mathew', 'Peterson', 'Lebanon', 'Beirut', 'Sama Beirut', 'Ashrafieh', 03, 04, 1995, 'h.peterson@fakhrtours.com', '+961-81-868-101', 'S', 'M',NULL,'79463026');

INSERT INTO EMPLOYEE VALUES('EMP-0006', 900, 'John', 'Victor', 'Brooks', 'Lebanon', 'Beirut', 'Sama Beirut', 'Ashrafieh', 20, 03, 1992, 'j.brooks@fakhrtours.com', '+961-03-214-365', 'S', 'M','EMP-0005','79463026');

INSERT INTO EMPLOYEE VALUES('EMP-0007', 1200, 'Andrea', 'Nelly', 'Tucker', 'Lebanon', 'Beirut', 'Sama Beirut', 'Ashrafieh', 22, 06, 1996, 'a.tucker@fakhrtours.com', '+961-01-221-607', 'S', 'F',NULL,'29178485');

INSERT INTO EMPLOYEE VALUES('EMP-0008', 3000, 'Christel', 'Olivia', 'Cook', 'France', 'Paris', 'Tour First','Place des Saisons',16,01,1993,'c.cook@fakhrtours.com','+33-203-789-555','M', 'F',NULL,'15469484');

INSERT INTO EMPLOYEE VALUES('EMP-0010', 2243, 'Frederik', 'Ivan', 'Taylor', 'Lebanon', 'Beirut', 'Sama Beirut','Ashrafieh', 08, 05, 1996, 'f.taylor@fakhrtours.com','+961-80-231-676', 'M', 'F','EMP-0007','29178485');

INSERT INTO EMPLOYEE VALUES('EMP-0009', 4000, 'Angelina', 'Carrie', 'Jackson', 'USA', 'New York', 'Empire State','Fifth Avenue',12, 08, 1992, 'a.jackson@fakhrtours.com','+1-413-634-3022', 'S', 'F','EMP-0011','30519143');

INSERT INTO EMPLOYEE VALUES('EMP-0011', 2943, 'Albert', 'Theodore', 'Gibson', 'USA', 'New York','NY Sequare','NY', 25, 12, 1998, 'a.gibson@fakhrtours.com', '+1-313-654-3022', 'S', 'M',NULL,'30519143');

INSERT INTO EMPLOYEE VALUES('EMP-0012', 850, 'Sean', 'Michael', 'Williams', 'Lebanon', 'Beirut', 'Sama Beirut','Ashrafieh', 14, 01, 1990, 's.williams@fakhrtours.com', '+961-090-783', 'M', 'M',NULL,'68534448');

INSERT INTO EMPLOYEE VALUES('EMP-0013', 1300, 'Kamil', 'Adham', 'Nassif', 'Lebanon', 'Beirut', 'Sama Beirut','Ashrafieh', 14, 01, 1990, 'a.nassif@fakhrtours.com','+961-03-314-506', 'M', 'M',NULL,'13096894');


DEPARTMENT
INSERT INTO DEPARTMENT VALUES('35547933','IT','Responsible for technical support','EMP-0001','7');
INSERT INTO DEPARTMENT VALUES('30519143','Finance','It manages company financial issues','EMP-0011','9');
INSERT INTO DEPARTMENT VALUES('02945082','Marketing','Responsible for marketing company’s travel packages', 'EMP-0003','5');
INSERT INTO DEPARTMENT VALUES('13096894','Package Design', 'It is the department which organize and design the travel packages', 'EMP-0013','2');
INSERT INTO DEPARTMENT VALUES('15469484','International Communication','Responsible for communicating with partners and reservation', 'EMP-0008','1');
INSERT INTO DEPARTMENT VALUES('79463026','Client Service','The department that is responsible for client services and communicating with them','EMP-0005','4');
INSERT INTO DEPARTMENT VALUES('29178485','Management', 'Responsible for managing documents and controlling departments', 'EMP-0007','3’);
INSERT INTO DEPARTMENT VALUES('68534448','Human Resource', 'HR responsible for hiring and firing employees as well as managing their problems', 'EMP-0012','8’);



EXPENSE
INSERT INTO EXPENSE VALUES('1',100000,497000);
INSERT INTO EXPENSE VALUES('2',230000,74000);
INSERT INTO EXPENSE VALUES('3',10000,33000);
INSERT INTO EXPENSE VALUES('4',66000,1000);
INSERT INTO EXPENSE VALUES('5',89500,76832);
INSERT INTO EXPENSE VALUES('7',21000,10000);
INSERT INTO EXPENSE VALUES('8',11000,10000);
INSERT INTO EXPENSE VALUES('9',53000,100000);

DESTINATION
INSERT INTO DESTINATION VALUES('DST-0001','10000000','France','Paris');
INSERT INTO DESTINATION VALUES('DST-0002','10000001','Switzerland','Bern');
INSERT INTO DESTINATION VALUES('DST-0003','10000002','France',Lyon);
INSERT INTO DESTINATION VALUES('DST-0004','10000003','Lebanon','Beirut');
INSERT INTO DESTINATION VALUES('DST-0005','10000004','France', 'Menton');
INSERT INTO DESTINATION VALUES('DST-0006','10000005','Japan','Tokyo');
INSERT INTO DESTINATION VALUES('DST-0007','10000006','United States','Washington D.C');
INSERT INTO DESTINATION VALUES('DST-0008','10000007','Australia','Sydney');
INSERT INTO DESTINATION VALUES('DST-0009','10000008','Canada','Ottawa');
INSERT INTO DESTINATION VALUES('DST-0010','10000009','China','Beijing');
INSERT INTO DESTINATION VALUES('DST-0011',NULL,'Germany','Berlin');

SITE
INSERT INTO SITE VALUES ('Rideau Canal','6906 Vernon Road','Ottawa', 925,'Ice skating', '+1-663-472-1943', 'A perfect place for Ice skating and boating, rated 325th worldwide, located in Vernon Road, Ottawa. For more info contact +1-663-472-1943.', 'DST-0009');
INSERT INTO SITE VALUES ('Mirazur', '2917 Westend Alley', 'Menton', 1, 'Restaurant', '+33-700-5555-55', 'Mirazur is no. 1 restaurant around world, located in 2917 Westend Alley, Menton. For more info contact +33-700-5555-55.','DST-0005');
INSERT INTO SITE VALUES ('Forbidden City', '499 Badeau Point', 'Beijing', 50, 'Palace', '+86-18-411-6322', 'Palace complex from 1420 with a museum, rated 50th worldwide, located in 499 Badeau Point, Beijing. For more info contact +86-18-411-6322.', 'DST-0010');
INSERT INTO SITE VALUES ('National Gallery Art', '97297 Lakeland Circle', 'Washington D.C', 100, 'Art gallery', '+1-865-912-1332', 'Famous art gallery in Washington, rated 100th worldwide, located in 97297 Lakeland Circle, Washington D.C. For more info contact (865) 6662836.', 'DST-0007');
INSERT INTO SITE VALUES ('Gurten', '77 Summerview Street', 'Bern', 232, 'Restaurant', '+41-319-703-333', 'Swiss Restaurant with very elegant view, rated 232th worldwide, located in 77 Summerview Street, Bern. For more info contact +41-319-703-333.', 'DST-0002');
INSERT INTO SITE VALUES ('Sunset Hotel', '260 1st Way', 'Paris', 112, 'Hotel', '+33-231-4343-51', ' Famous five stars hotel, located on calm street in Paris,For more info contact +33-231-4343-51.', 'DST-0001');
INSERT INTO SITE VALUES ('Tokyo SkyTree', '0 Derek Place', 'Tokyo', 300, 'Sky view', '+81-402-243-314', 'Japanese Tower, rated 300th worldwide, located in 0 Derek Place, Tokyo. For more info contact +81-402-243-314', 'DST-0006');
INSERT INTO SITE VALUES ('SurSock Museum', 'Ashrafieh', 'Beirut', 400, 'Art museum', '+961-01-202-001', 'Modern Art Museum in a 1912 villa, rated 400th worldwide, located in Ashrafieh,Beirut. For more info contact +961-01-202-001.', 'DST-0004');
INSERT INTO SITE VALUES ('Ancient Theatre of Fourvière', '0 Huxley Center', 'Lyon', 161, 'History','+33-47-243-311', 'Remains of roman theater, rated 161st worldwide, located in 0 Huxley Center, Lyon. For more info contact +33-47-243-311.', 'DST-0003');
INSERT INTO SITE VALUES ('Sydney Opera House', '6 Bartillon Way', 'Sydney', 20, 'Art Centre', '+61-998-90-8499', 'Australian iconic site and Performing Art Centre, rated 20th worldwide, located in 6 Bartillon Way, Canberra. For more info contact +61-998-90-8499.', 'DST-0008');
INSERT INTO SITE VALUES ('Four Season Hotel', 'Berlin street 9', 'Berlin',34, 'Hotel', ' +49-7141-956831', ' Famous five stars hotel, located on calm street in berlin,for more info contact +49-7141-956831.', 'DST-0011');


PACKAGE
INSERT INTO PACKAGE VALUES('PKNB0001', 'Adventure Tourism', 1759, DATE('2020-12-25'), DATE('2021-01-05'), '13096894');
INSERT INTO PACKAGE VALUES('PKNB0003', 'Medical Tourism', 1099,DATE('2021-02-06'),DATE('2021-02-27'),'13096894');
INSERT INTO PACKAGE VALUES('PKNB0002', 'Wildlife Tourism', 1259,DATE('2021-02-13'),DATE('2021-02-20'), '15469484');
INSERT INTO PACKAGE VALUES('PKNB0004', 'Pilgrimage Tourism', 2599, DATE('2020-12-20'),DATE('2021-01-20'), '30519143');
INSERT INTO PACKAGE VALUES('PKNB0005', 'Eco Tourism', 1099, DATE('2020-12-01'), DATE('2020-12-07'), '02945082');
INSERT INTO PACKAGE VALUES('PKNB0006', 'Cultural Tourism', 1259,DATE('2020-12-23'),DATE('2020-12-29'), '30519143');
INSERT INTO PACKAGE VALUES('PKNB0007', 'Cruise Tourism', 1099, DATE('2021-01-01'),DATE('2021-01-12'), '02945082');
INSERT INTO PACKAGE VALUES('PKNB0008', 'Wellness Tourism', 759, DATE('2021-03-01'),DATE('2021-03-06'), '15469484' );
INSERT INTO PACKAGE VALUES('PKNB0009', 'Family Tourism', 799, DATE('2020-06-20'),DATE('2020-07-01'), '29178485');
INSERT INTO PACKAGE VALUES('PKNB0010', 'Honeymoon Tourism', 2599, DATE('2020-08-20'),DATE('2020-09-15'), '29178485');
INSERT INTO PACKAGE VALUES('PKNB0011', 'Nature Adore', 1099, DATE('2021-01-23'),DATE('2021-01-28'), '13096894');
'
OFFER
INSERT INTO OFFER VALUES('80957684',7,'1000$ offer: 5 star hotel including flight from Lebanon to Malaysia','13319670');
INSERT INTO OFFER VALUES('99809635',TIMESTAMP('2020-06-11 18:00:00'),'1500$ offer: 5 star hotel including flight from Qatar to London',1500,'66461696');
INSERT INTO OFFER VALUES('05190712',TIMESTAMP('2020-12-01 13:01:01'),'600$ offer: 3 star hotel including flight from Egypt to Turkey',700,'08514744');
INSERT INTO OFFER VALUES('14321115',TIMESTAMP('2020-09-09 09:09:59'),'300$ offer: Bahamas perfect day cruise departs from Miami',500,'26766358');
INSERT INTO OFFER VALUES('00381135',TIMESTAMP('2020-10-11 12:00:00'),'350$ offer: Perfect day getaway cruise departs from Orlando',400,'84927676');
INSERT INTO OFFER VALUES('33467224',TIMESTAMP('2020-12-25 18:01:01'),'649$ offer: Bermuda cruise departs from Cape Liberty, New Jersey, onboard Freedom of the Seas',400,'54786416');
INSERT INTO OFFER VALUES('70858802',TIMESTAMP('2019-01-11 04:30:10'),'2000$ offer: 4 star hotel including flight from KSA to Spain',1390,'66997013');
INSERT INTO OFFER VALUES('99019698',TIMESTAMP('2018-03-05 01:00:12'),'2456$ offer: Apartment including flight from Jordan to Greece',2605,'86412122');
INSERT INTO OFFER VALUES('94509368',TIMESTAMP('2020-12-31 11:59:59'),'993$ offer: 5 star hotel including flight from Tunisia to Italy',400,'43394385');
INSERT INTO OFFER VALUES('17050286',TIMESTAMP('2020-02-17 01:48:10'),'818$ offer: Southern Caribbean Cruise departs from Cape Liberty onboard Anthem of the Seas',340,'55002229');

LOYALTY_CARD
INSERT INTO LOYALTY_CARD VALUES('13319670',3400,5,2500);
INSERT INTO LOYALTY_CARD VALUES('66461696',600,1,600);
INSERT INTO LOYALTY_CARD VALUES('08514744',6000,8,2500);
INSERT INTO LOYALTY_CARD VALUES('26766358',1000,2,90);
INSERT INTO LOYALTY_CARD VALUES('84927676',4999,3,3000);
INSERT INTO LOYALTY_CARD VALUES('54786416',10000,10,8000);
INSERT INTO LOYALTY_CARD VALUES('66997013',2666,3,2666);
INSERT INTO LOYALTY_CARD VALUES('86412122',799,1,799);
INSERT INTO LOYALTY_CARD VALUES('43394385',1099,2,301);
INSERT INTO LOYALTY_CARD VALUES('55002229',3055,4,1008);

ACCOMMODATION
INSERT INTO ACCOMMODATION VALUES('ACC-0001','DST-0004','RES-0011',809.56,'Large','The Edge','Berlin Street','50','Facility','Master Rooms','Breakfast');
INSERT INTO ACCOMMODATION VALUES('ACC-0002','DST-0004','RES-0011',512.35,'Small','The Edge','Berlin Street','20','Facility','Single Rooms','Lunch');
INSERT INTO ACCOMMODATION VALUES('ACC-0003','DST-0004','RES-0011',677,'Medium','The Edge','Berlin Street','30','Facility','Master Rooms','Dinner');
INSERT INTO ACCOMMODATION VALUES('ACC-0004','DST-0001','RES-0012',1009.50,'Large','La Cite','Paris Street','10','Facility','Master Rooms','All Meals');
INSERT INTO ACCOMMODATION VALUES('ACC-0005','DST-0007','RES-0005',509.99,'Large','High Towers','High Street','150','Facility','Master Rooms','Lunch');
INSERT INTO ACCOMMODATION VALUES('ACC-0006','DST-0001','RES-0012',709.50,'Small','La Cite','Paris Street','30','Facility','Master Rooms','Dinner');
INSERT INTO ACCOMMODATION VALUES('ACC-0007','DST-0006',NULL,599.9,'Large','Cozy bdg','Greenfields St.','130','Facility','Master Rooms','All day');
INSERT INTO ACCOMMODATION VALUES('ACC-0008','DST-0005',NULL,499.9,'Small','Starco','Leechwell St.','20','Facility','Master Rooms','Breakfast');
INSERT INTO ACCOMMODATION VALUES('ACC-0009','DST-0001','RES-0012',855,'Medium','La Cite','Paris Street','5','Facility','Master Rooms','Dinner');
INSERT INTO ACCOMMODATION VALUES('ACC-0010','DST-0007','RES-0005',450.56,'Small','High Towers','High Street','60','Facility','Master Rooms','All Lunch');

RESERVATION
insert into RESERVATION (id, Reservation_Name, Time, Date, gender, ip_address)
INSERT INTO RESERVATION VALUES ('RES-0001', 'Res04',TIMESTAMP('2020-12-27 10:00:00'),DATE('2020-11-15') , 'Ottowa', 'PKNB0001','Rideau Canal');
INSERT INTO RESERVATION VALUES ('RES-0002', 'Res06', TIMESTAMP('2020-09-01 17:00:00'),DATE('2020-05-23'), 'Menton', 'PKNB0010', 'Mirazur');
INSERT INTO RESERVATION VALUES ('RES-0003', 'Res01',TIMESTAMP('2020-12-25 09:00:00'),DATE('2020-06-02'), 'Beijing', 'PKNB0006', 'Forbidden City');
INSERT INTO RESERVATION VALUES ('RES-0004', 'Res03',TIMESTAMP('2020-06-24 12:00:00'),DATE('2020-01-10'), 'United States', 'PKNB0009', 'National Gallery Art');
INSERT INTO RESERVATION VALUES ('RES-0005', 'Res06',TIMESTAMP('2021-02-10 21:00:00'), DATE('2020-07-23'), 'United States', 'PKNB0003', NULL);
INSERT INTO RESERVATION VALUES ('RES-0006', 'Res05',TIMESTAMP('2021-03-05 21:00:00'),DATE('2020-11-16'), 'Switzerland', 'PKNB0008', 'Gurten');
INSERT INTO RESERVATION VALUES ('RES-0007', 'Res02',TIMESTAMP('2020-12-03 15:30:00'),DATE('2020-09-18'), 'Japan', 'PKNB0005', 'Tokyo SkyTree');
INSERT INTO RESERVATION VALUES ('RES-0008', 'Res03',TIMESTAMP('2020-06-23 22:45:00'),DATE('2020-01-23'), 'Lebanon', 'PKNB0009', 'SurSock Museum');
INSERT INTO RESERVATION VALUES ('RES-0009', 'Res04',TIMESTAMP('2020-12-27 17:25:00'),DATE('2020-05-15'), 'Lyon', 'PKNB0006', 'Ancient Theatre of Fourvière');
INSERT INTO RESERVATION VALUES ('RES-0010', 'Res06',TIMESTAMP('2021-01-07 18:15:00'),DATE('2020-09-23'), 'Sydney', 'PKNB0007', 'Sydney Opera House');
INSERT INTO RESERVATION VALUES ('RES-0011','Res07',TIMESTAMP('2021-01-23 03:30:00'),DATE('2020-09-28'), 'Berlin','PKNB0011','Four Season Hotel');
INSERT INTO RESERVATION VALUES ('RES-0012','Res08',TIMESTAMP('2020-12-20 11:00:00'),DATE('2020-09-28'), 'Paris','PKNB0004','Sunset Hotel');



TICKET
INSERT INTO TICKET VALUES('09314230', 1099,'Qatar',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'));
INSERT INTO TICKET VALUES('31831850', 899, 'Singapore Travel',TIMESTAMP('2020-06-1 06:00:00'), TIMESTAMP('2020-06-9 17:00:00'));
INSERT INTO TICKET VALUES('83282911', 599, 'Hainan',TIMESTAMP('2020-08-24 07:00:00'), TIMESTAMP('2020-09-02 16:00:00'));
INSERT INTO TICKET VALUES('21615125', 799,'China Airway' ,TIMESTAMP('2020-07-1 08:00:00' ), TIMESTAMP('2020-07-20 15:00:00'));
INSERT INTO TICKET VALUES('68962709', 699, 'Emirates',TIMESTAMP('2020-07-18 09:00:00'),TIMESTAMP('2020-07-29 14:00:00'));
INSERT INTO TICKET VALUES('07691915', 539, 'Ukraine Swift',TIMESTAMP('2020-10-2 08:00:00' ),TIMESTAMP('2020-10-20 13:00:00'));
INSERT INTO TICKET VALUES('42719959', 1599, 'Thai Sea Travel', TIMESTAMP('2020-08-08 07:00:00' ) ,TIMESTAMP('2020-09-01 12:00:00'));
INSERT INTO TICKET VALUES('49440922', 729, 'Lufthansa Waves',TIMESTAMP('2020-08-1 06:00:00'),TIMESTAMP('2020-08-12 11:00:00'));
INSERT INTO TICKET VALUES('51667681', 669, 'Amer Airwaves',TIMESTAMP('2020-08-17 22:00:00'),TIMESTAMP('2020-08-23 11:00:00'));
INSERT INTO TICKET VALUES('79668008', 529, 'EasyJet',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'));
INSERT INTO TICKET VALUES('10372901', 499, 'MEA',TIMESTAMP('2020-12-25 22:00:00'),TIMESTAMP('2021-01-02 11:00:00'));
INSERT INTO TICKET VALUES('80109491', 2990, 'Mid Water',TIMESTAMP('2020-12-10 21:00:00'),TIMESTAMP('2021-02-10 06:00:00'));
INSERT INTO TICKET VALUES('22109652', 1099,'Qatar',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'));
INSERT INTO TICKET VALUES('10946123', 1099,'Qatar',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'));
INSERT INTO TICKET VALUES('01066721', 1099,'Qatar',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'));
INSERT INTO TICKET VALUES('81301277', 699, 'Emirates',TIMESTAMP('2020-07-18 09:00:00'),TIMESTAMP('2020-07-29 14:00:00'));
INSERT INTO TICKET VALUES('10981443', 699, 'Emirates',TIMESTAMP('2020-07-18 09:00:00'),TIMESTAMP('2020-07-29 14:00:00'));
INSERT INTO TICKET VALUES('51667812', 669, 'Amer Airwaves',TIMESTAMP('2020-08-17 22:00:00'),TIMESTAMP('2020-08-23 11:00:00'));
INSERT INTO TICKET VALUES('51667813', 669, 'Amer Airwaves',TIMESTAMP('2020-08-17 22:00:00'),TIMESTAMP('2020-08-23 11:00:00'));
INSERT INTO TICKET VALUES('79668108', 529, 'EasyJet',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'));
INSERT INTO TICKET VALUES('79668133', 529, 'EasyJet',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'));
INSERT INTO TICKET VALUES('79668111', 529, 'EasyJet',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'));


SURVEY
INSERT INTO SURVEY VALUES('SUR-4123',4,'Amazing experience');
INSERT INTO SURVEY VALUES('SUR-1322',5,'Best part of the trip is making new memories and new friends');
INSERT INTO SURVEY VALUES('SUR-1455',3,'Enjoyed my time with friends but the hotel staff were rude');
INSERT INTO SURVEY VALUES('SUR-9088',5,'Learned a lot of interesting information from the museums we visited');
INSERT INTO SURVEY VALUES('SUR-1321',4, NULL);
INSERT INTO SURVEY VALUES('SUR-7623',2,'The food served at the hotel was not good at all');
INSERT INTO SURVEY VALUES('SUR-0010',5,'Had so much fun discovering different parts of the city');
INSERT INTO SURVEY VALUES('SUR-0111',5,NULL);
INSERT INTO SURVEY VALUES('SUR-3189',4,'All the activities we did were so entertaining');
INSERT INTO SURVEY VALUES('SUR-0108',3,'The trip was too short, we needed more time to explore the city');



PARTNERSHIP

INSERT INTO PARTNERSHIP VALUES('Mirazur','15469484','Restaurant',65000,'+33-700-5555-55','2022-11-22');
INSERT INTO PARTNERSHIP VALUES('Four Seasons','15469484','Hotel & Resort',1120000,'+49-7141-9568311','2023-01-01');
INSERT INTO PARTNERSHIP VALUES('Fidelty Assurance & Reinsurance Co.','30519143','Medical Insurance',780000,'+961-70084048','2022-05-23');
INSERT INTO PARTNERSHIP VALUES('Italy Luxury Car Hire','15469484','Hire all different types of cars',54000,'+39-345-710-704','2020-12-28');
INSERT INTO PARTNERSHIP VALUES('Mediterranean Sea Ships','15469484','Ship travel company',33000,'+961-01802888','2022-03-12');
INSERT INTO PARTNERSHIP VALUES('Middle East Airlines','15469484','Air travel company',233000,'+961-01-629-999','2024-05-01');
INSERT INTO PARTNERSHIP VALUES('Cedar Bank','30519143','Bank',NULL,'+961-01-333-038',NULL);
INSERT INTO PARTNERSHIP VALUES('Bright Case International Law Firm','29178485','Attorney company to deal with legal issues',3300000,'+33-180-2719-90','2026-01-01');
INSERT INTO PARTNERSHIP VALUES('Swiss Moving','15469484','Transportation company in switzerland',810000,'+41-44-4669-000','2021-09-12');
INSERT INTO PARTNERSHIP VALUES('Security Shell','35547933','Cyber security company',10000,'+41-44-4669-000','2021-09-12');
INSERT INTO PARTNERSHIP VALUES('Duck Marketing','02945082','A marketing partner',76400,'+44-44-4569-100','2024-01-12');
INSERT INTO PARTNERSHIP VALUES('Penguin Data Management','29178485','A Management company that provide database organizing',33000,'+1-323-464-3122','2022-12-22');


VISA
INSERT INTO VISA VALUES('10000000','2020-12-07','Accepted','French','Student','Lebanese');
INSERT INTO VISA VALUES('10000001','2021-10-05','InProcess','Switzerland','Work','French');
INSERT INTO VISA VALUES('10000002','2021-02-03','Rejected','French','Visit','Lebanese');
INSERT INTO VISA VALUES('10000003','2020-03-02','InProcess','Lebanon','Work','Japanese');
INSERT INTO VISA VALUES('10000004','2020-04-30','InProcess','French','Visit','Egyptian');
INSERT INTO VISA VALUES('10000005','2021-11-22','Accepted','Japan','Work','Switzerland');
INSERT INTO VISA VALUES('10000006','2021-11-11','Accepted','United States','Student','Korean');
INSERT INTO VISA VALUES('10000007','2020-10-17','Accepted','Australia','Visit','Chinese');
INSERT INTO VISA VALUES('10000008','2021-07-18','Accepted','Canada','Work','American');
INSERT INTO VISA VALUES('10000009','2020-09-01','Rejected','China','Visit','French');

CONTRACT

INSERT INTO CONTRACT VALUES ('25499730', 'Dollar', 'Policy3', 'Policy 3 for ACCOUNT payments',DATE('2020-06-30'), 699.99, 'ACCOUNT', '70864186');
INSERT INTO CONTRACT VALUES ('72178253', 'Dollar', 'Policy1', 'Policy 1 for CASH payments', DATE( '2020-04-02'), 1099.00, 'CASH', '81919972');
INSERT INTO CONTRACT VALUES ('74877009', 'Dollar', 'Policy2', ' Policy 2 for LOAN payments ',DATE( '2020-05-21'), 1200.00, 'LOAN', '68464201');
INSERT INTO CONTRACT VALUES ('84515017', 'Dollar', 'Policy4', 'Policy 4 for CREDIT CARD payments', DATE( '2020-05-12'), 999.99, 'CREDIT CARD', '81565234');
INSERT INTO CONTRACT VALUES ('32791014', 'Canadian Dollar', 'Policy2', ' Policy 2 for LOAN payments ', DATE( '2020-05-12'), 3199.99, 'LOAN', '28034052');
INSERT INTO CONTRACT VALUES ( '30597114', 'EURO', 'Policy2', 'Policy 2 for LOAN payments',DATE( '2020-03-19'), 1799.00, 'LOAN', '73587399');
INSERT INTO CONTRACT VALUES ('04183109', 'EURO', 'Policy1', 'Policy 1 for CASH payments',DATE( '2020-11-11'), 694.99, 'CASH', '63276737');
INSERT INTO CONTRACT VALUES ('01600438', 'Dollar', 'Policy4', 'Policy 4 for CREDIT CARD payments',DATE( '2020-01-10'), 1099.00, 'CREDIT CARD', '30675402');
INSERT INTO CONTRACT VALUES ('27962343', 'Dollar', 'Policy2', 'Policy 2 for LOAN payments',DATE( '2020-04-17'), 899.99, 'LOAN', '20397649');
INSERT INTO CONTRACT VALUES ('38584341', 'Dollar', 'Policy1', 'Policy 1 for CASH payments', DATE( '2020-02-03'), 799.99, 'CASH', '16951576');
11.


LOAN

INSERT INTO LOAN VALUES('LOAN7456','20397649' , 2 , 317);
INSERT INTO LOAN VALUES('LOAN5322', '73587399' , 2 , 260);
INSERT INTO LOAN VALUES('LOAN8643', '28034052' , 2 , 330);
INSERT INTO LOAN VALUES('LOAN6373', '68464201' , 2 , 224);


TRIP_SCHEDULE
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0001', 'Adventurous Trip', 12);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0002', 'Wildlife Trip', 8);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0003', 'Medical Trip', 21);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0004', 'Pilgrimage Trip', 32);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0005', 'Eco Trip', 7);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0006', 'Cultural Trip', 6);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0007', 'Cruise Trip', 43);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0008', 'Wellness Trip', 6);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0009', 'Family Trip', 12);
INSERT INTO TRIP_SCHEDULE VALUES('PKNB0010', 'Honeymoon Trip', 27);


MEDICAL_RECORD
INSERT INTO MEDICAL_RECORD VALUES('MR-00001','16951576','A+',0,'+60-79-784-1123');
INSERT INTO MEDICAL_RECORD VALUES('MR-00002','20397649','B+',1,'+46-99-467-0192');
INSERT INTO MEDICAL_RECORD VALUES('MR-00003','20725761','A+',1,'+37-68-656-3312');
INSERT INTO MEDICAL_RECORD VALUES('MR-00004','28034052','O+',1,'+1-704-467-0192');
INSERT INTO MEDICAL_RECORD VALUES('MR-00005','30675402','A+',1,'+53-10-616-8112');
INSERT INTO MEDICAL_RECORD VALUES('MR-00006','60484923','AB+',0,'+50-863-333-11');
INSERT INTO MEDICAL_RECORD VALUES('MR-00007','68464201','AB-',1,'+56-79-195-1485');
INSERT INTO MEDICAL_RECORD VALUES('MR-00008','70864186','A-',0,'+3-701-091-6868');
INSERT INTO MEDICAL_RECORD VALUES('MR-00009','73587399','B+',0,'+4-791-14-11024');
INSERT INTO MEDICAL_RECORD VALUES('MR-00010','81919972','B-',0,'+1-605-6436-187');
RELATED_PEEP
INSERT INTO RELATED_PEEP VALUES('03','16951576','Ebra@gmail.com',NULL,'Mother',10,2004,23,'Ebra','Main','Bert','Indonesia','Timurjaya','wkwk bldg.','54317');
INSERT INTO RELATED_PEEP VALUES('02','16951576','Rose@gmail.com',NULL,'Mother',11,2008,15,'Rose','Main','Bert','Indonesia','Timurjaya','wkwk bldg.','54317');
INSERT INTO RELATED_PEEP VALUES('01','16951576','James@gmail.com','+60-79-784-1123','Sister',05,1995,25,'James','Matfin','Sacco','Indonesia','Monte Agudo','XYZ Bldg','8');
INSERT INTO RELATED_PEEP VALUES('03','68464201','Bady@gmail.com','+974-70-859-021','Father',01,1991,02,'Bady','Mhelo','Latham','Qatar','Madīnat ash Shamāl','Salman Bldg','481');
INSERT INTO RELATED_PEEP VALUES('01','68464201','Jameele@gmail.com','+974-70-051-681','Grandmother',06,1980,12,'Jameele','Mella','Jedra','Qatar','Madīnat ash Shamāl','Salman Bldg','481');
INSERT INTO RELATED_PEEP VALUES('02','68464201','Charles@gmail.com','+56-79-195-1485','Brother',04,1975,07,'Charles','Mhelo','Latham','Qatar','Madīnat ash Shamāl','Bright Tower','13');
INSERT INTO RELATED_PEEP VALUES('01','73587399','Mike@gmail.com','+4-791-14-11024','Brother',01,1965,12,'Mike','Coole','Jedrzaszkiewicz','Russia','Red','RD bldg.','1');
INSERT INTO RELATED_PEEP VALUES('02','73587399','Alfred@gmail.com','+4-712-5425-124','Brother',12,1970,30,'Alfred','Coole','Jedrzaszkiewicz',NULL,NULL,NULL,NULL);
INSERT INTO RELATED_PEEP VALUES('02','81919972','Lea@gmail.com','+1-309-5458-125','Friend',12,2000,21,'Lea','Hellcat','Pepeq','United States','NY','EST BLDG04','283');
INSERT INTO RELATED_PEEP VALUES('01','81919972','Jackline@gmail.com','+1-605-6436-187','Friend',07,2001,01,'Jackline','Main','Sercose','United States','NY','wkwk Bldg','54317');

HAS_A2

INSERT INTO HAS_A2 VALUES ('20397649', '26766358', 'Renee', 'Honywill', 'Bert', 'Malaysia', 'Kuching', 'Tower Bldg', '58', 21 ,01 ,2000,0, 1, 0, 0, 0, 2,90,1000 );
INSERT INTO HAS_A2 VALUES ('16951576', '54786416', 'Del', 'Matfin', 'Sacco', 'Indonesia', 'Timurjaya', 'wkwk bldg', '54317',08,12, 1993,3, 0, 0, 1, 0, 1,8000,10000);
INSERT INTO HAS_A2 VALUES ('30675402', '43394385', 'Clareta', 'Spare', 'Romney', 'Cuba', 'Remedios', 'Kamel Bldg', '2239', 30, 12, 1989,0, 0, 1, 0, 0, 2,301,1099);
INSERT INTO HAS_A2 VALUES ('70864186', '66461696', 'Carree', 'Stammler', 'Jeggo', 'Portugal', 'Monte Agudo', 'XYZ Bldg', '8', 04, 06, 1999,0, 1, 0, 0, 0, 1,600,600);
INSERT INTO HAS_A2 VALUES ('81565234', '66997013', 'Ikey', 'Popplewell', 'Lempenny', 'Chile', 'Talcahuano', 'Hanoi Tower', '3', 29, 08, 1993,0, 0, 1, 0, 0, 2,2666,2666);
INSERT INTO HAS_A2 VALUES ('81919972','86412122', 'Devi', 'Grigoire', 'Duerden', 'United States', 'Lancaster', 'Lancaster Bldg', '1', 19, 12, 2001,2, 1, 0, 0, 0, 1,799,799);
INSERT INTO HAS_A2 VALUES ('68464201', '84927676', 'Catlee', 'Cotterell', 'Latham', 'Qatar', 'Madīnat ash Shamāl', 'Salman Bldg', '481', 12, 03, 1969,3, 0, 0, 0, 1, 3,3000,4999);
INSERT INTO HAS_A2 VALUES ('28034052', '08514744', 'Tamarra', 'Scamal', 'Antrobus', 'Canada', 'Beloeil', 'Beloeil Bldg', '25', 15, 01, 2002,0, 0, 0, 0, 1, 8,2500,6000);
INSERT INTO HAS_A2 VALUES ('20725761', '55002229', 'Silvie', 'Hellcat', 'Peplow', 'Estonia', 'Tartu', 'EST BLDG04', '283', 07, 12, 1979,0, 0, 1, 0, 0, 4,1008,3055);
INSERT INTO HAS_A2 VALUES ('73587399', '13319670', 'Noelani', 'Coole', 'Jedrzaszkiewicz', 'Russia', 'Sobinka', 'Basel Bldg', '68', 19, 08, 1986,2, 0, 0, 1, 0, 5,2500,3400);


FILLS
INSERT INTO FILLS VALUES ('20397649','SUR-4123', 'Renee', 'Honywill', 'Bert', 'Malaysia', 'Kuching', 'Tower Bldg', '58', 21 ,01 ,2000,0, 1, 0, 0, 0, 4,'Amazing experience');
INSERT INTO FILLS  VALUES ('30675402','SUR-1322', 'Clareta', 'Spare', 'Romney', 'Cuba', 'Remedios', 'Kamel Bldg', '2239', 30, 12, 1989,0,0, 1, 0, 0, 5,'Best part of the trip is making new memories and new friends');
INSERT INTO FILLS  VALUES ('70864186','SUR-9088','Carree', 'Stammler', 'Jeggo', 'Portugal', 'Monte Agudo', 'XYZ Bldg', '8', 04, 06, 1999,0, 1, 0, 0, 0,5,'Learned a lot of interesting information from the museums we visited');
INSERT INTO FILLS  VALUES ('81565234','SUR-1321', 'Ikey', 'Popplewell', 'Lempenny', 'Chile', 'Talcahuano', 'Hanoi Tower', '3', 29, 08, 1993,0, 0, 1, 0, 0, 4,NULL);
INSERT INTO FILLS  VALUES ('81919972','SUR-1455', 'Devi', 'Grigoire', 'Duerden', 'United States', 'Lancaster', 'Lancaster bldg', '1', 19, 12, 2001,2, 1, 0, 0, 0, 3,'Enjoyed my time with friends but the hotel staff were rude');
INSERT INTO FILLS  VALUES ('68464201','SUR-0010', 'Catlee', 'Cotterell', 'Latham', 'Qatar', 'Madīnat ash Shamāl', 'Salman Bldg', '481', 12, 03, 1969,3, 0, 0, 0, 1, 5,'Had so much fun discovering different parts of the city');
INSERT INTO FILLS  VALUES ('28034052','SUR-3189', 'Tamarra', 'Scamal', 'Antrobus', 'Canada', 'Beloeil', 'Beloeil Bldg', '25', 15, 01, 2002,0, 0, 0, 0, 1,4,'All the activities we did were so entertaining' );
INSERT INTO FILLS  VALUES ('20725761','SUR-0111', 'Silvie', 'Hellcat', 'Peplow', 'Estonia', 'Tartu', 'EST BLDG04', '283', 07, 12, 1979,0, 0, 1, 0, 0, 5, NULL);
INSERT INTO FILLS  VALUES ('60484923','SUR-0108', 'Nedda', 'Bewick', 'Pattini', 'Nigeria', 'Uba', 'Osas bldg', '933', 13, 02, 1989,0, 0, 0, 0, 1,3,'The trip was too short, we needed more time to explore the city');
INSERT INTO FILLS  VALUES ('63276737','SUR-7623', 'Biddie', 'McLaughlan', 'Caramuscia', 'Sweden', 'Umeå', 'Sky bldg', '11', 29, 04, 1970,0, 0, 1, 0, 0, 2,'The food served at the hotel was not good at all');


HAS A5
INSERT INTO HAS_A5 VALUES('22109652','01','68464201','Jameele@gmail.com','+974-70-051-681','Grandmother',1980,06,12,'Jameele','Mella','Jedra','Qatar','Madīnat ash Shamāl','Salman Bldg','481',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'),'Qatar',1099 );
INSERT INTO HAS_A5 VALUES('10946123','02','68464201','Charles@gmail.com','+56-79-195-1485','Brother',1975,04,07,'Charles','Mhelo','Latham','Qatar','Madīnat ash Shamāl','Bright Tower','13',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'),'Qatar',1099);
INSERT INTO HAS_A5 VALUES('01066721','03','68464201','Bady@gmail.com','+974-70-859-021','Father',1991,01,02,'Bady','Mhelo','Latham','Qatar','Madīnat ash Shamāl','Salman Bldg','481',TIMESTAMP('2020-06-11  05:00:00' ), TIMESTAMP('2020-06-23 18:00:00'),'Qatar',1099 );
INSERT INTO HAS_A5 VALUES('81301277','02','81919972','Lea@gmail.com','+1-309-5458-125','Friend',2000,12,21,'Lea','Hellcat','Pepeq','United States','NY','EST BLDG04','283',TIMESTAMP('2020-07-18 09:00:00'),TIMESTAMP('2020-07-29 14:00:00'),'Emirates',699 );
INSERT INTO HAS_A5 VALUES('10981443','01','81919972','Jackline@gmail.com','+1-605-6436-187','Friend',2001,07,01,'Jackline','Main','Sercose','United States','NY','wkwk Bldg','54317',TIMESTAMP('2020-07-18 09:00:00'),TIMESTAMP('2020-07-29 14:00:00'),'Emirates',699 );
INSERT INTO HAS_A5 VALUES('51667812','01','73587399','Mike@gmail.com','+4-791-14-11024','Brother',1965,01,12,'Mike','Coole','Jedrzaszkiewicz','Russia','Red','RD bldg.','1',TIMESTAMP('2020-08-17 22:00:00'),TIMESTAMP('2020-08-23 11:00:00'),'Amer Airwaves',669 );
INSERT INTO HAS_A5 VALUES('51667813','02','73587399','Alfred@gmail.com','+4-712-5425-124','Brother',1970,12,30,'Alfred','Coole','Jedrzaszkiewicz',NULL,NULL,NULL,NULL,TIMESTAMP('2020-08-17 22:00:00'),TIMESTAMP('2020-08-23 11:00:00'),'Amer Airwaves',669 );
INSERT INTO HAS_A5 VALUES('79668108','01','16951576','James@gmail.com','+60-79-784-1123','Sister',1995,05,25,'James','Matfin','Sacco','Indonesia','Monte Agudo','XYZ Bldg','8',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'),'EasyJet',529 );
INSERT INTO HAS_A5 VALUES('79668133','02','16951576','Rose@gmail.com',NULL,'Mother',2008,11,15,'Rose','Main','Bert','Indonesia','Timurjaya','wkwk bldg.','54317',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'),'EasyJet',529  );
INSERT INTO HAS_A5 VALUES('79668111','03','16951576','Ebra@gmail.com',NULL,'Mother',2004,10,23,'Ebra','Main','Bert','Indonesia','Timurjaya','wkwk bldg.','54317',TIMESTAMP('2020-08-2 21:00:00'),TIMESTAMP('2020-08-06 06:00:00'),'EasyJet',529 );


BUYS
INSERT INTO BUYS VALUES('16951576','PKNB0010');
INSERT INTO BUYS VALUES('20397649','PKNB0007');
INSERT INTO BUYS VALUES('20725761','PKNB0006');
INSERT INTO BUYS VALUES('28034052','PKNB0004');
INSERT INTO BUYS VALUES('30675402','PKNB0005');
INSERT INTO BUYS VALUES('60484923','PKNB0008');
INSERT INTO BUYS VALUES('63276737','PKNB0008');
INSERT INTO BUYS VALUES('68464201','PKNB0001');
INSERT INTO BUYS VALUES('70864186','PKNB0009');
INSERT INTO BUYS VALUES('73587399','PKNB0002');
INSERT INTO BUYS VALUES('81565234','PKNB0003');
INSERT INTO BUYS VALUES('81919972','PKNB0011');

RESERVES
INSERT INTO RESERVES VALUES ('EMP-0008','RES-0001');
INSERT INTO RESERVES VALUES ('EMP-0008','RES-0002');
INSERT INTO RESERVES VALUES ('EMP-0008','RES-0003');
INSERT INTO RESERVES VALUES ('EMP-0007','RES-0004');
INSERT INTO RESERVES VALUES ('EMP-0007','RES-0005');
INSERT INTO RESERVES VALUES ('EMP-0010','RES-0006');
INSERT INTO RESERVES VALUES ('EMP-0010','RES-0007');
INSERT INTO RESERVES VALUES ('EMP-0013','RES-0008');
INSERT INTO RESERVES VALUES ('EMP-0013','RES-0009');
INSERT INTO RESERVES VALUES ('EMP-0007','RES-0010');
INSERT INTO RESERVES VALUES ('EMP-0008','RES-0011');
INSERT INTO RESERVES VALUES ('EMP-0008','RES-0012');
CUST_EMAIL
INSERT INTO CUST_EMAIL VALUES ('renee.bert@hotmail.com','20397649');
INSERT INTO CUST_EMAIL VALUES ('renee_H.bert@gmail.com','20397649');
INSERT INTO CUST_EMAIL VALUES ('clareta.spare@outlook.com', '30675402');
INSERT INTO CUST_EMAIL VALUES ('carree.jeggo@gmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('carree@gmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('ikey.lempenny@hotmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('devi.duerden@hotmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('catlee.letham@gmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('tamarra.antrobus@hotmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('selvie.peplow@hotmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('noelani.jedrzaszkiewicz@gmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('del.sacco@hotmail.com', '20397649');
INSERT INTO CUST_EMAIL VALUES ('delsacco0o0@gmail.com', '20397649');


PHONE_NBR
INSERT INTO PHONE_NBR VALUES ('+60-70-712-2334','20397649');
INSERT INTO PHONE_NBR VALUES ('+60-72-809-1004','20397649');
INSERT INTO PHONE_NBR VALUES ('+53-766-4652-21','30675402');
INSERT INTO PHONE_NBR VALUES ('+3-510-321-5568','70864186');
INSERT INTO PHONE_NBR VALUES ('+56-01-454-1588','81565234');
INSERT INTO PHONE_NBR VALUES ('+56-11-201-1108','81565234');
INSERT INTO PHONE_NBR VALUES ('+1-7058-963-112','81919972');
INSERT INTO PHONE_NBR VALUES ('+9-74-0333-3222','68464201');
INSERT INTO PHONE_NBR VALUES ('+9-73-0813-1029','68464201');
INSERT INTO PHONE_NBR VALUES ('+1-726-9231-015','28034052');
INSERT INTO PHONE_NBR VALUES ('+37-270-7755-11','20725761');
INSERT INTO PHONE_NBR VALUES ('+4-102-3698-574','73587399');
INSERT INTO PHONE_NBR VALUES ('+4-914-3138-373','73587399');
INSERT INTO PHONE_NBR VALUES ('+6-202-1115-193','16951576');
INSERT INTO PHONE_NBR VALUES ('+50-701-425-36','60484923');
INSERT INTO PHONE_NBR VALUES ('+41-67-6824-931','63276737');


MR_MEDICINE
INSERT INTO MR_MEDICINE VALUES('No medicine','MR-00001','16951576');
INSERT INTO MR_MEDICINE VALUES('Anticoagulants','MR-00002','20397649');
INSERT INTO MR_MEDICINE VALUES('Diuretics','MR-00003','20725761');
INSERT INTO MR_MEDICINE VALUES('Pain Killers,'MR-00004','28034052');
INSERT INTO MR_MEDICINE VALUES('Glucophage','MR-00005','30675402');
INSERT INTO MR_MEDICINE VALUES('entecavir','MR-00006','60484923');
INSERT INTO MR_MEDICINE VALUES('Metformin','MR-00006','60484923');
INSERT INTO MR_MEDICINE VALUES('No medicine','MR-00007','68464201');
INSERT INTO MR_MEDICINE VALUES('No medicine','MR-00008','70864186');
INSERT INTO MR_MEDICINE VALUES('Triptans','MR-00009','73587399');
INSERT INTO MR_MEDICINE VALUES('Glumetza','MR-00009','73587399');
INSERT INTO MR_MEDICINE VALUES('Angiotensin','MR-00010','81919972');
MED_ALLERGY
INSERT INTO MED_ALLERGY VALUES('No Allergies','MR-00001','16951576');
INSERT INTO MED_ALLERGY VALUES('Peanuts','MR-00002','20397649');
INSERT INTO MED_ALLERGY VALUES('Eggs','MR-00003','20725761');
INSERT INTO MED_ALLERGY VALUES('No Allergies','MR-00004','28034052');
INSERT INTO MED_ALLERGY VALUES('Milk','MR-00005','30675402');
INSERT INTO MED_ALLERGY VALUES('Pollen','MR-00006','60484923');
INSERT INTO MED_ALLERGY VALUES('Milk','MR-00006','60484923');
INSERT INTO MED_ALLERGY VALUES('No Allergies','MR-00007','68464201');
INSERT INTO MED_ALLERGY VALUES('No Allergies','MR-00008','70864186');
INSERT INTO MED_ALLERGY VALUES('Wheat','MR-00009','73587399');
INSERT INTO MED_ALLERGY VALUES('Peanuts','MR-00009','73587399');
INSERT INTO MED_ALLERGY VALUES('No Allergies','MR-00010','81919972');

MED_INJURY
INSERT INTO MED_INJURY VALUES('Sprain','MR-00001','16951576');
INSERT INTO MED_INJURY VALUES('Broken Bone','MR-00001','16951576');
INSERT INTO MED_INJURY VALUES('Burns','MR-00002','20397649');
INSERT INTO MED_INJURY VALUES('Sprain','MR-00002','20397649');
INSERT INTO MED_INJURY VALUES('No Injury','MR-00003','20725761');
INSERT INTO MED_INJURY VALUES('No Injury','MR-00004','28034052');
INSERT INTO MED_INJURY VALUES('No Injury','MR-00005','30675402');
INSERT INTO MED_INJURY VALUES('Sprain','MR-00006','60484923');
INSERT INTO MED_INJURY VALUES('No injury','MR-00007','68464201');
INSERT INTO MED_INJURY VALUES('Joint Dislocation','MR-00008','70864186');
INSERT INTO MED_INJURY VALUES('No Injury','MR-00009','73587399');
INSERT INTO MED_INJURY VALUES('No Injury','MR-00010','81919972');
MED_CHRONIC

INSERT INTO MED_CHRONIC VALUES ('NONE','MR-00001','16951576');
INSERT INTO MED_CHRONIC VALUES ('Arthritis','MR-00004','28034052');
INSERT INTO MED_CHRONIC VALUES ('Diabetes','MR-00005','30675402');
INSERT INTO MED_CHRONIC VALUES ('Diabetes','MR-00009','73587399');
INSERT INTO MED_CHRONIC VALUES ('Hepatitis','MR-00006','60484923');
INSERT INTO MED_CHRONIC VALUES ('Diabetes','MR-00006','60484923');
INSERT INTO MED_CHRONIC VALUES ('Migraine','MR-00009','73587399');
INSERT INTO MED_CHRONIC VALUES ('NONE','MR-00007','68464201');
INSERT INTO MED_CHRONIC VALUES ('High Blood Pressure','MR-00003','20725761');
INSERT INTO MED_CHRONIC VALUES ('Heart Disease','MR-00002','20397649');
INSERT INTO MED_CHRONIC VALUES ('NONE','MR-00008','70864186');
INSERT INTO MED_CHRONIC VALUES ('Blood Pressure','MR-00010','81919972');

TRIP_ACTIVITY
INSERT INTO TRIP_ACTIVITY VALUES('Hiking','Adventurous Trip','PKNB0001');
INSERT INTO TRIP_ACTIVITY VALUES('Camping','Adventurous Trip','PKNB0001');
INSERT INTO TRIP_ACTIVITY VALUES('Biking','Adventurous Trip','PKNB0001');
INSERT INTO TRIP_ACTIVITY VALUES('Safari Tour','Wildlife Trip','PKNB0002');
INSERT INTO TRIP_ACTIVITY VALUES('Hunting','Wildlife Trip','PKNB0002');
INSERT INTO TRIP_ACTIVITY VALUES('Conference','Medical Trip','PKNB0003');
INSERT INTO TRIP_ACTIVITY VALUES('Visiting a temple','Pilgrimage Trip','PKNB0004');
INSERT INTO TRIP_ACTIVITY VALUES('Fishing','Eco Trip','PKNB0005');
INSERT INTO TRIP_ACTIVITY VALUES('Kayaking tour','Eco Trip','PKNB0005');
INSERT INTO TRIP_ACTIVITY VALUES('Museums','Cultural Trip','PKNB0006');
INSERT INTO TRIP_ACTIVITY VALUES('Festival','Cultural Trip','PKNB0006');
INSERT INTO RIP_ACTIVITY VALUES('Pool','Cruise Trip','PKNB0007');
INSERT INTO TRIP_ACTIVITY VALUES('Sea','Cruise Trip','PKNB0007');
INSERT INTO TRIP_ACTIVITY VALUES('Nature Act','Wellness Trip','PKNB0008');
INSERT INTO TRIP_ACTIVITY VALUES('Zoo','Family Trip','PKNB0009');
INSERT INTO TRIP_ACTIVITY VALUES('Hot Air Balloon','Family Trip','PKNB0009');
INSERT INTO TRIP_ACTIVITY VALUES('Party', 'Honeymoon Trip','PKNB0010');
