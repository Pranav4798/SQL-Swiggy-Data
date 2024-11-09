-- How many restaurants have a rating greater than 4.5 ?
select count(*)
from swiggy s 
where s.rating > 4.5

--WHICH IS THE TOP 1 CITY WITH THE HIGHEST NUMBER OF RESTAURANTS?
select count(*), city
from swiggy s 
group by s.city 
order by 1 desc 
limit 1

--HOW MANY RESTAURANTS HAVE THE WORD "PIZZA" IN THEIR NAME?
select s.restaurant_name 
from swiggy s 
where s.restaurant_name like '%Pizza%'
group by s.restaurant_name 

--WHAT IS THE MOST COMMON CUISINE AMONG THE RESTAURANTS IN THE DATASET?
select cuisine, count(1) 
from swiggy s 
group by s.cuisine 
order by 2 desc 

--WHAT IS THE AVERAGE RATING OF RESTAURANTS IN EACH CITY?
select s.city, round(avg(s.rating)::numeric,2) as Rating 
from swiggy s 
group by s.city
order by 2 desc

--WHAT IS THE HIGHEST PRICE OF ITEM UNDER THE 'RECOMMENDED' MENU CATEGORY FOR EACH RESTAURANT?
select s.restaurant_name, max(s.price), s.item 
from swiggy s 
where s.menu_category = 'Recommended'
group by s.restaurant_name, s.item 
order by 2 desc

--FIND THE TOP 5 MOST EXPENSIVE RESTAURANTS THAT OFFER CUISINE OTHER THAN INDIAN CUISINE.
select s.restaurant_name , max(s.price), s.cuisine 
from swiggy s 
where s.cuisine not like '%Indian%'
group by s.restaurant_name , s.price, s.cuisine 
order by price desc
limit 5

--FIND THE RESTAURANTS THAT HAVE AN AVERAGE COST WHICH IS HIGHER THAN THE TOTAL AVERAGE COST OF ALL RESTAURANTS TOGETHER.
select distinct s.restaurant_name, s.cost_per_person 
from swiggy s 
where cost_per_person > (select avg(cost_per_person) from swiggy )
order by 2 desc

--RETRIEVE THE DETAILS OF RESTAURANTS THAT HAVE THE SAME NAME BUT ARE LOCATED IN DIFFERENT CITIES.
select distinct s2.restaurant_name, s.city, s2.city 
from swiggy s join swiggy s2 on s.restaurant_name = s2.restaurant_name 
and s.city <> s2.city 

--WHICH RESTAURANT OFFERS THE MOST NUMBER OF ITEMS IN THE 'MAIN COURSE'CATEGORY?
select s.restaurant_name, s.menu_category, count (*) 
from swiggy s 
where s.menu_category = 'Main Course'
group by 2, 1
order by 3 desc
limit 1

--LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN INALPHABETICAL ORDER OF RESTAURANT NAME.
select distinct s.restaurant_name 
from swiggy s 
where s."veg_or_non-veg" like '%veg%'
group by restaurant_name 
order by 1 

--LIST THE NAMES OF RESTAURANTS THAT ARE 100% VEGEATARIAN INALPHABETICAL ORDER OF RESTAURANT NAME.
select * from (
select distinct restaurant_name,
(count(case when "veg_or_non-veg"='Veg' then 1 end)*100/
count(*)) as vegetarian_percentage
from swiggy
group by restaurant_name )
where vegetarian_percentage=100.00
order by restaurant_name

--WHICH IS THE RESTAURANT PROVIDING THE LOWEST AVERAGE PRICE FOR ALL ITEMS?
select s.restaurant_name, round(avg(s.price)::numeric, 2)
from swiggy s 
group by 1
order by 2
limit 5

--WHICH TOP 5 RESTAURANT OFFERS HIGHEST NUMBER OF CATEGORIES?
select distinct restaurant_name, count(distinct s.menu_category)
from swiggy s 
group by s.restaurant_name 
order by 2 desc
limit 5

----WHICH RESTAURANT PROVIDES THE HIGHEST PERCENTAGE OF NON-VEGEATARIAN FOOD?
select * from (
select s.restaurant_name, 
(count(case when "veg_or_non-veg" = 'Non-veg' then 1 end) * 100/count(*)) as Non_Veg_Percent
from swiggy s
group by s.restaurant_name )
where Non_Veg_Percent = 100.00
order by restaurant_name





