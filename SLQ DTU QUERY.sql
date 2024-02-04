
 --------------------------------------------------------------------MEGHA GOSWAMI---------------------------------------------------------------------------

 SELECT DISTINCT FNAME_CUS FROM TBL_CUSTOMER;

 SELECT *
FROM TBL_CUSTOMER
WHERE (FNAME_CUS = 'John' AND LNAME_CUS = 'Doe')
   OR (DOB_CUS >= '1990-01-01' AND DOB_CUS < '2000-01-01');

SELECT *
FROM TBL_CUSTOMER
WHERE DOB_CUS BETWEEN '1980-01-01' AND '1990-12-31';

SELECT *
FROM TBL_CUSTOMER
WHERE EXISTS (
    SELECT 1
    FROM TBL_WORK_ORDER
    WHERE TBL_WORK_ORDER.CUST_ID_WO = TBL_CUSTOMER.CUST_ID_CUS
	);

------------------------------------------------------------- PRAGYA DESHAWAR------------------------------------------------------------------------------

--ALTER 
ALTER TABLE TBL_CUSTOMER
ADD MIDDLE_NAME VARCHAR(255);

UPDATE TBL_CUSTOMER
SET FNAME_CUS = 'Jack'
WHERE CUST_ID_CUS = 100001; 

ALTER TABLE TBL_CUSTOMER
DROP COLUMN MIDDLE_NAME;

SELECT *
FROM TBL_CUSTOMER
ORDER BY LNAME_CUS ASC, FNAME_CUS ASC;

SELECT *
FROM TBL_CUSTOMER
WHERE FNAME_CUS LIKE 'J%';

SELECT * FROM TBL_CUSTOMER
WHERE LNAME_CUS LIKE '_hin';

-----------------------------------------------------------PRACHI SHARMA(34)------------------------------------------------------------------------------

SELECT GENRE_ITM, MAX(PRICE_ITM) AS MaxPrice
FROM TBL_ORDER_ITEM
GROUP BY GENRE_ITM;

SELECT GENRE_ITM, MIN(PRICE_ITM) AS MinPrice
FROM TBL_ORDER_ITEM
GROUP BY GENRE_ITM;


SELECT GENRE_ITM, SUM(PRICE_ITM) AS TotalPrice
FROM TBL_ORDER_ITEM
GROUP BY GENRE_ITM;

SELECT GENRE_ITM, COUNT(*) AS ItemCount
FROM TBL_ORDER_ITEM
GROUP BY GENRE_ITM;


SELECT GENRE_ITM, AVG(PRICE_ITM) AS AvgPrice
FROM TBL_ORDER_ITEM
GROUP BY GENRE_ITM;

SELECT *
FROM TBL_ORDER_ITEM
WHERE PRICE_ITM > 15 AND GENRE_ITM = 'SPORTS';

Select * from TBL_ORDER_ITEM;

SELECT *
FROM TBL_ORDER_ITEM
WHERE GENRE_ITM = 'SPORTS' OR PRICE_ITM > 18;


------------------------------------------------------ SIMRAN PARESH SANGAL-------------------------------------------------------------------------------

-- Count the number of work orders for each customer's first name and display the result in descending order.
SELECT
    C.FNAME_CUS AS CustomerFirstName,
    COUNT(WO.ORD_ID_WO) AS NumberOfWorkOrders
FROM
    TBL_CUSTOMER C
JOIN
    TBL_WORK_ORDER WO ON C.CUST_ID_CUS = WO.CUST_ID_WO
GROUP BY
    C.FNAME_CUS
ORDER BY
    NumberOfWorkOrders DESC;

-- Nested query to find customers who have placed more than two work orders without using joins
SELECT FNAME_CUS, LNAME_CUS
FROM TBL_CUSTOMER C
WHERE (
    -- Subquery to count the number of work orders for each customer
    SELECT COUNT(*)
    FROM TBL_WORK_ORDER WO
    WHERE WO.CUST_ID_WO = C.CUST_ID_CUS
) > 2;

	-- Find customers who have more than two work orders and display the total count.
SELECT
    C.CUST_ID_CUS,
    C.FNAME_CUS,
    C.LNAME_CUS,
    COUNT(WO.ORD_ID_WO) AS TotalWorkOrders
FROM
    TBL_CUSTOMER C
JOIN
    TBL_WORK_ORDER WO ON C.CUST_ID_CUS = WO.CUST_ID_WO
GROUP BY
    C.CUST_ID_CUS, C.FNAME_CUS, C.LNAME_CUS
HAVING
    COUNT(WO.ORD_ID_WO) > 2;



--------------------------------------------------------------- GAYATHRI NARAYANAN ----------------------------------------------------------------------------------

/*************************** QUESTIONS FROM JOINS DATA **********************************/


Select * from TBL_STUDENT;
Select * from TBL_COURSE;
Select * from TBL_MAPPING;

--Q1: Display student details and the courses they are enrolled to.

SELECT
*
FROM
TBL_STUDENT AS A
LEFT JOIN TBL_MAPPING AS B ON A.STU_ID = B.STU_ID
LEFT JOIN TBL_COURSE AS C ON B.COURSE_ID = C.COURSE_ID;

--Q2: Display details of all students and the count of courses they are enrolled to.

SELECT
T1.STU_ID,	NAME, DOB, PHONE_CUS, EMAIL_CUS, COUNT(T2.STU_ID) AS CNT_OF_COURSES
FROM
TBL_STUDENT T1
LEFT JOIN TBL_MAPPING T2 ON T1.STU_ID = T2.STU_ID
GROUP BY
T1.STU_ID,	NAME, DOB, PHONE_CUS, EMAIL_CUS;

------------BASE OF THE ABOVE CODE ---------------------
SELECT
*
FROM
TBL_STUDENT T1
LEFT JOIN TBL_MAPPING T2 ON T1.STU_ID = T2.STU_ID;

--Q3: Display details of students which are not yet enrolled to any course.

SELECT
*
FROM
TBL_STUDENT AS A
LEFT JOIN TBL_MAPPING B ON A.STU_ID = B.STU_ID
WHERE
B.COURSE_ID IS NULL;

--------- OR----------------
SELECT
A.STU_ID, NAME, DOB, PHONE_CUS, EMAIL_CUS, COUNT(B.STU_ID) AS NO_OF_COURSES
FROM
TBL_STUDENT AS A
LEFT JOIN TBL_MAPPING B ON A.STU_ID = B.STU_ID
GROUP BY
A.STU_ID, NAME, DOB, PHONE_CUS, EMAIL_CUS
HAVING
COUNT(B.STU_ID) = 0;

--Q4: List all courses and the count of students enrolled to each course. (RIGHT JOIN)

SELECT
A.COURSE_ID, NAME, COUNT(B.STU_ID) AS NO_OF_STU
FROM
TBL_COURSE A
LEFT JOIN TBL_MAPPING B ON A.COURSE_ID = B.COURSE_ID
GROUP BY
A.COURSE_ID, NAME;

 ------- OR------------
SELECT
B.COURSE_ID, NAME, COUNT(A.STU_ID) AS NO_OF_STU
FROM
TBL_MAPPING A
RIGHT JOIN TBL_COURSE B ON A.COURSE_ID = B.COURSE_ID
GROUP BY
B.COURSE_ID, NAME;




-------------------------------------------------------------------------------------------------------------
/************************* QUESTIONS FROM MSO DATABASE **********************************/

--CUSTOMER DETAILS
SELECT * FROM TBL_CUSTOMER

--HOUSE DETAILS, ONE CUSTOMER CAN HAVE 2 HOUSES
SELECT *  FROM TBL_HOUSE

--WORK ORDER DETAILS, INSTALL/DISCONNECT WITH STATUS-OPEN/CLOSE
SELECT * FROM TBL_WORK_ORDER

--COMPLAINTS
SELECT * FROM TBL_COMPLAINT_ORDER

--ORDER DETAILS
SELECT *  FROM TBL_ORDER_ITEM;

SELECT
*
FROM
TBL_CUSTOMER
INNER JOIN TBL_HOUSE ON CUST_ID_CUS = CUST_ID_HSE;

--Q1: In order to post welcome letters and user guides to customers, dispatch team need 
--   customer name, address and contact details. Write SQL query to get desired info.

select 
concat(FNAME_CUS,' ', LNAME_CUS) as Customer_Name,
concat(ADDRESS_HSE,' , ',CITY_HSE,' , ',COUNTRY_HSE) as House_Address,
PHONE_CUS
from
TBL_CUSTOMER 
inner join
TBL_HOUSE
on CUST_ID_CUS=CUST_ID_HSE

--Q2: Get the details of customers who are using our services in more than one location.

SELECT  
concat(FNAME_CUS,' ', LNAME_CUS) as Customer_Name,
PHONE_CUS,
COUNT(HOUSE_ID_HSE) AS NO_OF_HOUSES
FROM
TBL_CUSTOMER
LEFT JOIN
TBL_HOUSE
ON CUST_ID_CUS=CUST_ID_HSE
GROUP BY
concat(FNAME_CUS,' ', LNAME_CUS),
PHONE_CUS
HAVING COUNT(HOUSE_ID_HSE)>1

--Q3: Which are the customers that have not given their house details.

SELECT COUNT(*) AS CUST_WITH_NO_HOUSE FROM (
select 
*
from
TBL_CUSTOMER 
LEFT join
TBL_HOUSE
on CUST_ID_CUS=CUST_ID_HSE
WHERE HOUSE_ID_HSE IS NULL

) AS S

---------- OR----------
SELECT  
concat(FNAME_CUS,' ', LNAME_CUS) as Customer_Name,
--PHONE_CUS,
COUNT(HOUSE_ID_HSE) AS NO_OF_HOUSES
FROM
TBL_CUSTOMER
LEFT JOIN
TBL_HOUSE
ON CUST_ID_CUS=CUST_ID_HSE
GROUP BY
concat(FNAME_CUS,' ', LNAME_CUS)
--PHONE_CUS
HAVING COUNT(HOUSE_ID_HSE)=0


----SUBQUERY IN JOINS----------------

SELECT * FROM 
TBL_HOUSE
INNER JOIN
(SELECT * FROM TBL_WORK_ORDER WHERE TYPE_WO='INSTALL' AND STATUS_WO='CLOSE')A
ON
HOUSE_ID_HSE=A.HOUSE_ID_WO AND CUST_ID_HSE=A.CUST_ID_WO



--Q4: Get the location details along with count of services installed in the location.

SELECT * FROM TBL_ORDER_ITEM

SELECT
HOUSE_ID_HSE, 
ADDRESS_HSE + ', ' + CITY_HSE + ', ' +  COUNTRY_HSE AS HOUSE_ADDRESS,
COMPL_DTE_WO AS INSTALL_DATE,
--ORD_ID_ITM, 
COUNT(ORD_ID_ITM) AS NO_OF_SERVICES
FROM
TBL_HOUSE
INNER JOIN TBL_WORK_ORDER ON CUST_ID_WO = CUST_ID_HSE AND HOUSE_ID_WO = HOUSE_ID_HSE
INNER JOIN TBL_ORDER_ITEM ON ORD_ID_WO=ORD_ID_ITM
WHERE
TYPE_WO = 'INSTALL' AND STATUS_WO = 'CLOSE'
GROUP BY
HOUSE_ID_HSE, 
ADDRESS_HSE + ', ' + CITY_HSE + ', ' +  COUNTRY_HSE,
COMPL_DTE_WO 







 



