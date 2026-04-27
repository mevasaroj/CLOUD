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


### 4.3. Assignment Techniques

##### 4.3.1. **Multiple Assignment**
 - Python can assign values to multiple variables in one line.
 - Exampe
```hcl
x, y, z = "Orange", "Banana", "Cherry"
print(x)
print(y)
print(z)
```
 - output
```hcl
Orange
Banana
Cherry
```

##### 4.3.2. Chained Assignment
 - Python can assign the same value to multiple variables
 - Exampe
```hcl
x = y = z = "Orange"
print(x)
print(y)
print(z)
```
 - output
```hcl
Orange
Orange
Orange
```

##### 4.3.3. Casting
 - You can explicitly specify the data type of a variable using casting functions like *str()*, *int()*, or *float()*.
 - Example
```hcl
age_str = input("Enter your age: ") 
age_int = int(age_str)  # Cast to integer for math
print(f"Next year, you will be {age_int + 1} years old.")
```
- Output
```hcl
Enter your age: 21
Next year, you will be 22 years old.
```

### 4.4. Variable Scope
##### 4.4.1. Local Variables
 - Defined inside a function and accessible only within that function.
    - Example
      ```hcl
      def my_func():
          local_var = "I'm local"
          print(local_var)
      my_func()
      ```      
    - Output
      ```hcl
      I'm local
      ```
      
 ##### 4.4.2. Global Variables
  - Defined outside of any function and accessible throughout the entire program. Use the *global* keyword to modify a global variable inside a function.
    - Example
      ```hcl
      global_var = "I'm global"
      def my_func():
          print(global_var)  # Accessible here
      my_func()
      ```      
    - Output
      ```hcl
      I'm global
      ```
