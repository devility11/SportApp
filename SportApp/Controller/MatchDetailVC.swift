//
//  MatchDetailVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 03. 07..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class MatchDetailVC: UIViewController {

    //main view
    @IBOutlet weak var leagueNameLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!    
    @IBOutlet weak var matchTimeLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var awayScoreLbl: UILabel!
    
    @IBOutlet weak var containerViewLive: UIView!
    @IBOutlet weak var containerViewStats: UIView!
    @IBOutlet weak var containerViewStandings: UIView!
    @IBOutlet weak var containerViewWeather: UIView!
    @IBOutlet weak var containerViewFormations: UIView!
    
    
    
    var valueToPass : String = ""
    var valueToDetail = SM_GetEventsByDate()
    var matchID : Int = 0
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        
        //stats
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 1
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        
        //table
        if sender.selectedSegmentIndex == 1 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 1
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        //live
        if sender.selectedSegmentIndex == 2 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 1
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        //weather
        if sender.selectedSegmentIndex == 3 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 1
                self.containerViewFormations.alpha = 0
            })
        }
        //formations
        if sender.selectedSegmentIndex == 4 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 1
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("a detailben")
        print(valueToDetail)
        
        if valueToDetail.match_id != 0 {
            self.matchID = valueToDetail.match_id
        }
        
        setupMainView(data: valueToDetail)
        
        print(self.matchID)
        
    }
    
    
    //setup the mainView of the match details
    func setupMainView(data: SM_GetEventsByDate ){
        
        self.awayScoreLbl.text = String(data.away_score)
        self.awayLbl.text = data.awayT_name
        
        self.homeScoreLbl.text = String(data.local_score)
        self.homeLbl.text = data.localT_name
        
        self.leagueNameLbl.text = data.league_name
        
        if(data.time_status == "LIVE"){
            self.matchTimeLbl.text = String(data.time)
        }else if (data.time_status == "NS"){
            let time = data.starting_time
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ss"
            let fullDate = dateFormatter.date(from: time)
            dateFormatter.dateFormat = "HH:mm"
            let startingTime = dateFormatter.string(from: fullDate!)
            matchTimeLbl.text = startingTime
            matchTimeLbl.numberOfLines = 1
            matchTimeLbl.adjustsFontSizeToFitWidth = true
            matchTimeLbl.minimumScaleFactor = 0.5
        }else{
            matchTimeLbl.text = data.time_status
            matchTimeLbl.numberOfLines = 1
            matchTimeLbl.adjustsFontSizeToFitWidth = true
            matchTimeLbl.minimumScaleFactor = 0.5
        }
    }

}
