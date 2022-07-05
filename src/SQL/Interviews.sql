/* Zack interviews many candidates from different colleges and universities using coding
challenges and contests. Write a query to print the `contest_id`, `user_id`, `name` and the sum
of `total_submissions`, `total_accepted_submissions`, `total_views` and `total_unique_views` for
each contest sorted by `contest_id`. Exclude the contest from the result if all four sums are 0.
	  
66406 17973 Harsh 111 39 156 56
66556 79153 Will 0 0 11 10
94828 80275 Pascal 150 38 41 15

 Explanation
The contest 66406 is used in the college 11219. In this college 11219, challenges 18765 and
47127 are asked, so from the view and submission stats:

- Sum of total submissions= 27 + 56 +28 = 111
- Sum of total accepted submissions = 10 + 18 + 11 = 39
- Sum of total views = 43 + 72 + 26 + 15 = 156
- Sum of total unique views = 10 + 13 + 19 + 14 = 56
Similarly, we can find the sums for contests 66556 and 94828.
 */

----- CREATE -----
create table Contests (
	contest_id int primary key,
	user_id int not null, -- id of the hacker who created the contest
	name text not null -- name of the hacker
);

create table Colleges (
	college_id int primary key,
	contest_id int references Contests (contest_id) not null -- id of the contest that Zack used to screen candidates
);

create table Challenges (
	challenge_id serial primary key, -- id of the challenge that belongs to one of the contests whose "contest_id" Zack forgot
	college_id int references Colleges (college_id) not null -- id of the college where the challenge was given to candidates
);

create table View_stats (
	view_stats_id serial primary key,
	challenge_id int not null,
	total_views int default 0 not null, -- the number of times the challenge was viewed by candidates
	total_unique_views int default 0 not null -- the numer of times the challenge was viewed by unique candidates
);

create table Submission_stats (
	submission_stats_id serial primary key,
	challenge_id int not null,
	total_submissions int default 0 not null, -- the number of submissions for the challenge
	total_accepted_submissions int default 0 not null -- the number of submissions that achieved full scores
);

----- INPUT -----
insert into Contests (contest_id, user_id, name)
values (66406, 17973, 'Harsh'),
	   (66556, 79153, 'Will'),
	   (94828, 80275, 'Pascal');
	   
insert into Colleges (college_id, contest_id)
values (11219, 66406),
	   (32473, 66556),
	   (56685, 94828);	  
	  
insert into Challenges (challenge_id, college_id)
values (18765, 11219),
	   (47127, 11219),
	   (60292, 32473),
	   (72974, 56685);
	  
insert into View_stats (challenge_id, total_views, total_unique_views)
values (47127, 26, 19),
	   (47127, 15, 14),
	   (18765, 43, 10),
	   (18765, 72, 13),
	   (75516, 35, 17),
	   (60292, 11, 10),
	   (72974, 41, 15),
	   (75516, 75, 11);
	  
insert into Submission_stats (challenge_id, total_submissions, total_accepted_submissions)
values (75516, 34, 12),
	   (47127, 27, 10),
	   (47127, 56, 18),
	   (75516, 74, 12),
	   (75516, 83, 8),
	   (72974, 68, 24),
	   (72974, 82, 14),
	   (47127, 28, 11);
	  
----- QUERY -----
	  
/*print the `contest_id`, `user_id`, `name` and the sum of `total_submissions`, `total_accepted_submissions`, `total_views` and `total_unique_views`
for each contest sorted by `contest_id`. Exclude the contest from the result if all four sums are 0.*/
	  
select
	res.contest_id,
	res.user_id,
	res.name,
	SUM(res.total_submissions) as total_submissions,
	SUM(res.total_accepted_submissions) as total_accepted_submissions,
	SUM(res.total_views) as total_views,
	SUM(res.total_unique_views) as total_unique_views
from((
select 
	Contests.contest_id,
	Contests.user_id,
	Contests.name,
	SUM(coalesce(total_views, 0)) as total_views,
	SUM(coalesce(total_unique_views, 0)) as total_unique_views,
	0 as total_submissions,
	0 as total_accepted_submissions
from Contests
inner join Colleges on Colleges.contest_id = Contests.contest_id
inner join Challenges on Challenges.college_id = Colleges.college_id
left join View_stats on View_stats.challenge_id = Challenges.challenge_id
group by Contests.contest_id)
union all
(select 
	Contests.contest_id,
	Contests.user_id,
	Contests.name,
	0 as total_views,
	0 as total_unique_views,
	SUM(coalesce(total_submissions, 0)) as total_submissions,
	SUM(coalesce(total_accepted_submissions, 0)) as total_accepted_submissions
from Contests
inner join Colleges on Colleges.contest_id = Contests.contest_id
inner join Challenges on Challenges.college_id = Colleges.college_id
left join Submission_stats on Submission_stats.challenge_id = Challenges.challenge_id
group by Contests.contest_id)) res 
group by res.contest_id, res.user_id, res.name
having SUM(total_views + total_unique_views + total_submissions + total_accepted_submissions) <> 0
order by contest_id
	  
	  
	  
	  
	  
	  
	  
	  
	  