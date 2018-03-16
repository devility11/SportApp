//
//  BaseController.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 03. 16..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    //OVERWRITE THE loadview with the elastic load
    override func loadView() {
        super.loadView()
        
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        //navigationController?.navigationBar.barTintColor = UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0)
        navigationController?.navigationBar.barTintColor = UIColor.flatBlueDark
        
    }
    
    

}
