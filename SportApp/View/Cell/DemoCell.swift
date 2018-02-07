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
    
    @IBOutlet weak var awayTeamFormation: UILabel!
    @IBOutlet weak var localTeamFormationLbl: UILabel!
    @IBOutlet weak var weatherImg: UIImageView!
    @IBOutlet weak var errorLbl: UILabel!
    
    @IBOutlet weak var speedLbl: UILabel!
    @IBOutlet weak var cloudsLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    
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
        if(!data.emptyMessage.isEmpty){
            errorLbl.isHidden = false
            awayTeamFormation.isHidden = true
            localTeamFormationLbl.isHidden = true
            weatherImg.isHidden = true
            speedLbl.isHidden = true
            cloudsLbl.isHidden = true
            weatherLbl.isHidden = true
            tempLbl.isHidden = true
            timeLbl.isHidden = true
            homeScoreLbl.isHidden = true
            homeTeamLbl.isHidden = true
            awayScoreLbl.isHidden = true
            awayTeamLbl.isHidden = true
        }else{
            errorLbl.isHidden = true
            awayTeamFormation.isHidden = false
            localTeamFormationLbl.isHidden = false
            weatherImg.isHidden = false
            speedLbl.isHidden = false
            cloudsLbl.isHidden = false
            weatherLbl.isHidden = false
            tempLbl.isHidden = false
            timeLbl.isHidden = false
            homeScoreLbl.isHidden = false
            homeTeamLbl.isHidden = false
            awayScoreLbl.isHidden = false
            awayTeamLbl.isHidden = false
            timeLbl.text = data.time_status
            homeScoreLbl.text = String(data.local_score)
            homeScoreLbl.backgroundColor = UIColor.clear
            homeTeamLbl.text = data.localT_name
            homeTeamLbl.backgroundColor = UIColor.clear
            
            awayTeamLbl.text = data.awayT_name
            awayTeamLbl.backgroundColor = UIColor.clear
            awayScoreLbl.text = String(data.away_score)
            awayTeamLbl.backgroundColor = UIColor.clear
            
            tempLbl.text = String(data.temperature)
            weatherLbl.text = data.weather_code
            cloudsLbl.text = data.weather_clouds
            speedLbl.text = data.wind_speed
            
            if !data.weather_img.isEmpty {
                let url = URL(string: data.weather_img)
                let data = try? Data(contentsOf: url!)
                weatherImg.image = UIImage(data: data!)
            }
            
            localTeamFormationLbl.text = data.local_formation
            awayTeamFormation.text = data.away_formation
            
            
            //self.topAwayView.backgroundColor = UIColor(patternImage: UIImage(named: "super_lig.png")!)
            
            /*
            let background = UIImage(named: "eredvise")
            
            var imageView : UIImageView!
            imageView = UIImageView(frame: topAwayView.bounds)
            imageView.contentMode =  UIViewContentMode.scaleAspectFill
            imageView.clipsToBounds = true
            imageView.image = background
            imageView.center = topAwayView.center
            topAwayView.addSubview(imageView)
            topAwayView.sendSubview(toBack: imageView)
 */
        }
    }
}

