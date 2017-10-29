//
//  Ap_LeagueVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 29..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit

class AP_LeagueVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var valueToPass = ""
    var eventsData = [AP_GetEvents]()
    
    
    @IBOutlet weak var dateScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        print("a leagueben a valuetopass")
        print(valueToPass)
        
        print(apiFootballURL+"get_events&from=2017-10-28&to=2017-11-01&league_id=\(valueToPass)"+apiFootballAPI)
        let sR = ServiceRequests()
        
        sR.getData(url: apiFootballURL+"get_events&from=2017-10-28&to=2017-11-01&league_id=\(valueToPass)"+apiFootballAPI) { response in
            
            for item in response.arrayValue {
                let events = AP_GetEvents()
                events.match_awayteam_name = item["match_awayteam_name"].stringValue
                events.match_hometeam_name = item["match_hometeam_name"].stringValue
                events.match_hometeam_score = item["match_hometeam_score"].stringValue
                events.match_awayteam_score = item["match_awayteam_score"].stringValue
                events.match_status = item["match_status"].stringValue
                
                self.eventsData.append(events)
                print(events.match_awayteam_name)
                self.tableView.reloadData()
            }
            self.tableView.reloadData()
        }
        self.tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("a numberof rowsban")
        print(self.eventsData.count)
        return self.eventsData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_LeagueCell", for: indexPath) as? AP_LeagueCell {
            print("itt a cellben")
            let matchData = self.eventsData[indexPath.row]
            print(matchData)
            cell.updateUI(events: matchData)
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
  

}
