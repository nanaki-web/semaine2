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

SELECT emp_superior_id,emp_lastname,emp_firstname
FROM employees

SELECT emp_lastname,emp_firstname
FROM employees

SELECT concat (emp_lastname,' ',emp_firstname)as 'employé' , concat (emp_superior_id,' ',emp_lastname,' ',emp_firstname)AS 'supérieur'
FROM employees

-- Fonctions d'agrégation
-- Q11. Quel produit a été vendu avec la remise la plus élevée ? Afficher le montant de la remise, le numéro et le nom du produit, le numéro de commande et de ligne de commande.

SELECT MAX(ode_discount),ode_pro_id,pro_name,ord_id
FROM orders_details,products,orders




