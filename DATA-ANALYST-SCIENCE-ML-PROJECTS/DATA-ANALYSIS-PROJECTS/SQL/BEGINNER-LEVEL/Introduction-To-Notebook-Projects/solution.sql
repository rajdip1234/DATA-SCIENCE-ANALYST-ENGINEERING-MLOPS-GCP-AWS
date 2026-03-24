-- Here's an example query solution. 
-- Try submitting the project without changing anything to see the feedback message.
-- Now update the query to filter on order_id 10 to get it correct.
--select customer_id
--from sales.orders
--where order_id = 9 -- replace with 10 and submit to complete the project.

-- Make sure this is copied to a SQL cell that is outputting a DataFrame called 'solution'
SELECT customer_id
FROM sales.orders
WHERE order_id = 10
