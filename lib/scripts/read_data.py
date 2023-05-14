import sqlite3

# Connect to the database
conn = sqlite3.connect("foods.db")
c = conn.cursor()

# Query the data
c.execute("SELECT * FROM foods")
rows = c.fetchall()

# Print the data
for row in rows:
    print(row)

# Close the connection
conn.close()

