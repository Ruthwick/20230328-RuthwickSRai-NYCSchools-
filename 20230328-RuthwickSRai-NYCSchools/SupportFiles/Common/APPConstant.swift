//
//  APPConstant.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import Foundation

class APPConstant: NSObject {
    static let shared = APPConstant()
    static let schoolListAPIURL = "https://data.cityofnewyork.us/resource/s3k6-pzi2.json"
    static let schoolDetailAPIURL = "https://data.cityofnewyork.us/resource/f9bf-2cp4.json"
    static let schoolListCellID = "schoolList"
    static let schoolDetailSegue = "detailSegue"
    static let detailHeaderCellIdentifier =  "detailHeaderCellIdentifier"
    static let satScoreCellIdentifier = "satScoreCellIdentifier"
    static let schoolOverViewCellIdentifier = "schoolOverViewCellIdentifier"
    static let noSATScoreFound = "School SAT scores not found"
    var schoolList: [School]?
}
