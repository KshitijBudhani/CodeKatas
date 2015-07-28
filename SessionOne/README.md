# Initial Problem

Rules:

1. Can be solved in any language 
2. Bring a working runnable solution
3. Style and approach is completely up to the developer.

Given the string:
```
"(id,created,employee(id,firstname,employeeType(id), lastname),location)"
```

Output the following:
```
id
created
employee
- id
- firstname
- employeeType
-- id
- lastname
location
```

# Additional Problem #1
Given the string:
```
"(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))"
```
Output the following:
```
id
created
employee
- id
- firstname
--mid
- employeeType
-- id
- lastname
location
- lat
- lon
```

# Additional Problem #2
Alphabetize both of the original strings.
