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
        //the navbar background color
        navigationController?.navigationBar.barTintColor = UIColor.flatBlueDark
        //the text color
        navigationController?.navigationBar.tintColor = UIColor.flatWhite
    }
    
    

}
