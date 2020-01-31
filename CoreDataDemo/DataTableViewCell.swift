//
//  DataTableViewCell.swift
//  ContactsPro
//
//  Created by Giorgi Shamugia on 1/31/20.
//  Copyright © 2020 Chhaileng Peng. All rights reserved.
//

import UIKit

class DataTableViewCell: UITableViewCell {

    @IBOutlet var myLabel: UILabel!
    @IBOutlet var myImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        myImageView.makeRounded()
        
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

        // Configure the view for the selected state
    }
    
}
