-- Напишите запросы, которые выводят следующую информацию:
-- 1. Название компании заказчика (company_name из табл. customers) и ФИО сотрудника, работающего над заказом этой компании (см таблицу employees),
-- когда и заказчик и сотрудник зарегистрированы в городе London, а доставку заказа ведет компания United Package (company_name в табл shippers)

select company_name as customer, CONCAT(first_name, ' ', last_name) as employee
from orders
join customers using (customer_id)
join employees using (employee_id)
where exists (select 1 from shippers
			  where orders.ship_via=shippers.shipper_id and shippers.company_name = 'United Package')
			  and customers.city = 'London' and employees.city = 'London'


-- 2. Наименование продукта, количество товара (product_name и units_in_stock в табл products),
-- имя поставщика и его телефон (contact_name и phone в табл suppliers) для таких продуктов,
-- которые не сняты с продажи (поле discontinued) и которых меньше 25 и которые в категориях Dairy Products и Condiments.
-- Отсортировать результат по возрастанию количества оставшегося товара.

SELECT product_name,units_in_stock,suppliers.contact_name,suppliers.phone
FROM products
JOIN suppliers USING(supplier_id)
WHERE (products.discontinued=0 and units_in_stock<25) and (products.category_id=2
or products.category_id=4)
ORDER BY units_in_stock


-- 3. Список компаний заказчиков (company_name из табл customers), не сделавших ни одного заказа

SELECT customers.company_name from customers
LEFT JOIN orders USING (customer_id)
WHERE orders.order_id IS NULL


-- 4. уникальные названия продуктов, которых заказано ровно 10 единиц (количество заказанных единиц см в колонке quantity табл order_details)
-- Этот запрос написать именно с использованием подзапроса.

SELECT DISTINCT products.product_name from products
WHERE EXISTS(SELECT* FROM order_details WHERE products.product_id=order_details.product_id
			AND quantity=10)
