//
//  Ap_LeagueVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 29..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit
import ScrollableDatepicker

class AP_LeagueVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var valueToPass = ""
    var valueToDetail = AP_GetEvents()
    var eventsData = [AP_GetEvents]()
    
    @IBOutlet weak var datePicker: ScrollableDatepicker!
    
    @IBOutlet weak var dateScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
                events.match_id = item["match_id"].intValue
                
                self.eventsData.append(events)
            }
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    // MARK: tableviewnek a click esemenyei
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let indexPath = tableView.indexPathForSelectedRow!
        //valueToPass = String(self.self.eventsData[indexPath.row].match_id)
        valueToDetail = self.eventsData[indexPath.row]
        performSegue(withIdentifier: "LeagueDetailSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "LeagueDetailSegue") {
            if let destination = segue.destination as? AP_LeagueDetailVC {
                destination.valueToDetail = valueToDetail
            }
        }
    }
}

