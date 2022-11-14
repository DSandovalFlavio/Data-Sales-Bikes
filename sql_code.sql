-- Creacion de base de datos
CREATE DATABASE db_sales_bikes;
USE db_sales_bikes;

-- Creacion de tablas dimencionales o categoricas

-- ##### PRODUCTOS ###### 
-- sub_categorias
CREATE TABLE sub_categories (
	id_sub_category INT NOT NULL,
    sub_category VARCHAR(255) NOT NULL,
    product_category VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_sub_category)
);
-- productos
CREATE TABLE products (
	id_product	INT NOT NULL,
    product	VARCHAR(255) NOT NULL,
    id_sub_category INT,
    unit_cost INT,
    unit_price INT,
    unit_profit INT,
	PRIMARY KEY (id_product),
    -- definiendo las relaciones
    CONSTRAINT fk_sub_category
    FOREIGN KEY (id_sub_category)
		REFERENCES sub_categories(id_sub_category)
);

-- ##### CLIENTES ###### 
-- age_groups
CREATE TABLE age_groups (
	id_age_group INT NOT NULL,
    age_group VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_age_group)
);
-- clientes
CREATE TABLE customers (
	id_customer	INT NOT NULL,
    first_name	VARCHAR(255) NOT NULL,
    last_name	VARCHAR(255) NOT NULL,
    customer_age	VARCHAR(255) NOT NULL,
    id_age_group INT,
    customer_gender	VARCHAR(255) NOT NULL,
	PRIMARY KEY (id_customer),
    CONSTRAINT fk_age_group
    FOREIGN KEY (id_age_group)
		REFERENCES age_groups(id_age_group)
);


-- ##### WAREHOUSES ###### 
-- country_warehouses
CREATE TABLE country_warehouses (
	id_country_warehouse INT NOT NULL,
    country_warehouse VARCHAR(255) NOT NULL,
    PRIMARY KEY(id_country_warehouse)
);

CREATE TABLE warehouses (
	id_warehouse INT NOT NULL,
    state_warehouse	VARCHAR(255) NOT NULL,
    id_country_warehouse INT,
	PRIMARY KEY (id_warehouse),
    CONSTRAINT fk_country_warehouse
    FOREIGN KEY (id_country_warehouse)
		REFERENCES country_warehouses(id_country_warehouse)
);


-- ##### VENTAS ###### 
CREATE TABLE sales (
	id_sale	INT NOT NULL,
    date_sale DATE,
    id_customer INT,
    id_warehouse INT,
    id_product INT,
    order_quantity INT,
	PRIMARY KEY (id_sale),
    FOREIGN KEY (id_customer)
		REFERENCES customers(ID_Customer),
	FOREIGN KEY (id_warehouse)
		REFERENCES warehouses(id_warehouse),
	FOREIGN KEY (id_product)
		REFERENCES products(id_product)
);
