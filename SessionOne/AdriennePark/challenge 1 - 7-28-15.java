class Untitled {
	public static void main(String[] args) {
		String sample = "(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))";
		sample = sample.replaceAll(" ", "");
		
		String[] stringArray = sample.split("(?<!^)(?=[,()])");
		int hyphenCount = -1;
		String hyphen = "";
		String finalString = "";

		for (String item : stringArray) {			
			if (item.startsWith("(")) {
				hyphenCount++;
				hyphen = updateHyphenString(hyphenCount);
			} else if (item.endsWith(")")) {
				hyphenCount--;
				hyphen = updateHyphenString(hyphenCount);
			}
			
			finalString = hyphen + item.replaceAll("[(),]", "");
			
			if (!finalString.equals("-") && !finalString.equals(")") && !finalString.equals("")) {
				System.out.println(finalString);
			}
		}
	}
	
	private static String updateHyphenString(int iterations) {
		String hyphenString = "";
		for (int count = 0; count < iterations; count++) {
			hyphenString += "-";
		}
		return hyphenString;
	}
}