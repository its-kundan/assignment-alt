import pandas as pd
import sqlite3
from sqlite3 import Error

def create_connection(db_file):
    """ Create a database connection """
    conn = None
    try:
        conn = sqlite3.connect(db_file)
        print(f"SQLite version: {sqlite3.version}")
        return conn
    except Error as e:
        print(e)
    return conn

def create_tables(conn):
    """ Create tables from CSV files """
    try:
        # Read CSV files
        orders = pd.read_csv('data/customer_orders.csv')
        payments = pd.read_csv('data/payments.csv')
        
        # Write to SQLite
        orders.to_sql('customer_orders', conn, if_exists='replace', index=False)
        payments.to_sql('payments', conn, if_exists='replace', index=False)
        
        print("Tables created successfully")
    except Error as e:
        print(e)

if __name__ == '__main__':
    database = "alt_mobility.db"
    conn = create_connection(database)
    if conn is not None:
        create_tables(conn)
        conn.close()