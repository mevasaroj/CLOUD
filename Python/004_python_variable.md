# 4. Python variable
 - In Python, variables are symbolic names that act as references to objects stored in memory.

- **Exampe 1 - variable**
```hcl
x = 5
name = "Samantha"  
print(x)
print(name)
```
 - output
```hcl
5
Samantha
```

- **Exampe 2 - variable**
```hcl
x = 5
name = "Samantha"  
print(x, name)
```
 - output
```hcl
5 Samantha
```

### 4.1. Rules for Naming Variables
 - Must start with a letter or an underscore (_).
 - Cannot start with a number.
 - Can only contain alphanumeric characters and underscores (A-z, 0-9, and _).
 - Cannot be a Python keyword such as *if*, *else*, or *while*.

##### 4.1.1. Below listed variable names are valid
```hcl
age = 21
_colour = "lilac"
total_score = 90
```

##### 4.1.2. Below listed variables names are invalid
```hcl
1name = "Error"  # Starts with a digit
class = 10       # 'class' is a reserved keyword
user-name = "Doe"  # Contains a hyphen
```

### 4.2. Key Concepts
##### 4.2.1. **Dynamic Typing**: Python is dynamically typed, meaning the same variable can hold different data types (e.g., an integer, then a string) during program execution.
 - Example
   ```hcl
   x = 10
   x = "Now a string"
   ```
 - Output
   ```hcl
   Now a string
   ```
##### 4.2.2. *Case Sensitivity*: Variable names are case-sensitive. For example, age, Age, and AGE are three distinct variables.
- **Exampe - case sensitivity**
```hcl
a = 4
A = "Sally"
print (a, A)
```
 - output
```hcl
4 Sally
```

### 4.3. Common Variable Types
 - **Integers (int)**: Whole numbers (e.g., x = 5).
 - **Floating-point (float)**: Decimal numbers (e.g., y = 2.5).
 - **Strings (str)**: Text wrapped in single or double quotes (e.g., name = "Ram").
 - **Booleans (bool)**: Logical values *True* or *False*.

### 4.4. Assignment Techniques
 - **Multiple Assignment**: You can assign values to multiple variables in one line: *x, y, z = 1, 2, 3*
 - **Chained Assignment**: You can assign the same value to multiple variables: *x = y = z = 10*
 - **Casting**: You can explicitly specify the data type of a variable using casting functions like *str()*, *int()*, or *float()*.

### 4.5. Variable Scope
 - **Local Variables**: Defined inside a function and accessible only within that function.
 - **Global Variables**: Defined outside of any function and accessible throughout the entire program. Use the *global* keyword to modify a global variable inside a function.
 - 
