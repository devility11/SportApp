//
//  MatchDetailVC.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 03. 07..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class MatchDetailVC: UIViewController {

    @IBOutlet weak var leagueNameLbl: UILabel!
    @IBOutlet weak var homeLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!    
    @IBOutlet weak var matchTimeLbl: UILabel!
    
    
    @IBOutlet weak var containerViewLive: UIView!
    @IBOutlet weak var containerViewStats: UIView!
    @IBOutlet weak var containerViewStandings: UIView!
    @IBOutlet weak var containerViewWeather: UIView!
    @IBOutlet weak var containerViewFormations: UIView!
    
    @IBAction func showComponent(_ sender: UISegmentedControl) {
        
        //stats
        if sender.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 1
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        
        //table
        if sender.selectedSegmentIndex == 1 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 1
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        //live
        if sender.selectedSegmentIndex == 2 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 1
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 0
            })
        }
        //weather
        if sender.selectedSegmentIndex == 2 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 1
                self.containerViewFormations.alpha = 0
            })
        }
        //formations
        if sender.selectedSegmentIndex == 2 {
            
            UIView.animate(withDuration: 0.5, animations: {
                self.containerViewLive.alpha = 0
                self.containerViewStandings.alpha = 0
                self.containerViewStats.alpha = 0
                self.containerViewWeather.alpha = 0
                self.containerViewFormations.alpha = 1
            })
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
