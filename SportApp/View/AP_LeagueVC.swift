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
    //var valueToDetail = AP_GetEvents()
    var valueToDetail = SM_GetEventsByDate()
    var eventsData = [SM_GetEventsByDate]()
    //var eventsData = [AP_GetEvents]()
    
    @IBOutlet weak var datePicker: ScrollableDatepicker!
    
    @IBOutlet weak var dateScrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //print(apiFootballURL+"get_events&from=2017-10-28&to=2017-11-01&league_id=\(valueToPass)"+apiFootballAPI)
        //https://soccer.sportmonks.com/api/v2.0/fixtures/date/2017-12-08?api_token=0Kq0fmZYfls0twYy7JgA3ClWjtNMsBuabdLna4iKJIz6WEWfNSvnYLWl6X8I&leagues=271
        print(smURL+"fixtures/date/2017-12-08"+smAPI+"&leagues=\(valueToPass)&include=localTeam,awayTeam")
        let sR = ServiceRequests()
        
        sR.getData(url: smURL+"fixtures/date/2017-12-08"+smAPI+"&leagues=\(valueToPass)&include=localTeam,awayTeam") { response in
            
            for item in response["data"].arrayValue {
                print(item)
                let events = SM_GetEventsByDate()
                events.awayT_name = item["awayTeam"]["data"]["name"].stringValue
                events.awayT_flag = item["awayTeam"]["data"]["flag"].stringValue
                events.localT_name = item["localTeam"]["data"]["name"].stringValue
                events.localT_flag = item["localTeam"]["data"]["flag"].stringValue
                
                events.away_score = item["scores"]["visitorteam_score"].intValue
                events.local_score = item["scores"]["localteam_score"].intValue
                
                events.time_status = item["time"]["status"].stringValue
                events.time = item["time"]["minute"].intValue
                events.match_id = item["id"].intValue
                
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
    /*
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
    }*/
}

