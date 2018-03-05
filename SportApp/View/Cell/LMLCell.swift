//
//  LMLCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 25..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class LMLCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var awayScorelbl: UILabel!
    @IBOutlet weak var homeTmLbl: UILabel!
    @IBOutlet weak var awayTmLbl: UILabel!
    @IBOutlet weak var cellBGView: UIView!
    @IBOutlet weak var teamNamesView: UIView!
    @IBOutlet weak var scoresView: UIView!
    @IBOutlet weak var timeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateUI(data: SM_GetEventsByDate){
        
        cellBGView.backgroundColor = UIColor.white
        
        timeView.sizeToFit()
        if(data.time_status == "LIVE"){
            timeLbl.text = String(data.time)
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.5
        }else if (data.time_status == "NS"){
            print("itt")
            print(data)
            let time = data.starting_time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let fullDate = dateFormatter.date(from: time)
            dateFormatter.dateFormat = "hh:mm"
            let startingTime = dateFormatter.string(from: fullDate!)
            timeLbl.text = startingTime
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.5
        }else{
            timeLbl.text = data.time_status
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.5
        }
        
        scoresView.sizeToFit()
        homeScoreLbl.text = String(data.local_score)
        homeScoreLbl.numberOfLines = 1
        homeScoreLbl.adjustsFontSizeToFitWidth = true
        homeScoreLbl.minimumScaleFactor = 0.5
        
        homeTmLbl.text = data.localT_name
        homeTmLbl.numberOfLines = 1
        homeTmLbl.adjustsFontSizeToFitWidth = true
        homeTmLbl.minimumScaleFactor = 0.5
        
        teamNamesView.sizeToFit()
        awayTmLbl.text = data.awayT_name
        awayTmLbl.numberOfLines = 1
        awayTmLbl.adjustsFontSizeToFitWidth = true
        awayTmLbl.minimumScaleFactor = 0.5
        
        awayScorelbl.text = String(data.away_score)
        awayScorelbl.numberOfLines = 1
        awayScorelbl.adjustsFontSizeToFitWidth = true
        awayScorelbl.minimumScaleFactor = 0.5
        
    }

}
