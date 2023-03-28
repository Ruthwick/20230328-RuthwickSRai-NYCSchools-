//
//  SchoolListViewExtension.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import Foundation
import UIKit

extension SchoolListViewController: UISearchResultsUpdating, UITableViewDataSource, UITableViewDelegate  {
    
    // MARK: - API call to get the school list
    
    func getSchoolList(){
        APIEngine.shared.sendRequest(APPConstant.schoolListAPIURL, onCompletion: { response, error in
            let schoolList = self.fetchWithJsonData(response)
            APPConstant.shared.schoolList = schoolList
            DispatchQueue.main.async {
                self.loaderView.dismissLoadingView()
                self.listView.reloadData()
                self.isDataLoading = false
            }
            self.getSchoolDetail()
        })
    }
    
    // MARK: - API call to get the school details
    
    private func getSchoolDetail(){
        APIEngine.shared.sendRequest(APPConstant.schoolDetailAPIURL, onCompletion: { response, error in
            self.addDetailToExistingSchoolData(response)
        })
    }
    
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }

// MARK: UITableViewDataSource and UITableViewDelegate Extensions
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return self.filteredSchoolList.count
        }
        
        return APPConstant.shared.schoolList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = self.listView.dequeueReusableCell(withIdentifier: APPConstant.schoolListCellID, for: indexPath) as! SchoolTableViewCell

        var schoolList: School
        
        if isFiltering() {
            schoolList = filteredSchoolList[indexPath.row]
        } else {
            schoolList = APPConstant.shared.schoolList![indexPath.row]
        }
        
        
        if let schoolName = schoolList.schoolName {
            cell.schoolNameLbl.text = schoolName
        }
        
        if let schoolAddr = schoolList.schoolAddress {
            let address = schoolAddr.getAddressWithoutCoordinate()
            cell.schoolAddrLbl.text = "Address: \(address)"
            
            cell.navigateToAddrBtn.tag = indexPath.row
            cell.navigateToAddrBtn.addTarget(self, action: #selector(self.navigateToAddress(_:)), for: .touchUpInside)
        }
        
        if let phoneNum = schoolList.schoolTelephoneNumber{
            cell.schoolPhoneLbl.text = phoneNum

            cell.schoolPhoneNumBtn.tag = indexPath.row
            cell.schoolPhoneNumBtn.addTarget(self, action: #selector(self.callNumber(_:)), for: .touchUpInside)
        }
        
        cell.schoolWebsiteBtn.tag = indexPath.row
        cell.schoolWebsiteBtn.addTarget(self, action: #selector(self.showWebsite(_:)), for: .touchUpInside)
        
        return cell
    }
    
    //MARK: - UITable View Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        var schoolList: School
        
        if isFiltering() {
            schoolList = filteredSchoolList[indexPath.row]
        } else {
            schoolList = APPConstant.shared.schoolList![indexPath.row]
        }
         
        self.performSegue(withIdentifier: APPConstant.schoolDetailSegue, sender: schoolList)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
}

// MARK: - School API data modifiers

extension SchoolListViewController {
    /// Pass the JSON and configure to the model type
    ///
    /// - Parameter schoolsData: Data of Array composed with Dictionary
    /// - Returns: Array of Model class
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
    
    
    /// This functions is used to fetch JSON payload and assign parameter to the Schools model
    ///
    /// - Parameter json: Dictionany with Schools Detail
    /// - Returns: School Model type
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
     
    func addDetailToExistingSchoolData(_ data: Any){
        guard let schoolDetailList = data as? [[String: Any]] else{
            return
        }
        
        for  schoolDetail in schoolDetailList{
            if let matchedDBN = schoolDetail["dbn"] as? String{
                
                guard let matchedSchools = APPConstant.shared.schoolList?.first(where: {$0.dbn == matchedDBN}) else{
                    continue
                }
                
                if let satReadingData =  schoolDetail["sat_critical_reading_avg_score"] as? String{
                    matchedSchools.satCriticalReadingAvgScore = satReadingData
                }
                
                if let satMathData = schoolDetail["sat_math_avg_score"] as? String{
                    matchedSchools.satMathAvgScore = satMathData
                }
                
                if let satWritingData =  schoolDetail["sat_writing_avg_score"] as? String{
                    matchedSchools.satWritinAvgScore = satWritingData
                }
                
                if let replacementIndex = APPConstant.shared.schoolList?.firstIndex(where: {$0.dbn == matchedDBN}) {
                    APPConstant.shared.schoolList?.remove(at: replacementIndex)
                    APPConstant.shared.schoolList?.insert(matchedSchools, at: replacementIndex)
                }
            }
        }
        
    }

}
