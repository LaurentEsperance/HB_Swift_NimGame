//
//  tool.swift
//  NimGame
//
//  Created by imac on 17/11/2016.
//  Copyright © 2016 laurent. All rights reserved.
//

import Foundation

class Tool{
    
    public static func generateRandomNumber(min:Int, max:Int) -> Int {
        let range = max-min + 1
        return Int(arc4random_uniform(UInt32(range))) + min
    }
    
}
