//
//  SchoolDetailViewExtension.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Foundation
import UIKit

extension SchoolDetailViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            let detailCell = self.detailView.dequeueReusableCell(withIdentifier: APPConstant.detailHeaderCellIdentifier, for: indexPath) as! DetailHeaderCell
            
            if let schoolName = schoolDetail.schoolName {
                detailCell.schoolNameLbl.text = schoolName
            }
            
            if let schoolAddr = schoolDetail.schoolAddress {
                let address = schoolAddr.getAddressWithoutCoordinate()
                detailCell.addressLbl.text = "\(address)"
                
                detailCell.addressBtn.tag = indexPath.row
                detailCell.addressBtn.addTarget(self, action: #selector(self.navigateToAddress(_:)), for: .touchUpInside)
            }
            
            if let phoneNum = schoolDetail.schoolTelephoneNumber{
                detailCell.phoneNumberLbl.text = phoneNum

                detailCell.phoneNumberBtn.tag = indexPath.row
                detailCell.phoneNumberBtn.addTarget(self, action: #selector(self.callNumber(_:)), for: .touchUpInside)
            }
            
            if let webiste = schoolDetail.schoolWebsite {
                detailCell.webSiteLbl.text = webiste
                detailCell.websiteBtn.tag = indexPath.row
                detailCell.websiteBtn.addTarget(self, action: #selector(self.showWebsite(_:)), for: .touchUpInside)
            }
            
            return detailCell
        case 1:
            if let readingScore = schoolDetail.satCriticalReadingAvgScore {
                let scoresCell = self.detailView.dequeueReusableCell(withIdentifier: APPConstant.satScoreCellIdentifier, for: indexPath) as! SATScoreTableViewCell
                 scoresCell.readingScoreLbl.text = "Critical Reading Score: \(readingScore)"
                
                if let mathScore = schoolDetail.satMathAvgScore {
                    scoresCell.mathScoreLbl.text = "Math Score: \(mathScore)"
                }
                
                if let writingScore = schoolDetail.satWritinAvgScore {
                    scoresCell.writingScoreLbl.text = "Writing Score: \(writingScore)"
                }
                
                return scoresCell
            }else {
                let emptyCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Cell")
                emptyCell.textLabel?.text = APPConstant.noSATScoreFound
                return emptyCell
            }
        default:
            let overViewCell = self.detailView.dequeueReusableCell(withIdentifier: APPConstant.schoolOverViewCellIdentifier, for: indexPath) as! SchoolOverViewCell
            
            if let overView = schoolDetail.overviewParagraph {
                overViewCell.overViewLbl.text = overView
            }
            
            return overViewCell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
