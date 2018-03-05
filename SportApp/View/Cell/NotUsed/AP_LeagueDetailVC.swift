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
    
    var matchComment = [AP_MatchComment]()
    var firstHalf = [AP_MatchComment]()
    var secondHalf = [AP_MatchComment]()
    var matchData = [Any]()
    
    var matchDataWithSection = Dictionary<Int , Array<AP_MatchComment> >()
    
    var sortedSections = [0 : "firstHalf", 1: "secondHalf"]
    
    
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
                for goal in item["goalscorer"].arrayValue {
                    
                    let comment = AP_MatchComment()
                    
                    if goal["away_scorer"].stringValue.isEmpty {
                        comment.home_scorer = goal["home_scorer"].stringValue
                        comment.away_scorer = ""
                    }else if goal["home_scorer"].stringValue.isEmpty {
                        comment.home_scorer = ""
                        comment.away_scorer = goal["away_scorer"].stringValue
                    }else if !goal["home_scorer"].stringValue.isEmpty && !goal["away_scorer"].stringValue.isEmpty {
                        comment.home_scorer = goal["home_scorer"].stringValue
                        comment.away_scorer = goal["away_scorer"].stringValue
                    }
                    
                    comment.score = goal["score"].stringValue
                    
                    let time = goal["time"].stringValue.replacingOccurrences(of: "'", with: "")
                    if !time.isEmpty {
                        comment.time = (time as NSString).integerValue
                        if( comment.time < 46 ){
                            self.firstHalf.append(comment)
                        }else {
                            self.secondHalf.append(comment)
                        }
                    }
                    self.matchComment.append(comment)
                }
                
                for card in item["cards"].arrayValue {
                    let commentCard = AP_MatchComment()
                    if card["away_fault"].stringValue.isEmpty {
                        commentCard.home_fault = card["home_fault"].stringValue
                        commentCard.away_fault = ""
                    }else if card["home_fault"].stringValue.isEmpty {
                        commentCard.home_fault = ""
                        commentCard.away_fault = card["away_fault"].stringValue
                    } else if !card["home_fault"].stringValue.isEmpty && !card["away_fault"].stringValue.isEmpty {
                        commentCard.home_fault = card["home_fault"].stringValue
                        commentCard.away_fault = card["away_fault"].stringValue
                    }
                    
                    commentCard.card = card["card"].stringValue
                    let time = card["time"].stringValue.replacingOccurrences(of: "'", with: "")
                    
                    if !time.isEmpty {
                        commentCard.time = (time as NSString).integerValue
                        if( commentCard.time < 46 ){
                            self.firstHalf.append(commentCard)
                        }else {
                            self.secondHalf.append(commentCard)
                        }
                    }
                    self.matchComment.append(commentCard)
                }
                
                self.firstHalf.sort(by: {$0.time > $1.time})
                self.secondHalf.sort(by: {$0.time > $1.time})
                
                self.matchDataWithSection.updateValue(self.secondHalf, forKey: 0)
                self.matchDataWithSection.updateValue(self.firstHalf, forKey: 1)
                
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
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var title = String()
        
        switch section {
            case 0:
                title = "Second Half"
            case 1:
                title = "First Half"
            default:
                title = ""
        }
        return title
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.matchDataWithSection.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.matchDataWithSection[section]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_MatchDetailHistoryCell", for: indexPath) as? AP_MatchDetailHistoryCell {
            let matchData = self.matchDataWithSection[indexPath.section]![indexPath.row]
            cell.updateUI(data: matchData)
            return cell
        }else {
            return UITableViewCell()
        }
    }
    
    
}
