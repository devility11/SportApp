//
//  AP_MatchDetailHistoryCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 11. 06..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_MatchDetailHistoryCell: UITableViewCell {
    
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateUI(goals: AP_GoalScorer){
        if goals.away_scorer.isEmpty {
            self.homeLbl.text = goals.home_scorer
            self.awayLbl.text = ""
        }else {
            self.awayLbl.text = goals.away_scorer
            self.homeLbl.text = ""
        }
        
        self.timeLbl.text = goals.time
        
    }
}
