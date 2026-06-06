with ranked as (

select 
website_session_id,
pageview_url,
count(*) over (partition by website_session_id order by created_at) AS viewz,
row_number() over (partition by website_session_id order by created_at) as rn
from website_pageviews
),

homepage as (select 
website_session_id, 
pageview_url
from ranked
where rn=1),

view_number as (select 
h.website_session_id,
btrim(regexp_replace(h.pageview_url,'[^a-zA-Z0-9]',' ','g')) as landing_page,
count(wp.*) as viewed
from homepage as h
inner join website_pageviews  as wp
on h.website_session_id=wp.website_session_id
group by 1,2)


select 
case when landing_page in('home','lander 1','lander 2','lander 3','lander 4') then 'Landing B' else 'Landing A'
end as landing_page,
case when viewed= 1 then 'Yes' else 'No' end as Bounced
from view_number