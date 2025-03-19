
-- SQL LEARNING SESSIONS - 08th March 2025.

-- process flow and tools that i used
   -- https://aiven.io/  -- the platform that manages databases in the cloud -- i used postgreSql for my case but 
                         -- you can choose from a wide range of databases like MYSQL, oracle sybase etc

   -- for managing the database i used a database management tool called dBeaver community edition (https://dbeaver.io/download/)

-- In case you have your data in Excel format I found this blog useful in explaining how to import it: https://virtual-dba.com/blog/postgresql-excel-data-imports-using-dbeaver/


-- Creating schemas

CREATE SCHEMA test_01;

create schema users;

create schema practice;

-- Creating empty tables

create table STUDENT (
student_name  varchar(50),
student_age   int,
email_address varchar(50)
);

create table test_01.STUDENT1 (
student_name  varchar(50),
student_age   int,
email_address varchar(50)
);


create table public.web_events(
id integer,
account_id integer,
occured_at timestamp,
channel bpchar
);


select * 
from web_events;

-- Create an empty table into the practice scheme. If you fail to specify the schema, the table is created
-- within the default schema which is called public


select * 
from practice.web_events;

-- Insert some records into the table

INSERT INTO practice.web_events VALUES (1,1001,'2015-10-06 17:13:58','direct');
INSERT INTO practice.web_events VALUES (2,1001,'2015-11-05 03:08:26','twitter');
INSERT INTO practice.web_events VALUES (3,1001,'2015-12-04 03:57:24','direct');

select * 
from practice.web_events;


-- Differences between DELETE, TRUNCATE and DROP

truncate table practice.web_events; -- deletes columns but the table remains

drop table practice.web_events; -- removes the entire table from the database

delete from practice.web_events -- removes rows based on a condition
where channel = 'twitter'
;


CREATE TABLE public.web_events (
	id integer,
	account_id integer,
	occurred_at timestamp,
	channel bpchar
);




select *
from web_events;

-- How many web events occured in total

select count(*)
from web_events;

-- How many unique accounts have web events?

select count(distinct account_id)
from web_events;

-- What are the top 5 most used channels

select count(*) as count1, channel
from  web_events
group by channel
order by count1 desc
limit 5
;

-- How many web events happened per month in 2016

select * from  web_events;


select date_trunc('month', occured_at) as month, count(*) as event_count
from web_events
where occured_at between '2016-01-01' and '2016-12-31'
group by month
order by month
;


-- Which account had the most web events?

select account_id, COUNT(*) as event_count
from web_events
group by account_id
order by event_count desc
limit 1
;

-- What is the first and last recorded web event?

select  min(account_id) as first, max(account_id) as last
from web_events
;

-- Which channels had more than 100 web events?

select channel, count(*) as event_counts
from web_events 
group by channel 
having count(*) > 100
;

-- How many web events occured on weekends?


select  count(*)
from web_events
where extract(dow from occured_at) in (0,6)
;

-- How many web events happened in the first quarter of 2016?

select  count(*)
from web_events 
where occured_at between '2016-01-01' and '2016-03-31'
;


-- Which account had the earliest web event?

select occured_at, account_id
from web_events 
order by occured_at  
limit 1
;

-- How many web events occured per day on average?

select count(*)/ count(distinct date(occured_at)) as avg_per_day
from web_events
;


-- Which day had the highest number of web events?

select date(occured_at) as event_date, count(*) as event_count
from web_events 
group by event_date
order by event_count desc 
limit 1
;

-- What is the percentage of web events that occured through each channel?

select COUNT(*)*100.0 / (select count(*) from web_events) as pct, channel
from web_events
group by channel 
;

-- Find the number of events per channel for each month in 2016

select count(*) as event_count, date_trunc('month', occured_at) as month, channel
from web_events
where occured_at between '2016-01-01' and '2016-12-01'
group by month, channel 
order by month, event_count desc
;


-- How many events happened in the evening (after 6pm)?

select count(*) as event_count
from web_events 
where extract(hour from occured_at) >= 18
;




