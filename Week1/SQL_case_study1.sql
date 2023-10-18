/* --------------------
   Case Study Questions
   --------------------*/

-- 1. What is the total amount each customer spent at the restaurant?


SELECT customer_id, SUM(price)
FROM dannys_diner.menu AS m
INNER JOIN dannys_diner.sales AS s
ON m.product_id= s.product_id
GROUP BY customer_id
order by 1;

-- 2. How many days has each customer visited the restaurant?
SELECT customer_id, Count(DISTINCT order_date)
FROM dannys_diner.sales 
group by customer_id
order by 1;

-- 3. What was the first item from the menu purchased by each customer?


with cust_order_rank as (
select *,
RANK() OVER(PARTITION BY s.customer_id ORDER BY s.order_date)
from dannys_diner.sales s left join dannys_diner.menu m
ON m.product_id= s.product_id 
)
select distinct customer_id, product_name from cust_order_rank where 
rank= 1 ;

-- 4. What is the most purchased item on the menu and how many times was it purchased by all customers?

SELECT product_name AS item, COUNT(1)
FROM dannys_diner.sales AS s 
LEFT JOIN dannys_diner.menu AS m
ON s.product_id=m.product_id
GROUP BY product_name
ORDER BY COUNT(s.product_id) DESC 
LIMIT 1;


-- 5. Which item was the most popular for each customer?

SELECT product_name, COUNT(




6. Which item was purchased first by the customer after they became a member?
SELECT s.customer_id, product_name, join_date,order_date
FROM dannys_diner.sales AS s 
LEFT JOIN dannys_diner.members AS m
ON s.customer_id=m.customer_id
LEFT JOIN dannys_diner.menu AS f 
ON s.product_id=f.product_id
WHERE order_date<join_date
GROUP BY s.customer_id, product_name, join_date,order_date
ORDER BY order_date;





-- 7. Which item was purchased just before the customer became a member?

SELECT s.customer_id, product_name, join_date,order_date
FROM dannys_diner.sales AS s 
LEFT JOIN dannys_diner.members AS m
ON s.customer_id=m.customer_id
LEFT JOIN dannys_diner.menu AS f 
ON s.product_id=f.product_id
WHERE order_date<join_date
GROUP BY s.customer_id, product_name, join_date,order_date
ORDER BY order_date;




-- 8. What is the total items and amount spent for each member before they became a member?

SELECT COUNT(s.product_id), SUM(price), product_name, join_date, s.customer_id
FROM dannys_diner.sales AS s 
LEFT JOIN dannys_diner.menu AS f 
ON s.product_id=f.product_id LEFT JOIN
dannys_diner.members AS m 
ON s.customer_id=m.customer_id
WHERE order_date<join_date
GROUP BY product_name, join_date, s.customer_id
ORDER BY COUNT(s.product_id) DESC;


-- 9.  If each $1 spent equates to 10 points and sushi has a 2x points multiplier - how many points would each customer have?
SELECT price, product_name, s.customer_id
FROM dannys_diner.sales AS s 
LEFT JOIN dannys_diner.menu AS f 
ON s.product_id = f.product_id
GROUP by price, product_name, s.customer_id;


-- 10. In the first week after a customer joins the program (including their join date) they earn 2x points on all items, not just sushi - how many points do customer A and B have at the end of January?

-- Example Query:
SELECT
   product_id,
    product_name,
    price
FROM dannys_diner.menu
ORDER BY price DESC
LIMIT 5;




