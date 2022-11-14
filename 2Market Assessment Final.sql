--STEP 1: CREATE TABLES
CREATE TABLE public.marketing_data4(
"ID" BIGINT, 
"Year_Birth" INT,
"Age" INT,
"Education" CHAR(10),
"Marital_Status" TEXT,
"Income" NUMERIC(8,2),
"Kidhome" INT,
"Teenhome" INT, 
"DT_Customer" DATE,
"Recency" INT, 
"AmtLiq" INT,
"AmtVege" INT,
"AmtNonVege" INT,
"AmtPes" INT,
"AmtChocolate" INT,
"AmtComm" INT,
"NumDeals" INT,
"NumWebBuy" INT,
"NumWalkinPur" INT,
"NumVisits" INT,
"Response" INT,
"Complain" INT,
"Country" CHAR(5),
"Count_success" INT);
CREATE TABLE public.ad_data(
"ID" BIGINT,
"Bulkmail_ad" INT,
"Twitter_ad" INT,
"Instagram_ad" INT,
"Facebook_ad" INT,
"Brochure_ad" INT);
--TABLES STORED SUCCESSFULLY--
--CLEANED AND IMPORTED CSV FILES--

--QUESTION 1 WHAT IS THE TOTAL SPEND PER COUNTRY?
SELECT SUM ("AmtLiq" + "AmtVege" + "AmtNonVege" + "AmtPes" + "AmtChocolate" + "AmtComm"), "Country"
FROM public.marketing_data4
GROUP BY "Country"

--"sum"	"Country"
657704	"SP   "
167403	"CA   "
77741	"IND  "
85576	"AUS  "
67546	"US   "
3122	"ME   "
210987	"SA   "
73198	"GER  "

--QUESTION 2 WHAT IS THE TOTAL SPEND PER PRODUCT PER COUNTRY?
SELECT SUM("AmtLiq"),"Country"
FROM public.marketing_data4
GROUP BY "Country"
--Substitute "AmtXYZ" per all AMT columns
LIQ
335637	"SP   "
84066	"CA   "
36221	"IND  "
42752	"AUS  "
32214	"US   "
1729	"ME   "
105901	"SA   "
36776	"GER  "

VEGE
28144	"SP   "
7681	"CA   "
3782	"IND  "
3689	"AUS  "
3034	"US   "
8	     "ME   "
8923	"SA   "
2980	"GER  "

NONVEGE
177847	"SP   "
45925	"CA   "
23721	"IND  "
22328	"AUS  "
20185	"US   "
817	     "ME   "
58375	"SA   "
20272	"GER  "

PES
40049	"SP   "
9980	"CA   "
4811	"IND  "
5546	"AUS  "
4411	"US   "
226	     "ME   "
13655	"SA   "
4601	"GER  "

CHOC
30070	"SP   "
7607	"CA   "
3217	"IND  "
4129	"AUS  "
2863	"US   "
122	    "ME   "
9018	"SA   "
2801	"GER  "

COMM
45957	"SP   "
12144	"CA   "
5989	"IND  "
7132	"AUS  "
4839	"US   "
220	     "ME  "
15115	"SA   "
5768	"GER  "

--QUESTION 3 WHICH PRODUCTS ARE THE MOST POPULAR IN EACH COUNTRY?
SELECT SUM("AmtVege") AS veg, SUM("AmtLiq") AS liq, SUM("AmtNonVege") AS nonveg, SUM("AmtChocolate") AS choc, SUM("AmtPes") AS fish, SUM("AmtComm") AS comm, "Country"
FROM public.marketing_data4
GROUP BY "Country"
"veg"	"liq"	   "nonveg"	"choc"	"fish"	"comm"	"Country"
28144	335637	177847	30070	40049	45957	"SP   "
7681	84066	45925	7607	9980	12144	"CA   "
3782	36221	23721	3217	4811	5989	"IND  "
3689	42752	22328	4129	5546	7132	"AUS  "
3034	32214	20185	2863	4411	4839	"US   "
8	     1729	  817	 122	 226	220 	"ME   "
8923	105901	58375	9018	13655	15115	"SA   "
2980	36776	20272	2801	4601	5768	"GER  "

--QUESTION 4 WHICH PRODUCTS ARE THE MOST POPULAR BY MARITAL STATUS?
SELECT SUM("AmtVege") AS VEG, SUM("AmtLiq") AS LIQ, SUM("AmtNonVege") AS NONVEG, SUM("AmtChocolate") AS CHOCCY, SUM("AmtPes") AS FISH, SUM("AmtComm")AS COMM, "Marital_Status"
FROM public.marketing_data4
GROUP BY "Marital_Status"
“Veg”	“Liq”	“NonVeg”“Choccy”“Fish” “Comm”	"Marital_Status"
2422	27902*	14085	2878	3793	4245	 "Widow"
14454	175951	94794*	14966	22271	24518	 "Together"
21981	256976	137888	22926	30395	36719	"Married"
6357	75349*	34840	6218	8123	10714	"Divorced"
12840	137209	87059	12751	18255	20395*	"Single"

SELECT SUM ("AmtLiq" + "AmtVege" + "AmtNonVege" + "AmtPes" + "AmtChocolate" + "AmtComm"), "Country"
FROM public.marketing_data4
GROUP BY "Country"

--PART TWO: JOINING TABLES
--JOIN THE TWO TABLES
SELECT * FROM public.marketing_data4
INNER JOIN public.ad_data
USING ("ID")

--QUESTION ONE: Which social media platform (Twitter, Instagram, or Facebook) 
--is the most effective method of advertising in each country? 
SELECT "Country",
SUM("Twitter_ad") AS Twitter_sum, 
SUM("Instagram_ad") AS Instagram_sum, 
SUM("Facebook_ad") AS Facebook_SUM 
FROM public.marketing_data4
INNER JOIN public.ad_data
USING ("ID")
GROUP BY "Country"

--QUESTION TWO: Which social media platform is the most effective method of 
--advertising based on marital status?
SELECT marketing_data4."Marital_Status",
SUM("Twitter_ad") AS Twitter_sum, 
SUM("Instagram_ad") AS Instagram_sum, 
SUM("Facebook_ad") AS Facebook_sum,
SUM("Brochure_ad") AS Brochure_sum,
SUM("Bulkmail_ad") AS Bulkmail_sum
FROM public.marketing_data4
INNER JOIN
public.ad_data
USING ("ID")
GROUP BY "Marital_Status"

--QUESTION THREE: Which social media platform(s) seem(s) to be the most 
--effective per country? 
SELECT "Country",
SUM("Twitter_ad") AS Twitter_sum, 
SUM("Instagram_ad") AS Instagram_sum, 
SUM("Facebook_ad") AS Facebook_sum,
SUM("Brochure_ad") AS Brochure_sum,
SUM("Bulkmail_ad") AS Bulkmail_sum,
SUM ("AmtLiq" + "AmtVege" + "AmtNonVege" + "AmtPes" + "AmtChocolate" + "AmtComm") AS Totals
FROM public.marketing_data4
INNER JOIN public.ad_data USING ("ID")
GROUP BY "Country"


