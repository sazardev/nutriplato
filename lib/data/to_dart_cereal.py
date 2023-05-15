import csv

with open('csv/cereales.csv', 'r') as csv_file:
    csv_reader = csv.reader(csv_file)
    fruits = []
    for row in csv_reader:
        name, description, calories, portion = row
        portion_num = portion.split()[0]
        is_cup = 'taza' in portion
        fruits.append(f"Food(name: '{name}', description: '{description}', calories: {calories}, portions: {portion_num}, isCup: {str(is_cup).lower()},),")

with open('cereales.dart', 'w') as dart_file:
    dart_file.write('List<Food> cereales = [\n')
    for fruit in fruits:
        dart_file.write(f'  {fruit}\n')
    dart_file.write('];\n')
