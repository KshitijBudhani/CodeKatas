class employeeInfo {
	public static void main(String[] args) {
		String employeeData = "(id,created,employee(id,firstname,employeeType(id), lastname),location)";
		
		String employeeDataCrop = employeeData.substring(1, employeeData.length() -1);
		
		String commaSeparatedEmployeeData = employeeDataCrop.replace('(', ',').replace(')', ',').replace(",,", ",").replaceAll("\\s","");
      	String[] employeeDetails = commaSeparatedEmployeeData.split(",");

		System.out.println(employeeDetails[0]);
		System.out.println(employeeDetails[1]);
		System.out.println(employeeDetails[2]);
		System.out.println("- " + employeeDetails[3]);
		System.out.println("-- " + employeeDetails[4]);
		System.out.println("- " + employeeDetails[5]);
		System.out.println("-- " + employeeDetails[6]);
		System.out.println("- " + employeeDetails[7]);
		System.out.println(employeeDetails[8]);
	}
}