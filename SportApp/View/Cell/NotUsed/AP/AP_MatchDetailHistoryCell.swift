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
    @IBOutlet weak var homeInfoLbl: UILabel!
    @IBOutlet weak var awayInfoLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updateUI(data: AP_MatchComment){
        
        var cardTxt = ""
        if data.card == "yellowcard"{
            cardTxt = "Y"
        }else{
            cardTxt = "R"
        }
        
        if data.away_scorer.isEmpty &&  !data.home_scorer.isEmpty{
            self.homeLbl.text = data.home_scorer
            self.awayLbl.text = ""
            self.homeInfoLbl.text = "G"
            self.awayInfoLbl.text = ""
        }else if data.home_scorer.isEmpty && !data.away_scorer.isEmpty {
            self.awayLbl.text = data.away_scorer
            self.homeLbl.text = ""
            self.awayInfoLbl.text = "G"
            self.homeInfoLbl.text = ""
        }else if data.home_fault.isEmpty && !data.away_fault.isEmpty {
            self.awayLbl.text = data.away_fault
            self.homeLbl.text = ""
            self.awayInfoLbl.text = cardTxt
            self.homeInfoLbl.text = ""
        }else if data.away_fault.isEmpty && !data.home_fault.isEmpty  {
            self.awayLbl.text = ""
            self.homeLbl.text = data.home_fault
            self.homeInfoLbl.text = cardTxt
            self.awayInfoLbl.text = ""
        }else if !data.away_fault.isEmpty && !data.home_fault.isEmpty {
            self.awayLbl.text = data.away_fault
            self.homeLbl.text = data.home_fault
            self.homeInfoLbl.text = cardTxt
            self.awayInfoLbl.text = cardTxt
        }else if !data.away_scorer.isEmpty && !data.home_scorer.isEmpty {
            self.awayLbl.text = data.away_scorer
            self.homeLbl.text = data.home_scorer
            self.homeInfoLbl.text = "G"
            self.awayInfoLbl.text = "G"
        }
        
        self.timeLbl.text = String(data.time)
        
        self.awayLbl.adjustsFontSizeToFitWidth = true
        self.homeLbl.adjustsFontSizeToFitWidth = true
        self.homeInfoLbl.adjustsFontSizeToFitWidth = true
        self.awayInfoLbl.adjustsFontSizeToFitWidth = true
        self.awayLbl.minimumScaleFactor = 0.2
        self.homeLbl.minimumScaleFactor = 0.2
        
    }
}
