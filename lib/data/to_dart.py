import csv

with open('csv/vegetables.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    fruits = []
    for row in csv_reader:
        name, description, calories, portion = row
        fruits.append(f"Food(name: '{name}', description: '{description}', calories: {calories}, portions: {portion},),")

with open('vegetables.dart', 'w') as dart_file:
    dart_file.write('List<Food> vegetables = [\n')
    for fruit in fruits:
        dart_file.write(f'  {fruit}\n')
    dart_file.write('];\n')
