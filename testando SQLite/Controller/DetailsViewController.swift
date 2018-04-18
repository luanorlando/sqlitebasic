//
//  DetailsViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 17/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController
{
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var buttonClose: UIButton!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelOccupation: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelRegisterNumber: UILabel!
    
    var name = ""
    var occupation = ""
    var age = 0
    var level = ""
    var register = 0
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.labelName.text = self.name
        self.labelAge.text = "\(self.age)"
        self.labelOccupation.text = self.occupation
        self.labelLevel.text = self.level
        self.labelRegisterNumber.text = "\(self.register)"
        
        customizeUI()
    }
    
    //MARK: - Methods
    func customizeUI()
    {
        self.viewDetails.layer.cornerRadius = 10
        self.buttonClose.layer.cornerRadius = self.buttonClose.frame.width / 2
        
    }
    
    //MARK; - Actions
    @IBAction func closeView(_ sender: UIButton)
    {
        self.dismiss(animated: true, completion: nil)
    }
    
}
