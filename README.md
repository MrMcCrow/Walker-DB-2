# Walker-DB-2

This is an SQLite repl for use in school, based upon the 2021-22 SQA Higher assignment.
Various example queries are included, based on the example Sakila movie database, that can be modified to work with the tables here.

main.sql has some boilerplate to add columns, headers etc.
```schema.sql``` creates the tables
```data.sql``` is a simple file to list the various different ```.sql``` ```INSERT``` files
For ease of reading, each table's ```INSERT```s are in their own ```.sql``` file - add more ```.read <filename>.sql``` as need to ```data.sql```
SQLite does not seem to like altering tables once created.
```schema_constraints.sql``` has the SQA instructions on how to add constraints to the database schema.
