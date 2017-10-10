//
//  ServiceRequests.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 10..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServiceRequests {
    
    func getData(url: String, completion: @escaping (JSON) -> ()) {
        
        //let url = URL(string: socceramaURL+"fixtures/between/2017-10-01/2017-10-09"+socceramaAPI)!
        //let reqUrl = URLRequest(url: url)
        
        Alamofire.request(url, method: .get)
            .responseJSON { response in
                switch response.result {
                case .success:
                    let jsonData = JSON(data: response.data!)
                    completion(jsonData)
                case .failure(let error):
                    print("hiba")
                    print(error)
                }
        }
    }
    
    
}
