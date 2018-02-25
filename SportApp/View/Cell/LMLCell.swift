//
//  LMLCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 25..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class LMLCell: UITableViewCell {

    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var homeScoreLbl: UILabel!
    @IBOutlet weak var awayScorelbl: UILabel!
    @IBOutlet weak var homeTmLbl: UILabel!
    @IBOutlet weak var awayTmLbl: UILabel!
    
    @IBOutlet weak var cellBGView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateUI(data: SM_GetEventsByDate){
        
        cellBGView.backgroundColor = UIColor.flatBlueDark
        
        timeLbl.text = data.time_status
        homeScoreLbl.text = String(data.local_score)
        homeTmLbl.text = data.localT_name
        awayTmLbl.text = data.awayT_name
        awayScorelbl.text = String(data.away_score)
    }

}
