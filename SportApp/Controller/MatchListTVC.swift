//
//  MatchListTVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 12. 11..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit
import FoldingCell

class MatchListTVC: UITableViewController {

    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    //to pass the ctr value
    var valueToPass = ""
    var valueToDetail = SM_GetEventsByDate()
    var eventsData = [SM_GetEventsByDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        print(" a matcheknel")
        print(valueToPass)
        print(smURL+"fixtures/date/2017-12-08"+smAPI+"&leagues=\(valueToPass)&include=localTeam,visitorTeam")
        let sR = ServiceRequests()
        
        sR.getData(url: smURL+"fixtures/date/2017-12-08"+smAPI+"&leagues=\(valueToPass)&include=localTeam,visitorTeam") { response in
            
            for item in response["data"].arrayValue {
                print(item)
                let events = SM_GetEventsByDate()
                events.awayT_name = item["visitorTeam"]["data"]["name"].stringValue
                events.awayT_flag = item["visitorTeam"]["data"]["flag"].stringValue
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

    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
    }
    

}


// MARK: - TableView
extension MatchListTVC {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return self.eventsData.count
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoCell = cell else {
            return
        }
        let matchData = self.eventsData[indexPath.row]
        cell.updateUI(data: matchData)
        print("a displayben")
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
            //cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
            //cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
        //cell.number = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        print("a folding cell beallitasaban")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            //cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            //cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
}
