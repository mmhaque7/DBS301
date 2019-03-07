INSERT ALL
    INTO referral VALUES(100,100)
    INTO referral VALUES(101,102)
    INTO referral VALUES(102,101)
    INTO referral VALUES(103,100)
    INTO referral VALUES(104,100)
    INTO referral VALUES(105,101)
    INTO referral VALUES(106,102)
SELECT * FROM DUAL;

INSERT ALL 
INTO Clients VALUES(100,NULL,'Tracy','Nguyen',4164168008,'t.nguyen@grazi.com','buy',100)
INTO Clients VALUES(101,100,'Mehedi','Haque',6478889058,'m.haque@grazi.com','buy',30)
INTO Clients VALUES(102,NULL,'Salim','Arefi',9057878888,'arefi12@grazi.com','sell',100)
INTO Clients VALUES(103,101,'Nirav', 'Patel', 2897888585, 'patel.nirav@grazi.com', 'sell',60)
INTO Clients VALUES(104,102,'Jordan', 'Witley', 64575863632,'witly21@grazi.com','sell', 50)
INTO Clients VALUES(105,NULL,'Clint', 'McDonald', 647777525, 'macdonald.farm@grazi.com', 'buy', 80)
INTO Clients VALUES(106,103,'Marcus','Papen',2897854562,'mrpapen@grazi.com','sell',100)
INTO Clients VALUES(107,104,'Danny','Nguyen',4165858588,'dannyyy@grazi.com','buy',70)
INTO Clients VALUES(108,105,'Ilin' ,'Haque', 9058589632, 'satansoffspring@grazi.com','buy',40)
INTO Clients VALUES(109,106,'Masoumeh','Babaee',2895224466,'masoumeh212@grazi.com','buy',100)
SELECT * FROM DUAL;


ALTER TABLE  clients ADD CONSTRAINT referralid_clients_FK
FOREIGN KEY (referralid) REFERENCES referral(referralid)
;
ALTER TABLE clients DROP CONSTRAINT referralid_clients_FK;

ALTER TABLE  REFERRAL ADD CONSTRAINT clientid_REFERRAL_FK
FOREIGN KEY (clientid) REFERENCES clients(clientid)
;
ALTER TABLE  REFERRAL DROP CONSTRAINT clientid_REFERRAL_FK;


Insert all 
    INTO PropertyLocation VALUES(300, 'Canada', 'Ontario', 'H0H 0H0')
    INTO PropertyLocation VALUES(301, 'Canada', 'Manitoba', 'K8N 5W6')
    INTO PropertyLocation VALUES(302, 'Canada', 'Alberta', 'N7G R0T')
    INTO PropertyLocation VALUES(303, 'Canada', 'Ontario', 'B4R T0G')
    INTO PropertyLocation VALUES(304, 'Canada', 'Ontario', 'T9X S8P')
    INTO PropertyLocation VALUES(305, 'Canada', 'Ontario', 'P5E M0C')
    INTO PropertyLocation VALUES(306, 'Canada', 'Ontario', 'E4N P7M')
    INTO PropertyLocation VALUES(307, 'Canada', 'Alberta', 'B0N N1H')
    INTO PropertyLocation VALUES(308, 'Canada', 'Alberta', 'J8H K5R')
    INTO PropertyLocation VALUES(309, 'Canada', 'Alberta', 'L9Z E3R')
    SELECT 1 FROM dual;
    
INSERT ALL    
 INTO Property VALUES(1000,100,104,100,100,'House',4,3,1200,1600,0,'Garage',4,800000)
 INTO Property VALUES(1001,100,102,101,102,'House',7,5,2400,3000,0,'Garage',6,1200000)
 INTO Property VALUES(1002,101,103,102,101,'Town House',3,2,950,1200,350,'Outside',2,500000)
 INTO Property VALUES(1003,100,106,103,106,'House',4,2,1240,2000,0,'Garage',3,650000)
 INTO Property VALUES(1004,102,102,104,105,'House',6,4,2000,2500,0,'Garage',3,750000)
 INTO Property VALUES(1005,100,104,105,104,'Condo',3,2,900,0,1000,'Underground',1,450000)
 INTO Property VALUES(1006,103,106,106,106,'House',3,2,1200,1600,0,'Roadside',0,800000)
SELECT * FROM DUAL;
