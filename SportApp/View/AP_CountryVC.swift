//
//  AP_CountryVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 15..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AP_CountryVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    
    var countriesData = [AP_CountryData]()
    var CtrDatas = [Int]()
    var leaguesData = [AP_GetLeagues]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self

        
        let sR = ServiceRequests()
        
        
        sR.getData(url: apiFootballURL+"get_countries"+apiFootballAPI) { response in
            
            for item in response.arrayValue {
                let ctrData = AP_CountryData()
                ctrData.country_id = item["country_id"].intValue
                ctrData.country_name = item["country_name"].stringValue
                print(item["country_name"].stringValue)
                self.CtrDatas.append(item["country_id"].intValue)
                self.countriesData.append(ctrData)
            }
            print("lfutott a ctr")
            
            if self.countriesData.count > 0 {
                let sRLeague = ServiceRequests()
                
                for cID in self.CtrDatas {
                    sRLeague.getData(url: apiFootballURL+"get_leagues&country_id=\(cID)"+apiFootballAPI, completion: { responseLeague in
                        
                        for lItem in responseLeague.arrayValue {
                            let lg = AP_GetLeagues()
                            lg.country_id = lItem["country_id"].intValue
                            lg.league_id = lItem["league_id"].intValue
                            lg.country_name = lItem["country_name"].stringValue
                            lg.league_name = lItem["league_name"].stringValue
                            self.leaguesData.append(lg)
                        }
                        print("lfutott a legaue")
                        self.updateUI(data: self.leaguesData)
                    })
                }
                
            }
            
            print("lfutott minden")
        }
        
        print("esemenyen kivul")
        
        
        
    }
    
    func updateUI(data: [AP_GetLeagues]){
        print("az updateuiban")
        print(data)
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return self.fixturesData.count
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_CountryCell", for: indexPath) as? AP_CountryCell {
            /*print(fixturesData[indexPath.row].awayTeamName)
            print(indexPath.row)
            let fixtures = fixturesData[indexPath.row]
            cell.updateUI(fixtures: fixtures)*/
            return cell
            
        }else {
            return UITableViewCell()
        }
    }


}
