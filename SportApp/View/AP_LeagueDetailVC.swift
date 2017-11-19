//
//  AP_LeagueDetailVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 19..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_LeagueDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    var valueToDetail = AP_GetEvents()
    var topLeague : TopLeagueSlider!
    var goalsData = [AP_GoalScorer]()
    
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var homeTeamLbl: UILabel!
    @IBOutlet weak var awayScoreLbl: UILabel!
    @IBOutlet weak var awayTeamLbl: UILabel!
    @IBOutlet weak var matchStatusLbl: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        updateMainUI(data: valueToDetail)
        
        let sR = ServiceRequests()
        print(apiFootballURL+"get_events&from=2017-10-28&to=2017-11-01&match_id=\(valueToDetail.match_id)"+apiFootballAPI)
        sR.getData(url: apiFootballURL+"get_events&from=2017-10-28&to=2017-11-01&match_id=\(valueToDetail.match_id)"+apiFootballAPI) { response in
            
            for item in response.arrayValue {
                
                print(item["goalscorer"].arrayValue)
                
                for goal in item["goalscorer"].arrayValue {
                    
                    let goals = AP_GoalScorer()
                    print("a FORBAN: ")
                    print(goal)
                    if goal["away_scorer"].stringValue.isEmpty {
                        goals.home_scorer = goal["home_scorer"].stringValue
                        goals.away_scorer = ""
                    }else if  goal["home_scorer"].stringValue.isEmpty {
                        goals.home_scorer = ""
                        goals.away_scorer = goal["away_scorer"].stringValue
                    }
                    
                    goals.score = goal["score"].stringValue
                    goals.time = goal["time"].stringValue
                    self.goalsData.append(goals)
                }
                self.tableView.reloadData()
            }
        }
    }
    
    func updateMainUI(data: AP_GetEvents){
        self.awayScoreLbl.text  = String(data.match_awayteam_score)
        self.awayTeamLbl.text = data.match_awayteam_name
        self.homeTeamLbl.text = data.match_hometeam_name
        self.homeScoreLbl.text = String(data.match_hometeam_score)
        if data.match_time.isEmpty{
            self.matchStatusLbl.text = data.match_status
        }else{
            self.matchStatusLbl.text = data.match_time
        }
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.goalsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_MatchDetailHistoryCell", for: indexPath) as? AP_MatchDetailHistoryCell {
            cell.updateUI(goals: self.goalsData[indexPath.row])
            return cell
            
        }else {
            return UITableViewCell()
        }
    }

   
}
