//
//  PointHistoryTableViewCell.swift
//  EatUpAll
//
//  Created by delma on 2020/07/17.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

class PointHistoryTableViewCell: UITableViewCell {

    @IBOutlet weak var historyImageView: UIImageView!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var projectLabel: UILabel!
    @IBOutlet weak var pointLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureData(_ data: PointHistory) {
        if data.pointOption == "기부" {
            historyImageView.image = UIImage(named: "coin")
        }else {
            historyImageView.image = UIImage(named: "sprout")
        }
        optionLabel.text = data.pointOption
        dateLabel.text = data.createdAt
        pointLabel.text = "\(data.ecoPoint)"
        guard let project = data.projectName else { return }
        projectLabel.text = project
    }
}
