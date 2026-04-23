# 4. Python variable
 - In Python, variables are symbolic names that act as references to objects stored in memory.

### 4.1. Key Concepts
 - **Dynamic Typing**: Python is dynamically typed, meaning the same variable can hold different data types (e.g., an integer, then a string) during program execution.
 - **Case Sensitivity**: Variable names are case-sensitive. For example, age, Age, and AGE are three distinct variables.

### 4.2. Rules for Naming Variables
 - Must start with a letter or an underscore (_).
 - Cannot start with a number.
 - Can only contain alphanumeric characters and underscores (A-z, 0-9, and _).
 - Cannot be a Python keyword such as *if*, *else*, or *while*.

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
