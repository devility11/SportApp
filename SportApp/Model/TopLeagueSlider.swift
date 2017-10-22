//
//  TopLeagueSlider.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 19..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import Foundation

struct TopLeagueSlider {
    
    let name : String
    let image : String
    let id : Int
    
    static func all() -> [TopLeagueSlider] {
        return [
            TopLeagueSlider(name: "Super Lig", image: "super_lig.png", id: 376),
            TopLeagueSlider(name: "Eredvise", image: "eredvise.png", id: 137)
        ]
    }
}
