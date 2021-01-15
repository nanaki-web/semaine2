-- Q1. Afficher dans l'ordre alphabétique et sur une seule colonne les noms et prénoms des employés qui ont des enfants, présenter d'abord ceux qui en ont le plus
select concat (emp_lastname ,"", emp_firstname)as 'nom du salarié',emp_children
from employees
where emp_children >0
ORDER BY emp_children DESC,emp_lastname ASC

-- Q2. Y-a-t-il des clients étrangers ? Afficher leur nom, prénom et pays de résidence.

select DISTINCT cus_lastname ,cus_firstname,cus_countries_id
from customers,countries
where cus_countries_id not LIKE '%FR%'
ORDER BY cus_countries_id ASC

-- Q3. Afficher par ordre alphabétique les villes de résidence des clients ainsi que le code (ou le nom) du pays.

SELECT cus_city,cus_countries_id,cou_name
FROM customers , countries 
where cus_countries_id = 'FR' AND cou_name = 'france'
ORDER BY cus_city ASC

-- Q4. Afficher le nom des clients dont les fiches ont été modifiées

SELECT cus_lastname,cus_update_date
FROM customers
WHERE cus_update_date IS NOT null

-- Q5. La commerciale Coco Merce veut consulter la fiche d'un client, mais la seule chose dont elle se souvienne est qu'il habite une ville genre 'divos'. Pouvez-vous l'aider ?

select cus_id,cus_lastname,cus_firstname,cus_city
FROM customers
WHERE cus_city LIKE '%divos%'

-- Q6. Quel est le produit vendu le moins cher ? Afficher le prix, l'id et le nom du produit.

SELECT pro_name,pro_id,pro_price
FROM products
WHERE pro_price=(SELECT MIN(pro_price)
FROM products)

-- Q7. Lister les produits qui n'ont jamais été vendus

SELECT pro_id,pro_name,pro_ref
FROM products
where pro_id NOT IN 
(SELECT ode_pro_id
FROM orders_details)




-- Q8. Afficher les produits commandés par Madame Pikatchien.

SELECT pro_id,pro_ref,pro_name,cus_id,ord_id,ode_id
FROM products,customers,orders_details,orders
where cus_id = ord_cus_id AND cus_lastname="Pikatchien" and ord_id=ode_ord_id and ode_pro_id=pro_id



SELECT pro_id,pro_ref,pro_name,cus_id,ord_id,ode_id
FROM products
JOIN orders_details
ON products.pro_id = orders_details.ode_pro_id
JOIN orders
ON orders_details.ode_ord_id = orders.ord_id
JOIN customers
ON orders.ord_cus_id = customers.cus_id
WHERE cus_lastname ='Pikatchien'



-- Q9. Afficher le catalogue des produits par catégorie, le nom des produits et de la catégorie doivent être affichés.

SELECT cat_id, cat_name,pro_name 
FROM categories 
INNER JOIN products 
ON categories.cat_id = products.pro_cat_id 
ORDER BY cat_name ASC


SELECT cat_id, cat_name,pro_name 
FROM categories ,products
WHERE cat_id = pro_cat_id
ORDER BY cat_name ASC

-- Q10. Afficher l'organigramme hiérarchique (nom et prénom et poste des employés) du magasin de Compiègne, classer par ordre alphabétique. Afficher le nom et prénom des employés, éventuellement le poste (si vous y parvenez).

SELECT concat(A.emp_lastname,' ',A.emp_firstname) AS 'superior' ,concat (B.emp_lastname,' ',B.emp_firstname) AS 'employes'
FROM employees A
JOIN employees B 
ON A.emp_id = B.emp_superior_id
JOIN shops
ON B.emp_sho_id = sho_id 
WHERE sho_city = 'Compiègne'
ORDER BY employes ASC

-- Fonctions d'agrégation
-- Q11. Quel produit a été vendu avec la remise la plus élevée ? Afficher le montant de la remise, le numéro et le nom du produit, le numéro de commande et de ligne de commande.
SELECT CONCAT ("Il s'agit du produit ",pro_id,"(",cat_name,") ligne de commande ",ode_id,"commande ",ode_ord_id )
FROM categories
JOIN products 
ON categories.cat_id = products.pro_id 
JOIN orders_details
ON products.pro_id = orders_details.ode_pro_id
JOIN orders
ON orders_details.ode_ord_id = orders.ord_id
WHERE ode_discount = (SELECT MAX(ode_discount)
       FROM orders_details)

-- Q13. Combien y-a-t-il de clients canadiens ? Afficher dans une colonne intitulée 'Nb clients Canada'

SELECT CONCAT (COUNT(*)," clients viennent du Canada")
FROM customers
WHERE cus_countries_id="CA"

-- Q16. Afficher le détail des commandes de 2020.

SELECT ode_id,ode_unit_price,ode_discount,ode_quantity,ode_ord_id,ode_pro_id,ord_order_date
FROM orders_details
JOIN orders ON orders_details.ode_ord_id=orders.ord_id
WHERE ord_order_date LIKE '%2020%'

-- Q17. Afficher les coordonnées des fournisseurs pour lesquels des commandes ont été passées.

SELECT s.sup_name,s.sup_address,s.sup_zipcode
FROM suppliers s
WHERE s.sup_id IN(SELECT p.pro_sup_id FROM products p)

-- Q18. Quel est le chiffre d'affaires de 2020 ?

SELECT COUNT (((ode_unit_price * ode_quantity)*1.20 )- ode_discount) as ' Chiffre moyen  '
FROM orders_details
WHERE ode_ord_id = (SELECT ord_id FROM orders WHERE ord_order_date = 2020)

-- bonne reponse

SELECT ROUND(SUM((ode_unit_price-(ode_unit_price*ode_discount/100))*ode_quantity),2) as ' Chiffre moyen  '
FROM orders_details
WHERE ode_ord_id IN(SELECT ord_id FROM orders WHERE YEAR( ord_order_date )= 2020)


-- Q19. Quel est le panier moyen ?

SELECT AVG((od.ode_unit_price-(od.ode_unit_price*od.ode_discount/100))*od.ode_quantity) AS 'moyenne'
FROM orders_details od
GROUP BY od.ode_ord_id

-- Q20. Lister le total de chaque commande par total décroissant (Afficher numéro de commande, date, total et nom du client).





-- Q22. La version 2020 du produit barb004 s'appelle désormais Camper et, bonne nouvelle, son prix subit une baisse de 10%.

SELECT   pro_id,pro_price,pro_price,(pro_price - (pro_price * 10 /100)) AS 'total')
FROM products
where pro_id = 12 


-- Q23. L'inflation en France en 2019 a été de 1,1%, appliquer cette augmentation à la gamme de parasols.

SELECT  pro_id,pro_price,pro_price,(pro_price+(pro_price * 1.1 /100)) AS 'total'
FROM products
JOIN categories
ON products.pro_cat_id = categories.cat_id
WHERE categories.cat_name = 'parasols' 

-- Q24. Supprimer les produits non vendus de la catégorie "Tondeuses électriques". Vous devez utilisez une sous-requête sans indiquer de valeurs de clés.

SELECT products.pro_name 
FROM products
where (SELECT ode_pro_id FROM orders_details 
WHERE products.pro_cat_id IN (SELECT categories.cat_id FROM categories WHERE categories.cat_name = 'Tondeuses électriques') )


delete from products
















