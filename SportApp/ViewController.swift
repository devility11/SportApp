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

class ViewController: UIViewController {

    let fixturesData = GetFixtureData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let serviceReq = ServiceRequests()
        
        serviceReq.getData(url: socceramaURL+"fixtures/between/2017-10-01/2017-10-09"+socceramaAPI) { response in
            print("response eleje")
            print(response)
            print("response vege")
        }
        
        
        
    }
    
    
    
    func updateSportData(json: JSON){
        
        print(json["data"])
        for item in json["data"].arrayValue {
            print(item["id"].stringValue)
            print(item)
            print("______________________________________")
        }
            
        
        //print(json["data"][0]["round_id"])
        
    }


    

}

