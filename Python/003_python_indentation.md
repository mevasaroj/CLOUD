
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
 - **Proper Indentation in if-else**
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
 - **Nested Indentation**
 - example 1
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

 - example 2
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

- example 3
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

- **Indentation in Loops**
- Example 1
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

- Example 2
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


- Example 3
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


- Example 4
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

- Example 5
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


- Example 6
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


- Example 7
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


- Example 8
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

### 3.5. Indentation in Conditional Statements
 - The code below demonstrate how we use indentation to define seperate scopes of if-else statements:
```hcl
a =  20
if a >= 18:
    print('18 is Less than or equial to 20...') # Indented 4 spaces
else:
    print('retype the Number.') # Indented 4 spaces
print('All set !') # No indentation - Outside Block
```
 - Output
```hcl
18 is Less than or equial to 20...
All set !
```
 
 ### 3.6. Indentation in Loops
  - Indentation defines the set of statements that are executed repeatedly inside a loop.
  - Code
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

