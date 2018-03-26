//
//  LMLCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 25..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

//The match list view cells
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
        self.scoresView.backgroundColor = UIColor.flatCararraGray()
        self.teamNamesView.backgroundColor = UIColor.flatCararraGray()
        
        if(data.time_status == "LIVE"){
            self.timeView.backgroundColor = UIColor.flatGreen
            timeLbl.textColor = UIColor.flatWhite
            timeLbl.text = String(data.time)
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.5
        }else if (data.time_status == "NS"){
            self.timeView.backgroundColor = UIColor.flatIron()
            
            let time = data.starting_time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let fullDate = dateFormatter.date(from: time)
            dateFormatter.dateFormat = "HH:mm"
            let startingTime = dateFormatter.string(from: fullDate!)
            
            timeLbl.textColor = UIColor.flatBlack
            timeLbl.text = startingTime
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.2
        }else{
            self.timeView.backgroundColor = UIColor.flatIron()
            
            timeLbl.text = data.time_status
            timeLbl.numberOfLines = 1
            timeLbl.adjustsFontSizeToFitWidth = true
            timeLbl.minimumScaleFactor = 0.5
        }
        
        if(data.local_score > data.away_score){
            homeScoreLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
            homeTmLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
        }else if (data.away_score > data.local_score){
            awayScorelbl.font = UIFont.boldSystemFont(ofSize: 17.0)
            awayTmLbl.font = UIFont.boldSystemFont(ofSize: 17.0)
        }else {
            homeScoreLbl.font = UIFont.systemFont(ofSize: 17.0)
            homeTmLbl.font = UIFont.systemFont(ofSize: 17.0)
            awayScorelbl.font = UIFont.systemFont(ofSize: 17.0)
            awayTmLbl.font = UIFont.systemFont(ofSize: 17.0)
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
