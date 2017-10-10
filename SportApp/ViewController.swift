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
    let fixtures = GetFixtureData()
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mainTableView.delegate = self
        self.mainTableView.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
        let serviceReq = ServiceRequests()
        
        serviceReq.getData(url: socceramaURL+"fixtures/between/2017-10-01/2017-10-09"+socceramaAPI) { response in
            
            self.updateSportData(json: response)
            
            print("a fixturesek erteke belul start")
            print(self.fixturesData)
            print("a fixturesek erteke belul kivul")
            
        }
        
    }
    
    
    //MARK: - Fixtures Data update
    /***************************************************************/
    
    func updateSportData(json: JSON){
        
        
        for item in json["data"].arrayValue {
            fixtures.awayTeam = item["visitorteam_id"].stringValue
            fixtures.homeTeam = item["localteam_id"].stringValue
            fixtures.date = item["time"]["starting_at"]["date"].stringValue
            print("_____________ START _______________")
            print(item["id"].stringValue)
            print(item["visitorteam_id"].stringValue)
            print(item["localteam_id"].stringValue)
            //print(item)
            print("_____________ END _________________")
            fixturesData.append(fixtures)
            self.mainTableView.reloadData()
        }
        
    }

    //MARK: - TableView Settings
    /***************************************************************/
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("a countban")
        print(self.fixturesData.count)
        return self.fixturesData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = mainTableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as? MainCell {
            print(fixturesData[indexPath.row].awayTeam)
            print(indexPath.row)
            let fixtures = fixturesData[indexPath.row]
            cell.updateUI(fixtures: fixtures)
            return cell
        }else {
            return UITableViewCell()
        }
    }

    

}

