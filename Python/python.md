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



