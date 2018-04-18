//
//  Details2TableViewCell.swift
//  testando SQLite
//
//  Created by Naville Brasil on 18/04/2018.
//  Copyright © 2018 Luan Orlando. All rights reserved.
//

import UIKit

class Details2TableViewCell: UITableViewCell
{
    //Outlets
    @IBOutlet weak var labelId: UILabel!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelOccupation: UILabel!
    @IBOutlet weak var labelLevel: UILabel!
    @IBOutlet weak var labelAge: UILabel!
    @IBOutlet weak var labelRegisterNumber: UILabel!
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
