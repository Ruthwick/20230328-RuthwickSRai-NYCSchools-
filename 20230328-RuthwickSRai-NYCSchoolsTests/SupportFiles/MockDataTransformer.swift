//
//  MockDataTransformer.swift
//  20230328-RuthwickSRai-NYCSchoolsTests
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Foundation

class MockDataTransformer {
    
    func fetchWithJsonData(_ schoolsData: Any) -> [School]?{
        guard let schoolsDictionaryArray = schoolsData as? [[String: Any]] else{
            return nil
        }
        var schoolModelArray = [School]()
        for schoolsDictionary in schoolsDictionaryArray{
            if let schoolModels = getInfoWithJSON(schoolsDictionary){
                schoolModelArray.append(schoolModels)
            }
        }
        return schoolModelArray
    }
    
    func getInfoWithJSON(_ json: [String: Any]) -> School?{
        if !json.isEmpty{
            let schoolData = School()
            if let dbnObj = json["dbn"] as? String{
                schoolData.dbn = dbnObj
            }
            
            if let schoolNameOnj = json["school_name"] as? String{
                schoolData.schoolName = schoolNameOnj
            }
            
            if let overviewParagraphObj = json["overview_paragraph"] as? String{
                schoolData.overviewParagraph = overviewParagraphObj
            }
            if let schoolAddressObj = json["location"] as? String{
                schoolData.schoolAddress = schoolAddressObj
            }
            
            if let schoolPhoneObj = json["phone_number"] as? String{
                schoolData.schoolTelephoneNumber = schoolPhoneObj
            }
            
            if let websiteObj = json["website"] as? String{
                schoolData.schoolWebsite = websiteObj
            }
            
            if let criticalRedaingObj = json["sat_critical_reading_avg_score"] as? String{
                schoolData.satCriticalReadingAvgScore = criticalRedaingObj
            }
            
            if let mathAvgObj = json["sat_math_avg_score"] as? String{
                schoolData.satMathAvgScore = mathAvgObj
            }
            
            if let wiritingAvjObj = json["sat_writing_avg_score"] as? String{
                schoolData.satWritinAvgScore = wiritingAvjObj
            }
            
            if let latiudeObj = json["latitude"] as? String{
                schoolData.latitude = latiudeObj
            }
            
            if let longitudeObj = json["longitude"] as? String{
                schoolData.longitude = longitudeObj
            }
            
            return schoolData
        }
        return nil
    }
    
}
