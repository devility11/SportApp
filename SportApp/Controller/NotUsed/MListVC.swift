//
//  MListVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 01. 31..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit
import FoldingCell
import JTAppleCalendar

class MListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK : Calendar View Stuff
    @IBOutlet weak var calendar: JTAppleCalendarView!
    var testCalendar = Calendar.current
    let formatter = DateFormatter()
    var prePostVisibility: ((CellState, CalendarCell?)->())?
    var prepostHiddenValue = false
    var s_Date = ""
    
    // MARK : FoldingCell options
    let kCloseCellHeight: CGFloat = 179
    let kOpenCellHeight: CGFloat = 488
    let kRowsCount = 10
    var cellHeights: [CGFloat] = []
    
    //to pass the ctr value
    var valueToPass = ""
    var valueToDetail = SM_GetEventsByDate()
    var eventsData = [SM_GetEventsByDate]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        //remove the separator line
        self.tableView.separatorStyle = .none
        
        print("Selected date")
        print(s_Date)
        self.calendar.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
        setup()
        let today =  Calendar.current.date(byAdding: .day, value: 0, to: Date())
        formatter.dateFormat = "yyyy-MM-dd"
        let todayDateString = formatter.string(from: today!)
        
        
        getDataByDate(date: todayDateString)
        
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
                    print(date)
                    print(item)
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
            activityIndicator.removeFromSuperview()
            self.tableView.reloadData()
        }
    }

    private func setup() {
        cellHeights = Array(repeating: kCloseCellHeight, count: kRowsCount)
        tableView.estimatedRowHeight = kCloseCellHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
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


// MARK: - TableView
extension MListVC {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.eventsData.count
    }
    
     func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard case let cell as DemoCell = cell else {
            return
        }
        
        let matchData = self.eventsData[indexPath.row]
        cell.updateUI(data: matchData)
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == kCloseCellHeight {
            cell.unfold(false, animated: false, completion: nil)
            //cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
            //cell.selectedAnimation(true, animated: false, completion: nil)
        }
        //cell.number = indexPath.row
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! FoldingCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        return cell
    }
    
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //if there is no event then we are disabling the clicking and folding :)
        if(!self.eventsData[indexPath.row].emptyMessage.isEmpty){
            return
        }
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == kCloseCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.unfold(true, animated: true, completion: nil)
            //cell.selectedAnimation(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.unfold(false, animated: true, completion: nil)
            //cell.selectedAnimation(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
    }
}


extension MListVC: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
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
       
        calendar.scrollToDate(todayDate)
        let parameters =  ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 1, calendar: testCalendar, generateInDates: .forFirstMonthOnly , generateOutDates: .off , firstDayOfWeek: .monday, hasStrictBoundaries: false )
        
        return parameters
    }
    
    func configureVisibleCell(myCustomCell: CalendarCell, cellState: CellState, date: Date) {
        
        myCustomCell.label.text = cellState.text
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = UIColor.red
        } else {
            myCustomCell.backgroundColor = UIColor.yellow
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
