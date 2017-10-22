//
//  AP_CountryCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 15..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_CountryCell: UITableViewCell {

    @IBOutlet weak var ctrLbl: UILabel!
    @IBOutlet weak var nameLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(fixtures: AP_GetLeagues){
        self.nameLbl.text = fixtures.country_name
        self.ctrLbl.text = fixtures.league_name
    }

}
