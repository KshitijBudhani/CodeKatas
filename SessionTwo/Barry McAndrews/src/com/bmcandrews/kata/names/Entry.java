package com.bmcandrews.kata.names;

public class Entry {
    private int year;
    private Ethnicity ethnicity;
    private String name;
    private int count;

    public enum Ethnicity{
        ASIAN_AND_PACIFIC_ISLANDER,
        BLACK_NON_HISPANIC,
        HISPANIC,
        WHITE_NON_HISPANIC
    }

    public Entry(){

    }

    public Entry(int year, Ethnicity ethnicity, String name, int count) {
        this.year = year;
        this.ethnicity = ethnicity;
        this.name = name;
        this.count = count;
    }

    @Override
    public String toString() {
        return "Entry(" + year + "," + ethnicity + "," + name + "," + count + ")";
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public Ethnicity getEthnicity() {
        return ethnicity;
    }

    public void setEthnicity(Ethnicity ethnicity) {
        this.ethnicity = ethnicity;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public static Ethnicity ethnicityValueOf(String input) {
        input = input.toUpperCase();
        if (input.equals("ASIAN AND PACIFIC ISLANDER")) {
            return Ethnicity.ASIAN_AND_PACIFIC_ISLANDER;
        } else if (input.equals("BLACK NON HISPANIC")) {
            return Ethnicity.BLACK_NON_HISPANIC;
        } else if (input.equals("HISPANIC")) {
            return Ethnicity.HISPANIC;
        } else if (input.equals("WHITE NON HISPANIC")) {
            return Ethnicity.WHITE_NON_HISPANIC;
        } else {
            return null;
        }
    }
}
