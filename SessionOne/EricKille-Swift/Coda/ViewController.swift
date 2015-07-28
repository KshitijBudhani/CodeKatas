//
//  ViewController.swift
//  Coda
//
//  Created by Eric Kille on 7/28/15.
//  Copyright (c) 2015 Tonic Design. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    func indexOfCharInString(char: Character, inString:String) -> String.Index?  {
        for index in indices(inString) {
            if inString[index] == char {
                return index
            }
        }
        return nil
    }
    
    func indexOfCharInStringFromBack(char: Character, inString:String) -> String.Index?  {
        for index in 1...count(inString) {
            let i = advance(inString.endIndex, index*(-1))
            if inString[i] == char {
                return i
            }
        }
        return nil
    }
    
    func printPrefix(level:Int) -> String {
        var prefix = ""
        if level > 0  {
            for _ in 1...level {
                prefix += "\t"
            }
            for _ in 1...level {
                prefix += "-"
            }
        }
        return prefix
    }
    
    func printParts(strings: [String], level:Int) {
        for string in strings {
            if !string.isEmpty  {
                println(printPrefix(level) + string)
            }
        }
    }
    
    func parseString(input: String, level:Int)  {
        var cleaned = input.substringWithRange(Range<String.Index>(start: advance(input.startIndex, 1), end: advance(input.endIndex, -1)))
        if let leftIndex = indexOfCharInString("(", inString: cleaned), rightIndex = indexOfCharInStringFromBack(")", inString: cleaned) {
            let left = cleaned.substringWithRange(Range<String.Index>(start: cleaned.startIndex, end: leftIndex))
            var leftParts = myComponentsSeparatedByString(left, token: ",")
            printParts(leftParts, level: level)
            
            let center = cleaned.substringWithRange(Range<String.Index>(start: leftIndex, end: advance(rightIndex,1)))
            let right = cleaned.substringWithRange(Range<String.Index>(start: advance(rightIndex,1), end: cleaned.endIndex))
            var rightParts = myComponentsSeparatedByString(right, token: ",")
            
            cleaned.removeRange(Range<String.Index>(start: leftIndex, end: advance(rightIndex,1)))
            parseString(center, level: level+1)
            printParts(rightParts, level: level)
        } else {
            var parts = myComponentsSeparatedByString(cleaned, token:",")
            printParts(parts, level: level)
        }
    }
    
    func myComponentsSeparatedByString(str1: String, token: String) -> [String] {
        var comps = str1.componentsSeparatedByString(token)
        for (i,each) in enumerate(comps) {
            if each.isEmpty {
                comps.removeAtIndex(i)
            }
        }
        return comps
    }
    
    // (id,created,employee(id,firstname,employeeType(id), lastname),location)
    //id
    //created
    //employee
    //    - id
    //    - firstname
    //    - employeeType
    //    -- id
    //    - lastname
    //location
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var level = 0
        var str = "(id,created,employee(id,firstname,employeeType(id), lastname),location)"
        //var str2 = "(id,created,employee(id,firstname(mid),employeeType(id), lastname),location(lat,lon))"
        parseString(str, level: level)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

