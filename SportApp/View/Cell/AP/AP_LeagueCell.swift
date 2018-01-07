//
//  AP_LeagueCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 29..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit
import FoldingCell

class AP_LeagueCell: FoldingCell {

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

    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    
    func updateUI(events: SM_GetEventsByDate){
//        self.nameLbl.text = fixtures.league_name
        self.match_status.text = events.time_status
        self.home_score.text = String(events.local_score)
        self.home_team.text = events.localT_name
        self.away_team.text = events.awayT_name
        self.away_score.text = String(events.away_score)
    }

}
