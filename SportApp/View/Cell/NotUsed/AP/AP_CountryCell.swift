//
//  AP_CountryCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 15..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_CountryCell: UITableViewCell {

    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellBGView.backgroundColor = UIColor.white
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(fixtures: SM_GetLeagues){
        
        self.nameLbl.text = fixtures.name
    }

}
