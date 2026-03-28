#  Python Introduction
- Python is a popular programming language.
- It was created by Guido van Rossum, and released in 1991.
- Python is a cross-platform programming language, which can run on multiple platforms like Windows, macOS, Linux, and has even been ported to the Java and .NET virtual machines.
- It is free and open-source.

# Python Use Case
- __web development__ (server-side) : Python can be used on a server to create web applications.
- __software development__ : Python can be used alongside software to create workflows
- __mathematics__ : Python can be used to handle big data and perform complex mathematics.
- __system scripting__ : Python can connect to database systems. It can also read and modify files.
- Python can be used for rapid prototyping, or for production-ready software development.

# 2. Python print function
- The print() function prints the specified message to the screen, or other standard output device.
- The message can be a string, or any other object, the object will be converted into a string before written to the screen.
- The print statement can be used in the following ways:
```hcl
•	print("Good Morning")
•	print("Good", <Variable Containing the String>)
•	print("Good" + <Variable Containing the String>)
•	print("Good %s" % <variable containing the string>)
```
### 2.1. Quotes Use
- In Python, single, double and triple quotes are used to denote a string.
    - Single quotes when declaring a single character.
    - Double quotes when declaring a line and
    - Triple quotes when declaring a paragraph/multiple lines.
 
- 2.1.1. Example : __Single Quotes__
  ```hcl
  $ vi hello.py
  print('Hello')
  ```
  - Output
  ```hcl
  $ py ./hello.py  OR ./hello.py
  Hello
  ```

- 2.1.2. Example : __Double Quotes__
  ```hcl
  $ vi hello.py
  print("Python is very simple language")
  ```
  - Output
  ```hcl
  $ py ./hello.py  OR ./hello.py
  Python is very simple language
  ```

- 2.1.3. Example : __Triple Quotes__
  ```hcl
  $ vi hello.py
  print("""Python is very popular language.
  It is also friendly language.""")
  ```
  - Output
  ```hcl
  $ py ./hello.py  OR ./hello.py
  Python is very popular language.
  It is also friendly language.
  ```

### 2.2. Variable Use
- Strings can be assigned to variable say string1 and string2 which can call when using the print statement

- 2.2.1. Example : __Single Variable__
  ```hcl
  $ vi var.py
  str1 = 'Wel'
  print(str1,'come')
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Wel come
  ```

- 2.2.2. Example : __Two Variable__
  ```hcl
  $ vi var.py
  str1 = "Welcome"
  str2 = "Python"
  print(str1, str2)
  ```
    - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Welcome Python
  ```

  - 2.2.3. Example : __Multiple Variable__
  ```hcl
  $ vi var.py
  str1 = 'World'
  str2 = ':'
  print("Python %s %s" %(str1,str2))
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Python World :
  ```

### 2.3. String Concatenation:
- String concatenation is the "addition" of two strings.
  ```hcl
  $ vi var.py
  str1 = 'Python'
  str2 = ':'
  print('Welcome' + str1 + str2)
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  WelcomePython:
  ```

- __%s__ is used to refer to a variable which contains a string.
  ```hcl
  $ vi var.py
  str1 = 'Python'
  print("Welcome %s" % str1)
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Welcome Python
  ```

### 2.4. Data types use
- There are following data type that can be use with python.
  - %d -> Integer
  - %e -> exponential
  - %f -> Float
  - %o -> Octal
  - %x -> Hexadecimal

- 2.4.1. Example : __Integer__
  ```hcl
  $ vi var.py
  print("Actual Number = %d" %15)
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Actual Number = 15
  ```

- 2.4.2. Example : __Exponential__
  ```hcl
  $ vi var.py
  print("Exponential equivalent of the number = %e" %15)
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Exponential equivalent of the number = 1.500000e+01
  ```

- 2.4.3. Example : __Float__
  ```hcl
  $ vi var.py
  print("Float of the number = %f" %15)
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Float of the number = 15.000000
  ```

- 2.4.4. Example : __Octal__
- To define an octal number directly in your code, use the prefix 0o (zero and the letter 'o') before the digits
  ```hcl
  $ vi var.py
  octal_example = 0o123
  print(f"Octal literal: {octal_example}")
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  Octal literal: 83
  ```

- 2.4.5. Example : __Hexadecimal__
- Python recognizes numbers with the prefix 0x as hexadecimal integers.
  ```hcl
  $ vi var.py
  hex_literal_1 = 0xAA
  print(f"hex_literal_1: {hex_literal_1}")
  hex_literal_2 = 0xBB
  print(f"hex_literal_2: {hex_literal_2}")
  hex_literal_3 = 0xCC
  print(f"hex_literal_3: {hex_literal_3}")
  hex_literal_4 = 0xDD
  print(f"hex_literal_4: {hex_literal_4}")
  hex_literal_5 = 0xFF
  print(f"hex_literal_5: {hex_literal_5}")
  ```
  - Output
  ```hcl
  $ py ./var.py  OR ./var.py
  hex_literal_1: 170
  hex_literal_2: 187
  hex_literal_3: 204
  hex_literal_4: 221
  hex_literal_5: 255
  ```


  








