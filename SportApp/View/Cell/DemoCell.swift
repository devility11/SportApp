//
//  DemoCell.swift
//  FoldingCell
//
//  Created by Alex K. on 25/12/15.
//  Copyright © 2015 Alex K. All rights reserved.
//

import UIKit
import FoldingCell

class DemoCell: FoldingCell {
  
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    @IBOutlet weak var awayScoreLbl: UILabel!
    @IBOutlet weak var awayTeamLbl: UILabel!
    
    override func awakeFromNib() {
        //foregroundView.layer.cornerRadius = 10
        //foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
  
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
    func updateUI(data: AP_GetEvents){
        print(" az updateuiben")
        timeLbl.text = data.match_time
        homeScoreLbl.text = data.match_hometeam_score
        homeTeamLbl.text = data.match_hometeam_name
        
        awayTeamLbl.text = data.match_awayteam_name
        awayScoreLbl.text = data.match_awayteam_score
    }
  
}

