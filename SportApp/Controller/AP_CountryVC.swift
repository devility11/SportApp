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

class AP_CountryVC: BaseController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var listView: UIScrollView!
    
    
    var countriesData = [SM_CtrData]()
    var CtrDatas = [Int]()
    var leaguesData = [SM_GetLeagues]()
    
    var leaguesDataWithSection = Dictionary<String , Array<SM_GetLeagues> >()
    var selectedImage : UIImageView?
    var sortedSections = [String]()
    var valueToPass = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //remove the separator line
        self.tableView.separatorStyle = .none
        self.tableView.backgroundColor = UIColor.cloudsColor()
        //self.tableView.backgroundColor = UIColor.white
        
        self.listView.backgroundColor = UIColor.init(white: 1, alpha: 0.2)
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.tableView.addSubview(activityIndicator)
        activityIndicator.frame = self.tableView.bounds
        activityIndicator.startAnimating()
        
        let sR = ServiceRequests()
        print("the country list")
        print(smURL+"leagues"+smAPI+"&include=country")
        
        sR.getData(url: smURL+"leagues"+smAPI+"&include=country") {
            response in
            
            for item in response["data"].arrayValue {
                
                let ctrData = SM_CtrData()
                ctrData.country_id = item["country_id"].intValue
                ctrData.country_name = item["country"]["data"]["name"].stringValue
                
                self.CtrDatas.append(item["country_id"].intValue)
                self.countriesData.append(ctrData)
                
                let lg = SM_GetLeagues()
                lg.league_id = item["id"].intValue
                lg.ctr_id = item["country_id"].intValue
                lg.current_round_id = item["current_round_id"].intValue
                lg.is_cup = item["is_cup"].boolValue
                lg.name = item["name"].stringValue
                lg.ctr_name = item["country"]["data"]["name"].stringValue
                lg.ctr_flag = item["country"]["data"]["flag"].stringValue
                self.leaguesData.append(lg)
                
                var list = [SM_GetLeagues]()
                list.append(lg)
                
                self.leaguesDataWithSection[lg.ctr_name] = list
            }
            
            self.sortedSections = self.leaguesDataWithSection.keys.sorted()
            activityIndicator.removeFromSuperview()
            self.tableView.reloadData()
        }
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
    
    //change the section color
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.flatBlueDark
        let header = view as! UITableViewHeaderFooterView
        
        header.textLabel?.textColor = UIColor.white
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.leaguesDataWithSection.keys.count
    }
 
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leaguesDataWithSection[sortedSections[section]]!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "AP_CountryCell", for: indexPath) as? AP_CountryCell {
            let matchData = self.leaguesDataWithSection[sortedSections[indexPath.section]]![indexPath.row]
            cell.backgroundColor = UIColor.clear
            
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
    
    
    // MARK: tableviewnek a click esemenyei
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = tableView.indexPathForSelectedRow!
        valueToPass = String(self.leaguesDataWithSection[sortedSections[indexPath.section]]![indexPath.row].league_id)
        performSegue(withIdentifier: "leagueSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "leagueSegue") {
            if let destination = segue.destination as? LeagueMLVC {
                print("valuetopass000")
                print(valueToPass)
                destination.valueToPass = valueToPass
            }
        }
    }
    
}
