# dbt_practice
Repository used for practice DBT using Olist dataset.

# Creating a local database
For this project, we will need to create a local database, using psql

```
sudo -u postgres psql

create database olist;

create user myuser with encrypted password 'mypass';

grant all privileges on database olist to myuser;

```

It's important to add your database to you dbt profile

```
code /home/my_path/.dbt/profiles.yml

```
And add

```
dbt_olist:
  target: stg
  outputs:
    stg:
      type: postgres
      host: localhost
      user: myuser
      pass: 'mypass'
      port: 5432
      dbname: olist
      schema: public
      threads: 4

```
After that, you can test if your local database is working by running:

```

dbt debug

```

If its all okay, you can now run 

```

dbt seed

```
And we can start our course. You can find the data used [here](https://www.kaggle.com/olistbr/brazilian-ecommerce)