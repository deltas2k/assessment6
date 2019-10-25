//
//  random.swift
//  assessment6
//
//  Created by Matthew O'Connor on 10/25/19.
//  Copyright © 2019 Matthew O'Connor. All rights reserved.
//

import Foundation

class RandomName: Codable {
    let name: String
    
    init(name: String){
        self.name = name
    }
}

extension RandomName: Equatable {
    static func == (lhs: RandomName, rhs: RandomName) -> Bool {
        return lhs.name == rhs.name 
    }
    
    
}
