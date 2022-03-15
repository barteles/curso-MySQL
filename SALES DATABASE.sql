create  table sales
(
	purchase_id INT NOT NULL primary key auto_increment,
    date_of_purchase DATE Not NULL,
    customer_id INT,
    item_code VARCHAR(10) noT null
    );