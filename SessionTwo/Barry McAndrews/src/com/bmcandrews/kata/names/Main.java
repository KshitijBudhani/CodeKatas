package com.bmcandrews.kata.names;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;

public class Main {

    public static void main(String[] args) {
        DataManipulator dataManipulator = new DataManipulator();

        System.out.println("Please enter the path to the baby names data file:");
        dataManipulator.setDataFile(getInput());

        System.out.println("Enter Name:");
        printEntryList(dataManipulator.getOccurrencesPerEthnicity(getInput()));

        System.out.println("Enter Ethnicity:");
        printEntryList(dataManipulator.getPopularNames(Entry.ethnicityValueOf(getInput())));
    }

    public static String getInput(){
        BufferedReader reader = new BufferedReader(new InputStreamReader(System.in));
        try{
            return reader.readLine();
        } catch (IOException e) {
            return getInput();
        }
    }

    public static void printEntryList(ArrayList<Entry> list){
        System.out.println("Results:");
        String format = "%-30s%-30s%-30s%-30s%n";
        System.out.format(format,"Year","Ethnicity","Name","Usages");
        for(Entry e : list){
            System.out.format(format, e.getYear(), e.getEthnicity(), e.getName(), e.getCount());
        }
    }


}
