//
//  DetailHeaderCell.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import UIKit

class DetailHeaderCell: UITableViewCell {

    @IBOutlet weak var schoolNameLbl: UILabel!
    @IBOutlet weak var addressLbl: UILabel!
    @IBOutlet weak var addressBtn: UIButton!
    @IBOutlet weak var phoneNumberLbl: UILabel!
    @IBOutlet weak var phoneNumberBtn: UIButton!
    @IBOutlet weak var webSiteLbl: UILabel!
    @IBOutlet weak var websiteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
