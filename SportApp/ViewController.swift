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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let serviceReq = ServiceRequests()
        
        serviceReq.getData(url: socceramaURL+"fixtures/between/2017-10-01/2017-10-09"+socceramaAPI) { response in
            
            self.updateSportData(json: response)
        }
        
        
    }
    
    
    
    func updateSportData(json: JSON){
        
        
        for item in json["data"].arrayValue {
            print("_____________ START _______________")
            print(item["id"].stringValue)
            print(item)
            print("_____________ END _________________")
        }
        
    }


    

}

