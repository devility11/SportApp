//
//  AP_GetStanding.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2017. 10. 15..
//  Copyright © 2017. Norbert Czirjak. All rights reserved.
//

import Foundation


// Request URI: https://apifootball.com/api/?action=get_standings&league_id=62&APIkey=xxxxxxxxxxxxxx
class AP_GetStanding {
    var country_name : String = ""
    var league_id : Int = 0
    var league_name : String = ""
    var team_name : String = ""
    var overall_league_position : Int = 0
    var overall_league_payed : Int = 0
    var overall_league_W : Int = 0
    var overall_league_D : Int = 0
    var overall_league_L : Int = 0
    var overall_league_G : Int = 0
    var overall_league_GA : Int = 0
    var overall_league_PTS : Int = 0
    var home_league_position : Int = 0
    var home_league_payed : Int = 0
    var home_league_W : Int = 0
    var home_league_D : Int = 0
    var home_league_L : Int = 0
    var home_league_GF : Int = 0
    var home_league_GA : Int = 0
    var home_league_PTS : Int = 0
    var away_league_position : Int = 0
    var away_league_payed : Int = 0
    var away_league_W : Int = 0
    var away_league_D : Int = 0
    var away_league_L : Int = 0
    var away_league_GF : Int = 0
    var away_league_GA : Int = 0
    var away_league_PTS : Int = 0
}
