CREATE TABLE my_debezium_test {
  ID int NOT NULL,
  test varchar(255),
  CONSTRAINT PK_Person PRIMARY KEY (ID)
};

INSERT INTO my_debezium_test VALUES(1, 'hello!');
INSERT INTO my_debezium_test VALUES(2, 'world!');
INSERT INTO my_debezium_test VALUES(3, 'it rox!!');

UPDATE my_debezium_test SET test = 'my friend!' WHERE ID = 2;

DELETE FROM my_debezium_test WHERE ID = 1;

