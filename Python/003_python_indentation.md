
# 3. Python indentation
 - In Python, **indentation** is the leading whitespace (spaces or tabs) at the beginning of a line.
 - Languages like C++ or Java that use curly braces {} to define code blocks, Python uses indentation to specify the structure and scope of the code.
 - Indentation is used to define blocks of code. It indicates to the Python interpreter that a group of statements belongs to the same block.
 - All statements with the same level of indentation are treated as part of the same code block.
 - Indentation is created using tabs or spaces and the commonly accepted convention is to use four spaces.
 - Python expects the indentation level to be consistent within the same block.

### 3.1. Key Rules
 - **Mandatory Syntax**: Indentation is not optional; it is a requirement of the language. Failing to indent or using inconsistent levels will result in an IndentationError.
 - **Block Definition**: All statements within the same code block (e.g., the body of a loop, function, or if statement) must have exactly the same level of indentation.
 - **First Line**: The first line of a Python script cannot be indented.
 - **Minimum Requirement**: An indented block must contain at least one space
 
### 3.2. Best Practices
 - **Basic Indentation Rules**: In Python, each line of code within a block must be indented by the same number of spaces or tabs.
 - **Standard Size**: The official PEP 8 Style Guide recommends using 4 spaces per indentation level.
 - **Spaces over Tabs**: It is highly recommended to use spaces exclusively rather than tabs to ensure consistency across different editors.
 - **No Mixing**: Never mix tabs and spaces in the same file. Modern Python versions (Python 3+) will raise an error if they are mixed.

### 3.3. Common Indentation Errors
 - **Missing Indentation**: Forgetting to indent code blocks can result in a “IndentationError: expected an indented block” error.
 - **Incorrect Indentation Levels**: Using inconsistent or incorrect indentation levels can lead to syntax errors or logical errors in the code.
 - **Mixing Tabs and Spaces in Indentation**: Mixing tabs and spaces can result in an “IndentationError: inconsistent use of tabs and spaces in indentation” error.
   
### 3.4. Python Indentation Examples
#### 3.4.1. Indentation in if-else
```hcl
number =  20
if number > 0:
    print('Positive number') # Indented 4 spaces
else:
    print('Non-positive number') # Indented 4 spaces
```
 - Output
```hcl
Positive number
```
 #### 3.4.2. Nested If-else Indentation
 - **Exampe 1 - Nested If-else Indentation**
```hcl
number = 4                   # No Indendation - Start
if number > 0:               # No Indendation - if Statement
    print("Positive number") # Indented 4 spaces
    if number % 2 == 0:      # Indented 4 spaces
        print("Even number") # Indented 8 spaces
    else:                    # Indented 4 spaces
        print("Odd number")  # Indented 8 spaces
else:                        # No Indendation
    print("Negative Number") # Indented 4 spaces
```
 - output
```hcl
Positive number
Even number
```

 - **Exampe 2 - Nested If-else Indentation**
```hcl
number = 7
if number > 0:
    print("Positive number")
    if number % 2 == 0:
        print("Even number")
    else:
        print("Odd number")
else:
    print("Negative Number")
```
 - output
```hcl
Positive number
Odd number
```

 - **Exampe 3 - Nested If-else Indentation**
```hcl
number = -10
if number > 0:
    print("Positive number")
    if number % 2 == 0:
        print("Even number")
    else:
        print("Odd number")
else:
    print("Negative Number")
```
 - output
```hcl
Negative Number
```

#### 3.4.3. Indentation in for Loops
 - **Exampe 1 - for Loop Indentation**
```hcl
for i in range(1):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
print("Loop finished")            # Not indented: outside the loop
```
- Output
```hcl
Outer Loop: 0
Loop finished
```

 - **Exampe 2 - for Loop Indentation**
```hcl
for i in range(2):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
print("Loop finished")            # Not indented: outside the loop
```
- Output
```hcl
Outer Loop: 0
Outer Loop: 1
Loop finished
```


 - **Exampe 3 - for Loop Indentation**
```hcl
for i in range(2):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
print("Loop finished")            # Not indented: outside the loop
```
- Output
```hcl
Outer Loop: 0
Outer Loop: 1
Outer Loop: 2
Loop finished
```

#### 3.4.4. Indentation in Nested for Loops
- **Exampe 1 - Nested for Loop Indentation**
```hcl
for i in range(1):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
    for j in range(1):            # Indented: Nested loop
        print(f"Inner Loop: {j}") # Indented: part of Nested loop
    print("Back to Outer Loop")   # Indented: part of the loop
print("Loop finished")     # Not indented: outside the loop
```
 - Output
```hcl
Outer Loop: 0
Inner Loop: 0
Back to Outer Loop
Loop finished
```

- **Exampe 2 - Nested for Loop Indentation**
```hcl
for i in range(2):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
    for j in range(1):            # Indented: Nested loop
        print(f"Inner Loop: {j}") # Indented: part of Nested loop
    print("Back to Outer Loop")   # Indented: part of the loop
print("Loop finished")     # Not indented: outside the loop
```
 - output
```hcl
Outer Loop: 0
Inner Loop: 0
Back to Outer Loop
Outer Loop: 1
Inner Loop: 0
Back to Outer Loop
Loop finished
```

- **Exampe 3 - Nested for Loop Indentation**
```hcl
for i in range(2):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
    for j in range(2):            # Indented: Nested loop
        print(f"Inner Loop: {j}") # Indented: part of Nested loop
    print("Back to Outer Loop")   # Indented: part of the loop
print("Loop finished")     # Not indented: outside the loop
```
 - output
```hcl
Outer Loop: 0
Inner Loop: 0
Inner Loop: 1
Back to Outer Loop
Outer Loop: 1
Inner Loop: 0
Inner Loop: 1
Back to Outer Loop
Loop finished
```

- **Exampe 4 - Nested for Loop Indentation**
```hcl
for i in range(3):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
    for j in range(1):            # Indented: Nested loop
        print(f"Inner Loop: {j}") # Indented: part of Nested loop
    print("Back to Outer Loop")   # Indented: part of the loop
print("Loop finished")     # Not indented: outside the loop
```
 - output
```hcl
Outer Loop: 0
Inner Loop: 0
Back to Outer Loop
Outer Loop: 1
Inner Loop: 0
Back to Outer Loop
Outer Loop: 2
Inner Loop: 0
Back to Outer Loop
Loop finished
```

- **Exampe 5 - Nested for Loop Indentation**
```hcl
for i in range(3):                # No Indendation - Start of loop
    print(f"Outer Loop: {i}")     # Indented: part of the loop
    for j in range(2):            # Indented: Nested loop
        print(f"Inner Loop: {j}") # Indented: part of Nested loop
    print("Back to Outer Loop")   # Indented: part of the loop
print("Loop finished")     # Not indented: outside the loop
```
 - output
```hcl
Outer Loop: 0
Inner Loop: 0
Inner Loop: 1
Back to Outer Loop
Outer Loop: 1
Inner Loop: 0
Inner Loop: 1
Back to Outer Loop
Outer Loop: 2
Inner Loop: 0
Inner Loop: 1
Back to Outer Loop
Loop finished
```

#### 3.4.5. Indentation in while Loops
- In Python, a while loop repeatedly executes a block of code as long as a specified condition evaluates to *True*
- If the condition never becomes False, the loop will run forever.
- **Exampe 1 - while Loop Indentation**
```hcl
j = 1
while(j<= 5): 
    print(j)  # Indented 4 spaces
    j = j + 1 # Indented 4 spaces
```
  - Output
```hcl
1
2
3
4
5
```

- **Exampe 2 - while Loop Indentation with break**
```hcl
i = 1
while i < 10:
    if i == 4:
        break  # Stops the loop when i is 4
    print(i)
    i += 1
```
  - Output
```hcl
1
2
3
```

- **Exampe 3 - while Loop Indentation with continue**
```hcl
i = 0
while i < 5:
    i += 1
    if i == 3:
        continue  # Skips the rest of the code when i is 3
    print(i)
```
  - Output
```hcl
1
2
3
4
5
```

- **Exampe 4 - while Loop Indentation - User Input Validation**
```hcl
password = ""
while password != "secret":
    password = input("Enter the correct password: ") # Only Secret word accepted - otherwise will repeat asking password

print("Access Granted!")
```
  - Output
```hcl
Enter the correct password: secret
Access Granted!
OR
Enter the correct password: password
Enter the correct password: 
```

- **Exampe 5 - while Loop Indentation - User Input Validation**
```hcl
# Print numbers until the user enters 0
number = int(input('Enter a number: '))

# iterate until the user enters 0
while number != 0:
    print(f'You entered {number}.')
    number = int(input('Enter a number: '))

print('The end.')
```
  - Output
```hcl
Enter a number: 4
You entered 4.
Enter a number: 1
You entered 1.
Enter a number: 7
You entered 7.
Enter a number: 0
The end.
```

- **Exampe 6 - while Loop Indentation - with else statement**
```hcl
count = 0
while count < 3:
    print(count)
    count += 1
else:
    print("Loop completed naturally!")
```
  - Output
```hcl
0
1
2
Loop completed naturally!
```


#### 3.4.6. Indentation in Function

- **Exampe 1 - Function Indentation**
```hcl
def add_numbers(a, b):
    result = a + b
    print(f"Sum of {a} and {b} is {result}")
    return result

add_numbers(3, 4)
```

- Output
```hcl
Sum of 3 and 4 is 7
```


#### 3.4.6. Indentation in Class Definitions
```hcl
class MyClass:
    def __init__(self, name):
        self.name = name

    def greet(self):
        print(f"Hello, {self.name}!")

obj = MyClass("Python")
obj.greet()
```
- Output
```hcl
Hello, Python!
```
