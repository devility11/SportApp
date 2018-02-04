//
//  CalendarView.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 04..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarView: UIViewController {
 /*
    @IBOutlet weak var calendar: JTAppleCalendarView!
    
    var testCalendar = Calendar.current
    let formatter = DateFormatter()
    var prePostVisibility: ((CellState, CustomCell?)->())?
    var prepostHiddenValue = false
    var s_Date = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Selected date")
        print(s_Date)
        self.calendar.visibleDates {[unowned self] (visibleDates: DateSegmentInfo) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
        
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
        prePostVisibility?(cellState, cell as? CustomCell)
    }
    
    // Function to handle the text color of the calendar
    func handleCellTextColor(view: JTAppleCell?, cellState: CellState) {
        guard let myCustomCell = view as? CustomCell  else {
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
        guard let myCustomCell = view as? CustomCell else {return }
        
        if cellState.isSelected {
            for date in calendar.selectedDates {
                formatter.dateFormat = "yyyy-MM-dd"
                //let selectedDate = formatter.string(from: date)
                self.s_Date = formatter.string(from: date)
            }
        }
    }
    */
    
}
/*
extension ViewController: JTAppleCalendarViewDelegate, JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = testCalendar.timeZone
        formatter.locale = testCalendar.locale
        
        let start =  Calendar.current.date(byAdding: .day, value: -10, to: Date())
        let end =  Calendar.current.date(byAdding: .day, value: 10, to: Date())
        let startD = formatter.string(from: start!)
        let endD = formatter.string(from: end!)
        let startDate = formatter.date(from: startD)!
        let endDate = formatter.date(from: endD)!
        
        let parameters = ConfigurationParameters(startDate: startDate,
                                                 endDate: endDate,
                                                 numberOfRows: 1,
                                                 calendar: testCalendar
        )
        return parameters
    }
    
    func configureVisibleCell(myCustomCell: CustomCell, cellState: CellState, date: Date) {
        
        myCustomCell.label.text = cellState.text
        if testCalendar.isDateInToday(date) {
            myCustomCell.backgroundColor = UIColor.red
        } else {
            myCustomCell.backgroundColor = UIColor.yellow
        }
        handleCellConfiguration(cell: myCustomCell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        
        configureVisibleCell(myCustomCell: cell, cellState: cellState, date: date)
        
        //self.calendar(calendar, willDisplay: cell, forItemAt: date, cellState: cellState, indexPath: indexPath)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        (cell as! CustomCell).label.text = cellState.text
        //handleCellConfiguration(cell: cell, cellState: cellState)
        let myCustomCell = cell as! CustomCell
        configureVisibleCell(myCustomCell: myCustomCell, cellState: cellState, date: date)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellConfiguration(cell: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        self.setupViewsOfCalendar(from: visibleDates)
    }
}
*/
