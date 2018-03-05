//
//  ErrorCell.swift
//  SportApp
//
//  Created by Norbert Czirjak on 2018. 02. 07..
//  Copyright © 2018. Norbert Czirjak. All rights reserved.
//

import UIKit

class ErrorCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateUI(){
        print("no data a cellben")
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 160, y: 285)
        label.textAlignment = .center
        label.text = "There is no match for this date"
        addSubview(label)
    }

}
