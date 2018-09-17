CREATE TABLE IF NOT EXISTS my_debezium_test (
  ID int NOT NULL,
  test varchar(255),
  PRIMARY KEY (ID)
);

gINSERT INTO my_debezium_test VALUES(3, "it rox!!");

UPDATE my_debezium_test SET test = "my friend!" WHERE ID = 2;

DELETE FROM my_debezium_test WHERE ID = 1;

