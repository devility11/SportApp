//
//  ViewController.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 09..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var fixturesData = [GetFixtureData]()
    

    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let serviceReq = ServiceRequests()
        
        serviceReq.getData(url: socceramaURL+"fixtures/date/2017-10-01"+socceramaAPI+"&include=localTeam,visitorTeam,odds") { response in
            self.updateSportData(json: response)
        }
    }
    
    
    //MARK: - Fixtures Data update
    /***************************************************************/
    
    func updateSportData(json: JSON){
        for item in json["data"].arrayValue {
            let fix = GetFixtureData()
            fix.awayTeamID = item["visitorteam_id"].intValue
            fix.homeTeamID = item["localteam_id"].intValue
            fix.date = item["time"]["starting_at"]["date"].stringValue
            fix.awayTeamName = item["visitorTeam"]["data"]["name"].stringValue
            fix.homeTeamName = item["localTeam"]["data"]["name"].stringValue
            fix.awayScore = item["scores"]["visitorteam_score"].intValue
            fix.homeScore = item["scores"]["localteam_score"].intValue
            fix.minute = item["time"]["minute"].intValue
            fix.matchStatus = item["time"]["status"].stringValue
            fix.extraTime = item["time"]["extra_minute"].intValue
            fixturesData.append(fix)
            self.mainTableView.reloadData()
        }
    }

    //MARK: - TableView Settings
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fixturesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell {
            print(fixturesData[indexPath.row].awayTeamName)
            print(indexPath.row)
            let fixtures = fixturesData[indexPath.row]
            cell.updateUI(fixtures: fixtures)
            return cell
            
        }else {
            return UITableViewCell()
        }
    }

    

}

