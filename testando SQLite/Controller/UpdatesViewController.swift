//
//  UpdatesViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 18/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class UpdatesViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var searchBarName: UISearchBar!
    @IBOutlet weak var searchBarLetter: UISearchBar!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldLevel: UITextField!
    @IBOutlet weak var buttonChangeRecord: UIButton!
    
    //Properties
    var pickerCollaborator = UIPickerView()
    var pickerLevel = UIPickerView()
    
    var array: [SQLiteModel] = []
    var arrayLevel = ["Estágiario", "Trainee", "Júnior", "Pleno", "Senior", "Analista"]
    
    var database = MySQLite()
    var query = ""
    var idDatabase = 0

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.database.request()
        
        self.buttonChangeRecord.layer.cornerRadius = 6
        
        self.searchBarName.delegate = self
        self.searchBarLetter.delegate = self
        self.textFieldName.delegate = self
        self.textFieldLevel.delegate = self
        self.pickerCollaborator.delegate = self
        self.pickerCollaborator.dataSource = self
        self.pickerLevel.delegate = self
        self.pickerLevel.dataSource = self
        
        self.textFieldName.inputView = pickerCollaborator
        self.textFieldLevel.inputView = pickerLevel
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "segueDetailsSearch2"
        {
            let vc = segue.destination as! DetailsSearched2ViewController
            vc.array = self.array
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    //MARK: - Methods
    
    
    //MARK: - Action
    @IBAction func changeRecord(_ sender: UIButton)
    {
        //"UPDATE ALUNOS SET NOME 'Luan' WHERE ID = 1"
        print(self.idDatabase)
        if let level = self.textFieldLevel.text
        {
            self.database.delegate = self
            self.database.upDate(level: level, id: self.idDatabase)
        }
        
    }
    
}

//MARK: - UISearchBarDelegate
extension UpdatesViewController: UISearchBarDelegate
{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar)
    {
        switch searchBar
        {
            case self.searchBarName:
                self.query = "select *from DEVROOM WHERE name = '\(String(describing: self.searchBarName.text!))'"
                print(query)
                self.database.delegate = self
                self.database.selectWith(query: query)
                self.array = self.database.arrayData
                self.idDatabase = self.database.arrayData[0].getId()
                self.performSegue(withIdentifier: "segueDetailsSearch2", sender: nil)
            default:
                self.query = "select *from DEVROOM WHERE name LIKE '\(String(describing: self.searchBarLetter.text!))%'"
                print(query)
                self.database.selectWith(query: query)
                self.array = self.database.arrayData
                self.performSegue(withIdentifier: "segueDetailsSearch2", sender: nil)
        }
    }
}

//MARK: - UITextFieldDelegate
extension UpdatesViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        switch textField
        {
            case self.textFieldName:
                self.array = self.database.arrayData
                self.pickerCollaborator.reloadComponent(0)
            default:
                break
        }
    }
}

//MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension UpdatesViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        switch pickerView
        {
            case self.pickerCollaborator:
                return self.database.arrayData.count
            default:
                return self.arrayLevel.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        switch pickerView
        {
            case self.pickerCollaborator:
                return self.database.arrayData[row].getName()
            default:
                return self.arrayLevel[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        switch pickerView
        {
            case self.pickerCollaborator:
                self.textFieldName.text = self.database.arrayData[row].getName()
                self.idDatabase = self.database.arrayData[row].getId()
            default:
                self.textFieldLevel.text = self.arrayLevel[row]
            
        }
    }
    
}

//MARK: - MYSQLiteDelegate
extension UpdatesViewController: MYSQLiteDelegate
{
    func getSearchResult(name: String, level: String, id: Int)
    {
        if name != ""
        {
            self.textFieldName.text = name
            self.textFieldLevel.text = level
            self.idDatabase = id
        }
    }
    
    func upDateIsSuccessfuly(_ bool: Bool)
    {
        if bool
        {
            self.textFieldName.text = ""
            self.textFieldLevel.text = ""
            self.searchBarName.text = ""
            self.searchBarLetter.text = ""
            
            let alert = UIAlertController(title: "Alteração feita com sucesso", message: "Deseja fazer outra alteração?", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Sim", style: .default, handler: nil)
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
                self.navigationController?.popViewController(animated: true)
            }
            alert.addAction(yes)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: "Erro", message: "Não foi possível fazer a alteração", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}
