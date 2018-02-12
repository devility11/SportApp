//
//  SM_GetEventsByDate.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 01. 07..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

//https://soccer.sportmonks.com/api/v2.0/fixtures/date/2017-12-08?api_token=0Kq0fmZYfls0twYy7JgA3ClWjtNMsBuabdLna4iKJIz6WEWfNSvnYLWl6X8I&leagues=271&include=localTeam,awayTeam

import Foundation

struct SM_GetEventsByDate {
    
    var match_id : Int = 0
    var legaue_id : Int = 0
    
    //weather
    var weather_code : String = ""
    var weather_img : String = ""
    var temperature : String = ""
    var wind_speed : String = ""
    var weather_clouds : String = ""
    
    //score
    var local_score : Int = 0
    var away_score : Int = 0
    var local_pen_score : Int = 0
    var away_pen_score : Int = 0
    
    //time
    var time : Int = 0
    var extra_time : Int = 0
    var time_status : String = ""
    var starting_date : String = ""
    var starting_time : String = ""
    
    // team additional info
    var local_formation : String = ""
    var away_formation : String = ""
    var localT_name : String = ""
    var awayT_name : String = ""
    var localT_flag : String = ""
    var awayT_flag : String = ""
    
    var emptyMessage : String = ""
    
    //actual standings
    var homeActualStand : Int = 0
    var awayActualStand : Int = 0
    
    var comments = [SM_GetComments]()
    
}
