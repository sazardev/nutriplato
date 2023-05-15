import csv
import sqlite3

class Food:
    def __init__(self, name, description, calories, quantity):
        self.name = name
        self.description = description
        self.calories = calories
        self.quantity = quantity

    def __str__(self):
        return f"Food(name={self.name}, description={self.description}, calories={self.calories}, quantity={self.quantity})"


animal = []
cereales = []
fruits = []
leguminosas = []
vegetables = []

# Read the data from the CSV file
with open("csv/fruits.csv", "r") as f:
    reader = csv.reader(f)
    next(reader)  # Skip the header row
    for row in reader:
        name, description, calories, quantity = row
        food = Food(name, description, float(calories), float(quantity))
        fruits.append(food)

# Connect to the database
conn = sqlite3.connect("foods.db")
c = conn.cursor()

# Create the table
c.execute("""
CREATE TABLE IF NOT EXISTS fruits (
    id INTEGER PRIMARY KEY,
    name TEXT,
    description TEXT,
    calories REAL,
    quantity REAL
)
""")

# Insert the data
for food in fruits:
    c.execute("INSERT INTO fruits (name, description, calories, quantity) VALUES (?, ?, ?, ?)",
              (food.name, food.description, food.calories, food.quantity))

# Commit the changes and close the connection
conn.commit()
conn.close()
