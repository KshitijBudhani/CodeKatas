string = '(id,created,employee(id,firstname,employeeType(id), lastname),location)'

def cleanUpString(string):
	string = string.replace("'", "")
	string = string.replace("(", " ")
	string = string.replace(")", "")
	return string

def outputEmployeeType(value):
	print(
		"- " + value[0] + "\n"
		+ "-- " + value[1]
	)

def outputEmployeeId(value):
	print(value[0] + "\n" 
		+ "- " + value[1]
	)

def buildEmployeeOutputForValue(value):
	if value.find("employee") != -1:
		value = value.split(" ")
		if value[0].find("Type") != -1:
			outputEmployeeType(value)
		else:
			outputEmployeeId(value)
 	else:
 		print('- ' + value.replace(" ", ""))

def iterateEmployeeDetailsArray(employeeDetailsArray):
	length = len(employeeDetailsArray)
	for i, value in enumerate(employeeDetailsArray):
		if (i > 1 and i < length - 1):
			buildEmployeeOutputForValue(value)
	 	else:
	 		print(value.replace(" ", ""))

def createEmployeeEntry():
	employeeString = cleanUpString(string)
	employeeDetailsArray = employeeString.split(",")
	return iterateEmployeeDetailsArray(employeeDetailsArray)

createEmployeeEntry()

