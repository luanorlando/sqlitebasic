//
//  NewEmployeeViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 16/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class NewEmployeeViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var TextFieldOccupation: UITextField!
    @IBOutlet weak var textFieldLevel: UITextField!
    @IBOutlet weak var textFieldName: UITextField!
    @IBOutlet weak var textFieldAge: UITextField!
    @IBOutlet weak var textFieldRegisterNumber: UITextField!
    
    //Properties
    var picker = UIPickerView()
    
    var database = MySQLite()
    
    var array = ["Estágiario", "Trainee", "Júnior", "Pleno", "Senior", "Análista"]
    

    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if UserDefaults.standard.integer(forKey: "RegisterNumber") == 0
        {
            self.textFieldRegisterNumber.text = "001"
        }
        else
        {
            self.textFieldRegisterNumber.text = "\(UserDefaults.standard.integer(forKey: "RegisterNumber"))"
        }
        
        self.textFieldLevel.inputView = picker
        
        self.textFieldLevel.delegate = self
        self.picker.delegate = self
        self.picker.dataSource = self
        self.database.delegate = self
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        view.endEditing(true)
    }
    
    //MARK: - Actions
    @IBAction func insertNewEmployee(_ sender: UIButton)
    {
        if self.TextFieldOccupation.text != "" && self.textFieldLevel.text != "" && self.textFieldName.text != "" && self.textFieldAge.text != "" && self.textFieldRegisterNumber.text != ""
        {
            self.database.insert(name: self.textFieldName.text!, occupation: self.TextFieldOccupation.text!, level: self.textFieldLevel.text!, age: Int(self.textFieldAge.text!)!, register: Int(self.textFieldRegisterNumber.text!)!)
            
            self.database.request()
            
            let sum = Int(self.textFieldRegisterNumber.text!)! + 1
            self.textFieldRegisterNumber.text = "\(sum)"
            
            UserDefaults.standard.set(sum, forKey: "RegisterNumber")
            

        }
        else
        {
            let alert = UIAlertController(title: "Atenção", message: "Favor preencher todos os campos", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

////MARK: - MYSQLiteDelegate
//extension NewEmployeeViewController: MYSQLiteDelegate
//{
//    func recoveredData(array: [SQLiteModel])
//    {
//        <#code#>
//    }
//
//}

//MARK: - UIPickerViewDelegate
extension NewEmployeeViewController: UIPickerViewDelegate, UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int
    {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int
    {
        return self.array.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        return self.array[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        self.textFieldLevel.text = self.array[row]
    }

}

//MARK: - UITextFieldDelegate
extension NewEmployeeViewController: UITextFieldDelegate
{
    func textFieldDidBeginEditing(_ textField: UITextField)
    {
        self.textFieldLevel.text = self.array[0]
    }
}

//MARK: - MySQLIteDelegate
extension NewEmployeeViewController: MYSQLiteDelegate
{
    func registerInsertedSuccessfuly(message: String, error: Bool)
    {
        if error
        {
            let alert = UIAlertController(title: "Erro ao adicionar cadastro", message: message, preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
        }
        else
        {
            let alert = UIAlertController(title: message, message: "Deseja realizar outro cadastro?", preferredStyle: .actionSheet)
            let yes = UIAlertAction(title: "Sim", style: .default) { (action) in
                self.textFieldName.text = ""
                self.TextFieldOccupation.text = ""
                self.textFieldLevel.text = ""
                self.textFieldAge.text = ""
                
            }
            let cancel = UIAlertAction(title: "Cancelar", style: .cancel) { (action) in
                self.textFieldName.text = ""
                self.TextFieldOccupation.text = ""
                self.textFieldLevel.text = ""
                self.textFieldAge.text = ""
                
                self.tabBarController?.selectedIndex = 0
            }
            alert.addAction(yes)
            alert.addAction(cancel)
            
            self.present(alert, animated: true, completion: nil)
        }
    }
}
