DROP DATABASE IF EXISTS oto;

CREATE DATABASE oto; 

USE oto; 

 

CREATE TABLE employes (
  emp_id int (10) NOT NULL AUTO_INCREMENT,
  emp_nom varchar (255) NOT NULL ,
  emp_prenom varchar (255) NOT NULL ,
  emp_adresse varchar (255) NOT NULL ,
  emp_telephone int (10) NOT NULL ,
  emp_mail varchar (255) NOT NULL ,
  PRIMARY KEY (emp_id)
  );

  CREATE TABLE facture (
      fac_id int (10) NOT NULL AUTO_INCREMENT,
      fact_modalite varchar (255) NOT NULL ,
      PRIMARY KEY (fac_id),
      FOREIGN KEY (fac_id) REFERENCES employes (emp_id)

  );

  CREATE TABLE atelier (
      ate_id int NOT NULL AUTO_INCREMENT,
      ate_intervention varchar (255) NOT NULL,
      ate_description varchar (255) NOT NULL,
      PRIMARY KEY (ate_id),
      FOREIGN KEY (ate_id) REFERENCES employes (emp_id)
  );

  CREATE TABLE clients (
      cli_id int (10) NOT NULL AUTO_INCREMENT,
      cli_nom varchar (255) NOT NULL,
      cli_prenom varchar (255) NOT NULL,
      cli_adresse varchar (255) NOT NULL,
      cli_telephone int (10) NOT NULL,
      cli_categorie varchar (255) NOT NULL,
      cli_mail varchar (255) NOT NULL,
      cli_marue_vehicule varchar (255) NOT NULL,
      cli_immatriculation int (10) NOT NULL,
      cli_modele varchar (255) NOT NULL,  
      PRIMARY KEY (cli_id),
      FOREIGN KEY (cli_id) REFERENCES facture (fac_id),
      FOREIGN KEY (cli_id) REFERENCES atelier (ate_id)
      
    );



  CREATE TABLE accessoire_option (
      acc_id int (10) NOT NULL AUTO_INCREMENT,
      acc_prix int (10) NOT NULL,
      acc_libelle varchar (255) NOT NULL,
      acc_description varchar (255) NOT NULL ,
      acc_caracteristique varchar (255) NOT NULL,
      PRIMARY KEY (acc_id),
      FOREIGN KEY (acc_id) REFERENCES clients (cli_id),
      FOREIGN KEY (acc_id) REFERENCES employes (emp_id)

  );


  CREATE TABLE vehicule (
      veh_id int NOT NULL AUTO_INCREMENT,
      veh_marque varchar (255) NOT NULL,
      veh_modele varchar (255) NOT NULL,
      veh_immatriculation int (10) UNIQUE,
      veh_kilometrage int (10) NOT NULL,
      veh_etat varchar (255) NOT NULL,
      veh_couleur varchar (255) NOT NULL,
      veh_prix int(10) NOT NULL,
      PRIMARY KEY (veh_id),
      FOREIGN KEY (veh_id) REFERENCES clients (cli_id),
      FOREIGN KEY (veh_id) REFERENCES employes (emp_id)
      
  );



  