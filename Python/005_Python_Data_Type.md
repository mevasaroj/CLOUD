
# 5 Python Data Types
 - In Python, the data type is set when you assign a value to a variable:
| Example	Data | Type | 
|:---------------------|:---------:|
|x = "Hello World"|str|
|x = 20|int|
|x = 20.5	|float|
|x = 1j	| complex|
|x = ["apple", "banana", "cherry"]	|list|
|x = ("apple", "banana", "cherry")	| tuple|
|x = range(6)	 | range |
|x = {"name" : "John", "age" : 36}	| dict |
|x = {"apple", "banana", "cherry"} |	set|
|x = frozenset({"apple", "banana", "cherry"})	| frozenset|
|x = True	| bool |
|x = b"Hello"	| bytes |
|x = bytearray(5)	| bytearray |
|x = memoryview(bytes(5))	| memoryview|
|:---------------------|:---------:|


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


