//
//  AP_GetEvents.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 15..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import Foundation

// request uri: https://apifootball.com/api/?action=get_events&from=2016-10-30&to=2016-11-01&league_id=62&APIkey=xxxxxxxxxxxxxx
class AP_GetEvents {
    var match_id : Int = 0
    var country_id : Int = 0
    var country_name : String = ""
    var league_id : Int = 0
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

