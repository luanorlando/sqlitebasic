//
//  SQliteModel.swift
//  testando SQLite
//
//  Created by Naville Brasil on 16/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import Foundation
import UIKit

class SQLiteModel
{
    var name: String
    var occupation: String
    var level: String
    var age: Int
    var register: Int
    
    init(name: String, occupation: String, level: String, age: Int, register: Int)
    {
        self.name = name
        self.occupation = occupation
        self.level = level
        self.age = age
        self.register = register
    }
    
    init()
    {
        self.name = ""
        self.occupation = ""
        self.level = ""
        self.age = 0
        self.register = 0
    }
}
