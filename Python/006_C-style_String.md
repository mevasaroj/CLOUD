# 006. C-style String
  - The most common reference to "C-style" in Python is the printf-style string formatting, which uses the % operator.
  - **Syntax**: "format_string" % (values)
  - Specifiers:
    - **%s**: String.
    - **%d** or **%i**: Integer.
    - **%f**: Floating-point number.
    - **%x**: Hexadecimal (lowercase).
   
#### 06.1. C-Style Structures
 - Python's classes or *collections.namedtuple* can be used to create simple "struct-like" objects that hold data without complex methods.
 - Example
```hcl
class UserStruct:
    def __init__(self, id, name):
        self.id = id
        self.name = name

user = UserStruct(1, "Bob")
print(user.name)
print(user.id)
```

- Output
  ```hcl
  Bob
  1
  ```
