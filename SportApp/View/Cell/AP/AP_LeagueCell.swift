//
//  AP_LeagueCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 29..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_LeagueCell: UITableViewCell {

    @IBOutlet weak var match_status: UILabel!
    @IBOutlet weak var home_score: UILabel!
    @IBOutlet weak var away_score: UILabel!
    @IBOutlet weak var home_team: UILabel!
    @IBOutlet weak var away_team: UILabel!
    @IBOutlet weak var detailsBtn: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateUI(events: AP_GetEvents){
//        self.nameLbl.text = fixtures.league_name
        self.match_status.text = events.match_status
        self.home_score.text = events.match_hometeam_score
        self.home_team.text = events.match_hometeam_name
        self.away_team.text = events.match_awayteam_name
        self.away_score.text = events.match_awayteam_score
    }

}
