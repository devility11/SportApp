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
  
    @IBOutlet weak var topAwayStack: UIStackView!
    @IBOutlet weak var topAwayView: UIView!
    
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
    func updateUI(data: SM_GetEventsByDate){
        print(" az updateuiben")
        timeLbl.text = data.time_status
        homeScoreLbl.text = String(data.local_score)
        homeScoreLbl.backgroundColor = UIColor.clear
        homeTeamLbl.text = data.localT_name
        homeTeamLbl.backgroundColor = UIColor.clear
        
        awayTeamLbl.text = data.awayT_name
        awayTeamLbl.backgroundColor = UIColor.clear
        awayScoreLbl.text = String(data.away_score)
        awayTeamLbl.backgroundColor = UIColor.clear
        
        //self.topAwayView.backgroundColor = UIColor(patternImage: UIImage(named: "super_lig.png")!)
        
        let background = UIImage(named: "eredvise")
        
        var imageView : UIImageView!
        imageView = UIImageView(frame: topAwayView.bounds)
        imageView.contentMode =  UIViewContentMode.scaleAspectFill
        imageView.clipsToBounds = true
        imageView.image = background
        imageView.center = topAwayView.center
        topAwayView.addSubview(imageView)
        topAwayView.sendSubview(toBack: imageView)
        
        
    }
  
}

