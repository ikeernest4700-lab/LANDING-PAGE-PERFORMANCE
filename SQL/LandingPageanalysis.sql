
 WITH landpage AS (
         SELECT website_pageviews.website_session_id,
            website_pageviews.pageview_url AS landing_page,
            row_number() OVER (PARTITION BY website_pageviews.website_session_id ORDER BY website_pageviews.created_at) AS rn
           FROM website_pageviews
        ), firstpage AS (
         SELECT landpage.website_session_id,
            landpage.landing_page,
            landpage.rn
           FROM landpage
          WHERE landpage.rn = 1
        ), tab AS (
         SELECT w.website_session_id,
            w.created_at,
            w.device_type AS device,
            w.utm_source AS camp_source,
            w.utm_campaign AS campaign,
            COALESCE(r.rev, 0::double precision) AS revenue,
            v.number_of_views,
                CASE
                    WHEN v.number_of_views = 1 THEN 1
                    ELSE 0
                END AS bounce,
            f.landing_page,
            min(
                CASE
                    WHEN l.landing_page::text = ANY (ARRAY['/home'::character varying, '/lander-1'::character varying, '/lander-2'::character varying, '/lander-3'::character varying, '/lander-4'::character varying, '/lander-5'::character varying]::text[]) THEN l.rn
                    ELSE NULL::bigint
                END) AS landing_reach,
            min(
                CASE
                    WHEN l.landing_page::text = '/products'::text THEN l.rn
                    ELSE NULL::bigint
                END) AS product_reach,
            min(
                CASE
                    WHEN l.landing_page::text = '/cart'::text THEN l.rn
                    ELSE NULL::bigint
                END) AS cart_reach,
            min(
                CASE
                    WHEN l.landing_page::text = '/shipping'::text THEN l.rn
                    ELSE NULL::bigint
                END) AS shipping_reach,
            min(
                CASE
                    WHEN l.landing_page::text = ANY (ARRAY['/billing'::character varying, '/billing-2'::character varying]::text[]) THEN l.rn
                    ELSE NULL::bigint
                END) AS billing_reach,
            min(
                CASE
                    WHEN l.landing_page::text = '/thank-you-for-your-order'::text THEN l.rn
                    ELSE NULL::bigint
                END) AS purchase_reach
           FROM website_sessions w
             LEFT JOIN landpage l ON w.website_session_id = l.website_session_id
             JOIN firstpage f ON w.website_session_id = f.website_session_id
             LEFT JOIN re r ON w.website_session_id = r.website_session_id
             JOIN viewz v ON w.website_session_id = v.website_session_id
          GROUP BY w.website_session_id, w.created_at, w.device_type, w.utm_source, w.utm_campaign, (COALESCE(r.rev, 0::double precision)), v.number_of_views, (
                CASE
                    WHEN v.number_of_views = 1 THEN 1
                    ELSE 0
                END), f.landing_page
        ), funnels AS (
         SELECT tab.website_session_id,
            tab.created_at,
            tab.device,
            tab.camp_source,
            btrim(initcap(regexp_replace(regexp_replace(tab.campaign::text, 'NULL'::text, 'No Campaign'::text, 'g'::text), '[^a-zA-Z0-9]'::text, ' '::text, 'g'::text))) AS campaign,
            tab.revenue,
            tab.bounce,
            initcap(btrim(regexp_replace(regexp_replace(tab.landing_page::text, '[^a-zA-Z0-9]'::text, ' '::text, 'g'::text), 'home'::text, 'Home Page'::text, 'g'::text))) AS landing_page,
                CASE
                    WHEN tab.landing_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS landing,
                CASE
                    WHEN tab.product_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS product,
                CASE
                    WHEN tab.cart_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS cart,
                CASE
                    WHEN tab.shipping_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS shipping,
                CASE
                    WHEN tab.billing_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS billing,
                CASE
                    WHEN tab.purchase_reach IS NOT NULL THEN 1
                    ELSE 0
                END AS purchase
           FROM tab
        )
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('landing'::text) AS step,
    1 AS step_order,
    funnels.landing AS reach
   FROM funnels
UNION ALL
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('product'::text) AS step,
    2 AS step_order,
    funnels.product AS reach
   FROM funnels
UNION ALL
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('cart'::text) AS step,
    3 AS step_order,
    funnels.cart AS reach
   FROM funnels
UNION ALL
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('shipping'::text) AS step,
    4 AS step_order,
    funnels.shipping AS reach
   FROM funnels
UNION ALL
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('billing'::text) AS step,
    5 AS step_order,
    funnels.billing AS reach
   FROM funnels
UNION ALL
 SELECT funnels.website_session_id,
    funnels.created_at,
    funnels.device,
    funnels.camp_source,
    funnels.campaign,
    funnels.revenue,
    funnels.bounce,
    funnels.landing_page,
    initcap('purchase'::text) AS step,
    6 AS step_order,
    funnels.purchase AS reach
   FROM funnels;