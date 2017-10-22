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
    var leaguesDataWithSection = Dictionary<String , Array<AP_GetLeagues> >()
    var selectedImage : UIImageView?
    var sortedSections = [String]()
    
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
                            
                            var list = self.leaguesDataWithSection[lg.country_name] ?? []
                            list.append(lg)
                            self.leaguesDataWithSection[lg.country_name] = list
                            
                        }
                        print("lfutott a legaue")
                        //self.updateUI(data: self.leaguesData)
                        self.sortedSections = self.leaguesDataWithSection.keys.sorted()
                        self.tableView.reloadData()
                    })
                }
            }
            print("lfutott minden")
        }
        print("esemenyen kivul")
    }
    
    // MARK: viewDidAppear
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if listView.subviews.count < topLeague.count {
            listView.viewWithTag(0)?.tag = 1000
            setupList()
        }
    }
    
    // MARK: setupLIST
    func setupList() {
        for i in topLeague.indices {
            let imageView = UIImageView(image: UIImage(named: topLeague[i].image))
            imageView.tag = i
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            imageView.layer.cornerRadius = 20
            imageView.layer.masksToBounds = true
            imageView.layer.shadowColor = UIColor.black.cgColor
            imageView.layer.shadowOpacity = 1
            imageView.layer.shadowOffset = CGSize.zero
            imageView.layer.shadowRadius = 10
            //we ask swift the cache the rendered shadow
            imageView.layer.shouldRasterize = true
            listView.addSubview(imageView)
            
            imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didTapImageView)))
        }
        listView.backgroundColor = UIColor.clear
        positionListItems()
    }
    
    // MARK: positionListItems
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
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedSections[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.leaguesDataWithSection.keys.count
        //return 1
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaguesDataWithSection[sortedSections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_CountryCell", for: indexPath) as? AP_CountryCell {
            print("count row")
            print(indexPath.row)
            print("count section")
            print(indexPath.section)
            print("a leagues with sections")
            
            let matchData = self.leaguesDataWithSection[sortedSections[indexPath.section]]![indexPath.row]
            cell.updateUI(fixtures: matchData)
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
