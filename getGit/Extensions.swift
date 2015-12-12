//
//  Extensions.swift
//  getGit
//
//  Created by Lindsey on 12/11/15.
//  Copyright © 2015 Lindsey Boggio. All rights reserved.
//

import Foundation


extension String{
    
    static func isValidString(stringToCheck: String) ->Bool{
        
        do{
            let regex = try NSRegularExpression(pattern: "[0-9a-zA-Z\\s]", options: NSRegularExpressionOptions.CaseInsensitive)
            let matches = regex.numberOfMatchesInString(stringToCheck, options: NSMatchingOptions.ReportCompletion, range: NSRange.init(location: 0, length: stringToCheck.characters.count))
            
            if matches == stringToCheck.characters.count{
                return true
            }else {
                return false
            }
        } catch {return false}
    }
}
