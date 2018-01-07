//
//  SM_GetLeagues.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 01. 06..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import Foundation

//request url:
// https://soccer.sportmonks.com/api/v2.0/leagues?api_token=xxxx&include=country

class SM_GetLeagues {
    
    var league_id: Int = 0
    var country_id: Int = 0
    var name : String = ""
    var current_round_id : Int = 0
    var ctr_id : Int = 0
    var ctr_name : String = ""
    var ctr_flag : String = ""
    var is_cup : Bool = false
}
