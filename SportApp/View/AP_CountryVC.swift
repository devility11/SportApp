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

let topLeague = TopLeagueSlider.all()

class AP_CountryVC: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listView: UIScrollView!
    
    var countriesData = [AP_CountryData]()
    var CtrDatas = [Int]()
    var leaguesData = [AP_GetLeagues]()
    var selectedImage : UIImageView?
    
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if listView.subviews.count < topLeague.count {
            listView.viewWithTag(0)?.tag = 1000
            setupList()
        }
    }
    
    func setupList() {
        for i in topLeague.indices {
            let imageView = UIImageView(image: UIImage(named: topLeague[i].image))
            imageView.tag = i
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            listView.addSubview(imageView)
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
        }
        listView.backgroundColor = UIColor.clear
        positionListItems()
    }
    
    func positionListItems(){
        let listHeight = listView.frame.height
        let itemHeight: CGFloat = listHeight
        let aspectRatio = UIScreen.main.bounds.height / UIScreen.main.bounds.width
        let itemWidth: CGFloat = itemHeight / aspectRatio
        
        let horizontalPadding: CGFloat = 10.0
        
        for i in topLeague.indices {
            let imageView = listView.viewWithTag(i) as! UIImageView
            imageView.frame = CGRect(
                x: CGFloat(i) * itemWidth + CGFloat(i+1) * horizontalPadding, y: 0.0,
                width: itemWidth, height: itemHeight)
        }
        
        listView.contentSize = CGSize(
            width: CGFloat(topLeague.count) * (itemWidth + horizontalPadding) + horizontalPadding,
            height:  0)
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
    
    @objc func didTapImageView(_ tap: UITapGestureRecognizer) {
        selectedImage = tap.view as? UIImageView
        print("a tappban benne vok")
        let index = tap.view!.tag
        let selectedTopLeague = topLeague[index]
        
        //present details view controller
        let topLeagueDetails = storyboard!.instantiateViewController(withIdentifier: "AP_LeagueDetailVC") as! AP_LeagueDetailVC
        topLeagueDetails.topLeague = selectedTopLeague
        present(topLeagueDetails, animated: true, completion: nil)
    }


}
