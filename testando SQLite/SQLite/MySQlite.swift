//
//  MySQlite.swift
//  testando SQLite
//
//  Created by Naville Brasil on 16/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import Foundation

let caminhoParaSandBox = NSHomeDirectory()
let pathDocuments = (caminhoParaSandBox as NSString).appendingPathComponent("Documents")
let pathArquivo = (pathDocuments as NSString).appendingPathComponent("arquivo.sqlite")

var dataBase: OpaquePointer? = nil

@objc protocol MYSQLiteDelegate
{
    @objc optional func registerInsertedSuccessfuly(message: String, error: Bool)
}

class MySQLite
{
    //Properties
    //var arrayData: [[String: Any]] = []
    var arrayData: [SQLiteModel] = []
    
    var delegate: MYSQLiteDelegate?
    
    //MARK: - Create Database
    func createDatabase()
    {
        print(pathArquivo)
        
        //Verifying that the file exists
        if FileManager.default.fileExists(atPath: pathArquivo)
        {
            if sqlite3_open(pathArquivo, &dataBase) == SQLITE_OK
            {
                print("Database is open")
            }
            else
            {
                print("Error on opening Database")
            }
        }
        else
        {
            //If the bank not exist, so create bank
            if sqlite3_open(pathArquivo, &dataBase) == SQLITE_OK
            {
                let command = "create table if not exists DEVROOM (id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT, name TEXT, occupation TEXT, level TEXT, age INTEGER, register INTEGER UNIQUE)"
                
                if sqlite3_exec(dataBase, command, nil, nil, nil) == SQLITE_OK
                {
                    print("Create table is Succefuly")
                }
                else
                {
                    print("Error on creating table: \(sqlite3_errmsg(dataBase))")
                }
            }
            else
            {
                print("Error on create database")
            }
        }
    }
    
    //MARK: - Request
    func request()
    {
        //Query to return records from the table
        let query = "select *from DEVROOM"
        
        //Tying the value generated
        var result: OpaquePointer? = nil
        
        //Method that execute a command in the database and retuns data
        if sqlite3_prepare_v2(dataBase, query, -1, &result, nil) == SQLITE_OK
        {
            //Running through database
            while sqlite3_step(result) == SQLITE_ROW
            {
                //Retrieving columns value
                let id = Int(sqlite3_column_int(result, 0))
                
                let resultName = sqlite3_column_text(result, 1)
                let name = String(cString: resultName!)
                
                let resultOccupation = sqlite3_column_text(result, 2)
                let occupation = String(cString: resultOccupation!)
                
                let resultLevel = sqlite3_column_text(result, 3)
                let level = String(cString: resultLevel!)
                
                let age = Int(sqlite3_column_int(result, 4))
                
                let register = Int(sqlite3_column_int(result, 5))
                
                var dictionary: [String: Any] = [:]
                dictionary["id"] = id as Int
                dictionary["name"] = name as String
                dictionary["occupation"] = occupation as String
                dictionary["level"] = level as String
                dictionary["age"] = age as Int
                dictionary["register"] = register as Int
                
                //self.arrayData.append(dictionary)
                
                self.arrayData.append(SQLiteModel(name: name, occupation: occupation, level: level, age: age, register: register))
                
                
            }
            sqlite3_finalize(result!)
            
            print("Recoverd ok")
            
        }
        else
        {
            print("Error in the return data:", sqlite3_errmsg(dataBase))
        }
    }
    
    //MARK: - Adding Data in the database
    func insert(name: String, occupation: String, level: String, age: Int, register: Int)
    {
        let query = "insert into DEVROOM values (NULL, '\(name)', '\(occupation)', '\(level)', \(age), \(register))"
        
        var msg = ""
        
        if sqlite3_exec(dataBase, query, nil, nil, nil) == SQLITE_OK
        {
            msg = "Coloaborador\(name), que ocupará o cargo de \(occupation), (\(level)), tem \(age) anos de idade, o número de seu registro será \(register). Agora \(name) faz parte da equipe ☺️"
            
            print("\(name), \(occupation), \(level), \(age) has been added successfuly")
            
            self.delegate?.registerInsertedSuccessfuly!(message: msg, error: false)
        }
        else
        {
            self.delegate?.registerInsertedSuccessfuly!(message: "Verifique se o número de registro já existe.", error: true)
            
            print("Error adding values:", sqlite3_errmsg(dataBase))
        }
    }
    
    //MARK: - Delete data
    func delete(register: Int)
    {
        let query = "DELETE FROM DEVROOM WHERE register = \(register)"
        
        if sqlite3_exec(dataBase, query, nil, nil, nil) == SQLITE_OK
        {
            print("The file has been deleted")
        }
        else
        {
            print("Error to delete file")
        }
    }
    
}

