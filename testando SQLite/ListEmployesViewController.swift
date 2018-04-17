//
//  ListEmployesViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 16/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class ListEmployesViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    //var array: [[String:Any]] = []
    var array: [SQLiteModel] = []
    
    let database = MySQLite()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.database.createDatabase()
        //self.database.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        
        self.database.arrayData.removeAll()
        self.database.request()
        self.array = database.arrayData
        self.tableView.reloadData()
        print(self.array)
        
    }

}

////MARK: - MYSQLiteDelegate
//extension ListEmployesViewController: MYSQLiteDelegate
//{
//    func recoveredData(array: [SQLiteModel])
//    {
//        self.array.removeAll()
//        self.array = array
//        self.tableView.reloadData()
//    }
//    
//}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension ListEmployesViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let label = UILabel(frame: CGRect(x: 0, y: self.view.center.y, width: self.tableView.frame.size.width, height: self.tableView.frame.size.height))
        
        if self.array.count < 1
        {
            
            label.textAlignment = .center
            label.text = "Não há Colaboradores"
            label.textColor = #colorLiteral(red: 0.4823529412, green: 0.4823529412, blue: 0.4823529412, alpha: 1)
            
            
            self.tableView.backgroundColor = #colorLiteral(red: 0.9098039216, green: 0.9098039216, blue: 0.9098039216, alpha: 1)
            self.tableView.separatorStyle = .none
            
            self.tableView.backgroundView = label
        }
        else
        {
            label.text = ""
            self.tableView.backgroundView = label
        }
        
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
//        if let name = self.array[indexPath.row]["name"] as? String
//        {
//            cell.textLabel?.text = name
//        }
        
        cell.textLabel?.text = self.array[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
//    {
//        let delete = UITableViewRowAction(style: .destructive, title: "Deletar") { (action, index) in
//
//            self.database.delete(register: self.array[indexPath.row].register)
//            self.tableView.deleteRows(at: [indexPath], with: .automatic)
//
//        }
//
//        return [delete]
//    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            self.database.delete(register: self.array[indexPath.row].register)
            self.array.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            
        }
        tableView.reloadData()
    }
}
