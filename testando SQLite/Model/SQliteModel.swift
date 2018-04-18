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
    private var id: Int
    private var name: String
    private var occupation: String
    private var level: String
    private var age: Int
    private var register: Int
    
    init(name: String, occupation: String, level: String, age: Int, register: Int, id: Int)
    {
        self.id = id
        self.name = name
        self.occupation = occupation
        self.level = level
        self.age = age
        self.register = register
    }
    
    init()
    {
        self.id = 0
        self.name = ""
        self.occupation = ""
        self.level = ""
        self.age = 0
        self.register = 0
    }
    
    public func setId(_ id: Int)
    {
        self.id = id
    }
    public func getId() -> Int
    {
        return self.id
    }
    //
    public func setName(_ name: String)
    {
        self.name = name
    }
    
    public func getName() -> String
    {
        return self.name
    }
    //
    public func setOccupation(_ occupation: String)
    {
        self.occupation = occupation
    }
    
    public func getOccupation() -> String
    {
        return self.occupation
    }
    //
    public func setLevel(_ level: String)
    {
        self.level = level
    }
    
    public func getLevel() -> String
    {
        return self.level
    }
    //
    public func setAge(_ age: Int)
    {
        self.age = age
    }
    
    public func getAge() -> Int
    {
        return self.age
    }
    //
    public func setRegister(_ register: Int)
    {
        self.register = register
    }
    
    public func getRegister() -> Int
    {
        return self.register
    }
    //
}
