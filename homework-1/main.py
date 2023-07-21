"""Скрипт для заполнения данными таблиц в БД Postgres."""
import os
import csv
import psycopg2

#conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='Vidineeva')
#cur = conn.cursor()
#employees_data1.csv
#customers_data1.csv

with open(f'{os.path.dirname(os.path.realpath(__file__))}/employees_data1.csv', newline='',
          encoding='utf-8') as csvfile:
    file_reader = csv.reader(csvfile, delimiter=",")
    # file_reader=csv.DictReader(csvfile)
    data_csv = []
    total = 0
    count=0
    for row in file_reader:
        #print(row)
        if total == 0:
            for i in row:
                count+=1

        else:
            data_csv.append(tuple(row))
            # pass
            #print(data_csv)
        total += 1

conn = psycopg2.connect(host='localhost', database='north', user='postgres', password='Vidineeva')
cur = conn.cursor()
if count==3:
    cur.executemany("INSERT INTO customers VALUES(%s,%s,%s)", data_csv)
    cur.execute("SELECT * FROM customers ")
if count==6:
    cur.executemany("INSERT INTO employees VALUES(%s,%s,%s,%s,%s,%s)", data_csv)
    cur.execute("SELECT * FROM employees ")

rows=cur.fetchall()
for i in rows:
    pass
    print(i)

cur.close()
conn.close()







# conn=psycopg2.connect(host='localhost',database='north',user='postgres',password='Vidineeva')
# cur=conn.cursor()
