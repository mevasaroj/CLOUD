number = int(input('Enter a number - which table want to see:'))
for table in range(1, 11):
    print(f" {number} * {table} = {number * table}")
