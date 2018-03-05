//
//  LeagueMLVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 25..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit
import JTAppleCalendar

class LeagueMLVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet weak var calendar: JTAppleCalendarView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var googleAD: UIView!
    
    //Variables
    var testCalendar = Calendar.current
    let formatter = DateFormatter()
    var prePostVisibility: ((CellState, CalendarCell?)->())?
    var prepostHiddenValue = false
    var s_Date = ""
    
    //to pass the ctr value
    var valueToPass = ""
    var valueToDetail = SM_GetEventsByDate()
    var eventsData = [SM_GetEventsByDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.cloudsColor()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = UIColor.cloudsColor()
        //remove the separator line
        self.tableView.separatorStyle = .none
        
        self.calendar.backgroundColor = UIColor.white
        
        self.calendar.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        print("Selected date")
        print(s_Date)
        setup()
        let today =  Calendar.current.date(byAdding: .day, value: 0, to: Date())
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = formatter.string(from: today!)
        
        /*
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        self.tableView.refreshControl = refreshControl
        */
        
        getDataByDate(date: todayDateString)
        
    }
    
    @objc func refresh(refreshControl: UIRefreshControl){
        refreshControl.endRefreshing()
        print("a refreshben a date")
        print(self.s_Date)
        self.getDataByDate(date: self.s_Date)
        
    }
    
    func getDataByDate(date: String){
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        self.eventsData.removeAll()
        let sR = ServiceRequests()
        
        self.tableView.addSubview(activityIndicator)
        activityIndicator.frame = self.tableView.bounds
        activityIndicator.startAnimating()
        print("the match list data")
        print(smURL+"fixtures/date/\(date)"+smAPI+"&leagues=\(valueToPass)&include=localTeam,visitorTeam")
        sR.getData(url: smURL+"fixtures/date/\(date)"+smAPI+"&leagues=\(valueToPass)&include=localTeam,visitorTeam,comments") { response in
            
            //if we dont have any events for the day
            if(response["data"].arrayValue.isEmpty){
                var events = SM_GetEventsByDate()
                events.emptyMessage = "There is no events today"
                self.eventsData.append(events)
            }else {
                for item in response["data"].arrayValue {
                    print("a datzum az adat lekeresben")
                    print(date)
                    
                    var events = SM_GetEventsByDate()
                    events.awayT_name = item["visitorTeam"]["data"]["name"].stringValue
                    events.awayT_flag = item["visitorTeam"]["data"]["flag"].stringValue
                    events.localT_name = item["localTeam"]["data"]["name"].stringValue
                    events.localT_flag = item["localTeam"]["data"]["flag"].stringValue
                    
                    events.away_score = item["scores"]["visitorteam_score"].intValue
                    events.local_score = item["scores"]["localteam_score"].intValue
                    
                    events.time_status = item["time"]["status"].stringValue
                    events.time = item["time"]["minute"].intValue
                    events.match_id = item["id"].intValue
                    
                    events.starting_time = item["time"]["starting_at"]["time"].stringValue
                    
                    events.temperature = item["weather_report"]["temperature"]["temp"].stringValue
                    events.wind_speed = item["weather_report"]["wind"]["speed"].stringValue
                    events.weather_code = item["weather_report"]["code"].stringValue
                    events.weather_img = item["weather_report"]["icon"].stringValue
                    events.weather_clouds = item["weather_report"]["clouds"].stringValue
                    events.local_formation = item["formations"]["localteam_formation"].stringValue
                    events.away_formation = item["formations"]["visitorteam_formation"].stringValue
                    
                    events.homeActualStand = item["standings"]["localteam_position"].intValue
                    events.awayActualStand = item["standings"]["visitorteam_position"].intValue
                    for comment in item["comments"]["data"].arrayValue {
                        var comments = SM_GetComments()
                        comments.comment = comment["comment"].stringValue
                        comments.extra_minute = comment["extra_minute"].intValue
                        comments.fixture_id = comment["fixture_id"].intValue
                        comments.goal = comment["goal"].boolValue
                        comments.important = comment["important"].boolValue
                        comments.minute = comment["minute"].intValue
                        comments.order = comment["order"].intValue
                        events.comments.append(comments)
                    }
                    
                    self.eventsData.append(events)
                }
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            self.tableView.reloadData()
        }
    }
    
    private func setup() {
        
        //tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor.cloudsColor()
    }
    var rangeSelectedDates: [Date] = []
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        guard let startDate = visibleDates.monthDates.first?.date else {
            return
        }
    }
    
    func handleCellConfiguration(cell: JTAppleCell?, cellState: CellState) {
        handleCellSelection(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
        prePostVisibility?(cellState, cell as? CalendarCell)
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCell  else {
            return
        }
        
        if cellState.isSelected {
            myCustomCell.label.textColor = UIColor.black
        } else {
            myCustomCell.label.textColor = UIColor.gray
        }
    }
    
    // Function to handle the calendar selection
    func handleCellSelection(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CalendarCell else {return }
        
        if cellState.isSelected {
            for date in calendar.selectedDates {
                formatter.dateFormat = "yyyy-MM-dd"
                self.getDataByDate(date: formatter.string(from: date))
                //let selectedDate = formatter.string(from: date)
                self.s_Date = formatter.string(from: date)
                self.tableView.reloadData()
            }
        }
    }
}


extension LeagueMLVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numOfSections: Int = self.eventsData.count
        if numOfSections == 1 && !self.eventsData[0].emptyMessage.isEmpty
        {
            let noDataLabel: UILabel     = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text          = "No match for this date"
            noDataLabel.textColor     = UIColor.black
            noDataLabel.textAlignment = .center
            tableView.backgroundView  = noDataLabel
            tableView.separatorStyle  = .none
            numOfSections = 0
        }else {
          tableView.backgroundView = nil
            
        }
        
        return numOfSections
        
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //if we have only one match and it has an empty match then this will be the errorcell
        if self.eventsData.count == 1 && !self.eventsData[0].emptyMessage.isEmpty{
            return UITableViewCell()
        }
            
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LMLCell", for: indexPath) as? LMLCell {
            //remove the cell bg
            cell.backgroundColor = UIColor.clear
            let matchData = self.eventsData[indexPath.row]
            cell.updateUI(data: matchData)
            return cell
        }else {
            return UITableViewCell()
        }
    }
}


extension LeagueMLVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale
        
        let today =  Calendar.current.date(byAdding: .day, value: 0, to: Date())
        let start =  Calendar.current.date(byAdding: .day, value: -10, to: Date())
        let end =  Calendar.current.date(byAdding: .day, value: 10, to: Date())
        let todayD = formatter.string(from: today!)
        let startD = formatter.string(from: start!)
        let endD = formatter.string(from: end!)
        let todayDate = formatter.date(from: todayD)!
        let startDate = formatter.date(from: startD)!
        let endDate = formatter.date(from: endD)!
        print("a calendar setupban")
        print(todayDate)
        calendar.scrollToDate(todayDate)
        let parameters =  ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, calendar: testCalendar, generateInDates: .forFirstMonthOnly , generateOutDates: .off , firstDayOfWeek: .monday, hasStrictBoundaries: false )
        
        return parameters
    }
    
    func configureVisibleCell(myCustomCell: CalendarCell, cellState: CellState, date: Date) {
        
        myCustomCell.label.text = cellState.text
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = UIColor.flatGrayDark
            myCustomCell.label.textColor = UIColor.flatBlueDark
        } else {
            myCustomCell.backgroundColor = UIColor.flatWhite
            myCustomCell.label.textColor = UIColor.flatBlack
        }
        handleCellConfiguration(cell: myCustomCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! CalendarCell
        
        configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        
        //self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        (cell as! CalendarCell).label.text = cellState.text
        //handleCellConfiguration(cell: cell, cellState: cellState)
        let myCustomCell = cell as! CalendarCell
        configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellConfiguration(cell: cell, cellState: cellState)
        
    }
    
    
}
