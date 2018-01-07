//
//  SM_GetEvents.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 01. 07..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

// NOT IN USE
//https://soccer.sportmonks.com/api/v2.0/fixtures/date/YYYY-MM-DD?api_token=xxxx&leagues=number

import Foundation

class SM_GetEvents {
    var round_id : Int = 0
    var league_id : Int = 0
    var round_start : String = ""
    var round_end : String = ""
    
    //fixtures
    
    
    
    var country_id : Int = 0
    var country_name : String = ""
    
    var league_name : String = ""
    var match_date : String = ""
    var match_status : String = ""
    var match_time : String = ""
    var match_hometeam_name : String = ""
    var match_hometeam_score : String = ""
    var match_awayteam_name : String = ""
    var match_awayteam_score : String = ""
    var match_hometeam_halftime_score : String = ""
    var match_awayteam_halftime_score : String = ""
    var match_live : String = ""
}
