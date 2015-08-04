package com.bmcandrews.kata.names;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class DataManipulator {

    private ArrayList<Entry> entries = new ArrayList<Entry>();

    public void setDataFile(String fileName){
        try {
            BufferedReader bufferedReader = new BufferedReader(new FileReader(fileName));
            String line;
            int lineIndex = 0;
            while((line = bufferedReader.readLine()) != null) {
                String[] lineValues = line.split(",");
                if(lineIndex != 0){
                    Entry newEntry = new Entry();
                    newEntry.setYear(Integer.valueOf(lineValues[0]));
                    newEntry.setEthnicity(Entry.ethnicityValueOf(lineValues[1]));
                    newEntry.setName(lineValues[2]);
                    newEntry.setCount(Integer.valueOf(lineValues[3]));
                    entries.add(newEntry);
                }
                lineIndex++;
            }
        } catch (IOException e){
            System.out.println(e);
        }
    }

    public Entry getOccurrences(String name, Entry.Ethnicity ethnicity){
        name = name.toUpperCase();
        for(Entry e : entries){
            if((e.getName().equals(name)) && (e.getEthnicity() == ethnicity)){
                return e;
            }
        }
        return new Entry(0,ethnicity,name,0);
    }

    public ArrayList<Entry> sortDescending(ArrayList<Entry> values){
        ArrayList<Entry> sortedList = new ArrayList<Entry>();
       while(values.size() > 0) {
           Entry lowest = values.get(0);
           for (Entry e : values) {
                if(lowest.getCount()>e.getCount()) {
                    lowest = e;
                }
           }
           sortedList.add(lowest);
           values.remove(lowest);
       }
        return sortedList;
    }

    public ArrayList<Entry> getOccurrencesPerEthnicity(String name){
        ArrayList<Entry> topNames = new ArrayList<Entry>();
        for(Entry.Ethnicity e : Entry.Ethnicity.values()){
            topNames.add((getOccurrences(name, e)));
        }
        topNames = sortDescending(topNames);
        return topNames;
    }

    public ArrayList<Entry> getPopularNames(Entry.Ethnicity ethnicity){
        final int CAPACITY = 5;
        ArrayList<Entry> mostPopular = new ArrayList<Entry>();
        for(Entry e : entries){
            if(e.getEthnicity() == ethnicity) {
                if (mostPopular.size() < CAPACITY) {
                    mostPopular.add(e);
                } else {
                    for (int i = 0; i < CAPACITY; i++) {
                        if (e.getCount() > mostPopular.get(i).getCount()) {
                            mostPopular.set(i, e);
                            i = CAPACITY;
                        }
                    }
                }
            }
        }
        return mostPopular;
    }




}
