//
//  SchoolTableViewCell.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    @IBOutlet var cardView: UIView!
    @IBOutlet var schoolNameLbl: UILabel!
    @IBOutlet var schoolAddrLbl: UILabel!
    @IBOutlet var schoolPhoneLbl: UILabel!
    @IBOutlet var schoolPhoneNumBtn: UIButton!
    @IBOutlet var navigateToAddrBtn: UIButton!
    @IBOutlet var schoolWebsiteBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.setupCardViewShadows()
    }

    func setupCardViewShadows(){
        self.cardView.layer.cornerRadius = 10
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.cardView.layer.shadowOpacity = 0.6
        self.cardView.layer.shadowRadius = 2
        self.cardView.layer.masksToBounds = false
    }

    
}
