//
//  DetailsSearched2ViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 18/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class DetailsSearched2ViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var viewInformation: UIView!
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonClose: UIButton!
    
    //Properties
    var array: [SQLiteModel] = []
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "Details2TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        
        self.viewDetails.layer.cornerRadius = 15
        self.buttonClose.layer.cornerRadius = self.buttonClose.frame.width / 2
        
        if self.array.count > 1
        {
            self.viewInformation.isHidden = false
            self.tableView.isScrollEnabled = true
        }
        else
        {
            self.viewInformation.isHidden = true
            self.tableView.isScrollEnabled = false
        }
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.reloadData()
        
    }
    
    //MARK: - Action
    @IBAction func closeView(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}

extension DetailsSearched2ViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        let label = UILabel(frame: CGRect(x: 0, y: self.tableView.center.y, width: self.tableView.frame.width, height: self.tableView.frame.height))
        
        if self.array.count < 1
        {
            label.textAlignment = .center
            label.text = "Essa pesquisa não retornou dados"
            
            self.tableView.backgroundView = label
        }
        else
        {
            label.text = ""
        }
        return self.array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Details2TableViewCell
        
        cell.labelId.text = "\(self.array[indexPath.row].getId())"
        cell.labelAge.text = "\(self.array[indexPath.row].getAge())"
        cell.labelRegisterNumber.text = "\(self.array[indexPath.row].getRegister())"
        cell.labelName.text = self.array[indexPath.row].getName()
        cell.labelOccupation.text = self.array[indexPath.row].getOccupation()
        cell.labelLevel.text = self.array[indexPath.row].getLevel()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.tableView.deselectRow(at: indexPath, animated: false)
    }
}
