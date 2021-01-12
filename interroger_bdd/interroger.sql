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

SELECT pro_id,pro_name,pro_price
FROM products
ORDER BY pro_price ASC
LIMIT 1

-- Q7. Lister les produits qui n'ont jamais été vendus

select pro_id,pro_ref,pro_name
FROM products
WHERE pro_id BETWEEN 34 AND 42 


