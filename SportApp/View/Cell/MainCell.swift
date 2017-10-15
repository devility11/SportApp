//
//  MainCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 10..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(fixtures: GetFixtureData){
        self.homeLbl.text = fixtures.homeTeamName
        self.awayLbl.text = fixtures.awayTeamName
    }

}
