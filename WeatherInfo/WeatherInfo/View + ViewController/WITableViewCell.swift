//
//  WITableViewCell.swift
//  WeatherInfo
//
//  Created by Ganesan, Veeramani on 10/10/21.
//

import UIKit

class WITableViewCell: UITableViewCell {
    @IBOutlet weak var stateImage   : UIImageView!
    @IBOutlet weak var cityLabel    : UILabel!
    @IBOutlet weak var dateLabel    : UILabel!
    @IBOutlet weak var stateLabel   : UILabel!
    @IBOutlet weak var minLabel     : UILabel!
    @IBOutlet weak var maxLabel     : UILabel!
    @IBOutlet weak var humLabel     : UILabel!
    @IBOutlet weak var windLabel    : UILabel!
}
