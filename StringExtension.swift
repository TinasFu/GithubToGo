//
//  StringExtension.swift
//  GithubToGo
//
//  Created by Shiquan Fu on 10/23/14.
//  Copyright (c) 2014 Tina Fu. All rights reserved.
//

import Foundation

extension String {
    
    func validate() -> Bool {
        
        // "^" means "not" 
        let regex = NSRegularExpression(pattern: "[^0-9a-zA-Z\n]", options: nil, error: nil)
        let match = regex.numberOfMatchesInString(self, options: nil, range: NSRange(location:0, length: countElements(self)))
        print("\(match)")
        if match > 0 {
            return false
        }
        return true
    }
}
