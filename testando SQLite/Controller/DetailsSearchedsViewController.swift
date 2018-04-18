//
//  DetailsSearchedsViewController.swift
//  testando SQLite
//
//  Created by Naville Brasil on 18/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class DetailsSearchedsViewController: UIViewController
{
    //Outlets
    @IBOutlet weak var viewDetails: UIView!
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOccupation: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelRegisterNumber: UILabel!
    
    //Properties
    var id = 0
    var name = ""
    var occupation = ""
    var level = ""
    var age = 0
    var register = 0
    var number = 0
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        self.viewDetails.layer.cornerRadius = 14
        
        labelId.text = "\(id)"
        labelAge.text = "\(age)"
        labelName.text = name
        labelOccupation.text = occupation
        labelLevel.text = level
        labelRegisterNumber.text = "\(register)"
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissView))
        tap.numberOfTapsRequired = 1
        self.view.addGestureRecognizer(tap)
        
    }
    
    @objc func dismissView()
    {
        self.dismiss(animated: true, completion: nil)
    }

}
