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

### 4.3. Data Types
##### 4.3.1. Numeric Types
 - **int**: Whole numbers without decimals (e.g. *age = 25*).
 - **float**: Real numbers with decimal points or scientific notation (e.g. *price = 19.99* OR *value = 2e3*).
 - **complex**: Numbers with real and imaginary parts (e.g., 1 + 2j).

##### 4.3.2. Text Type
 - **str**: A sequence of Unicode characters enclosed in single or double quotes
    - (e.g. *name = "Ram"* OR  *surname = 'Raghuvanshi')

##### 4.3.3. Sequence Types
 - **list**: An ordered, mutable (changeable) collection (e.g., [1, "apple", 3.5]).
    - Example: *fruits = ["apple", "banana", "cherry"]*
      
 - **tuple**: An ordered, immutable (unchangeable) collection (e.g., (10, 20)).
    - Example: *coordinates = (10, 20)*
      
 - **range**: Represents a sequence of numbers, commonly used in loops.

##### 4.3.4. Mapping Type
 - **dict**: Stores data in key-value pairs (e.g., *{"name": "Alice", "age": 25}*).
    - Example - *student = {"id": 1, "name": "Bob"}*

##### 4.3.5. Set Types
 - **set**: An unordered collection of unique items.
    - Example: *unique_ids = {101, 102, 103}*
      
 - **frozenset**: An immutable version of a set.

##### 4.3.6. Boolean Type
 - **bool**: Represents truth values, either *True* or *False*.
     - Example: *is_active = True*

##### 4.3.7. Binary Types
 - *bytes*, *bytearray*, and *memoryview* for handling raw binary data.





### 4.4. Assignment Techniques
 - **Multiple Assignment**: You can assign values to multiple variables in one line: *x, y, z = 1, 2, 3*
 - **Chained Assignment**: You can assign the same value to multiple variables: *x = y = z = 10*
 - **Casting**: You can explicitly specify the data type of a variable using casting functions like *str()*, *int()*, or *float()*.

### 4.5. Variable Scope
 - **Local Variables**: Defined inside a function and accessible only within that function.
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
      
 - **Global Variables**: Defined outside of any function and accessible throughout the entire program. Use the *global* keyword to modify a global variable inside a function.
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
