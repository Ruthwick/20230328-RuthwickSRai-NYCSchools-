//
//  SchoolListViewController.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import UIKit
import MapKit

class SchoolListViewController: UIViewController {
    
    @IBOutlet weak var listView: UITableView!
    
    let loaderView = LoadingView()
    var isDataLoading = true
    let searchController = UISearchController(searchResultsController: nil)
    var filteredSchoolList = [School]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loaderView.add(withText: "Loading...", into: self.view)
        self.setupSearchController()
        self.setupTableView()
        self.getSchoolList()
    }
    
    func setupSearchController(){
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Schools"
        searchController.searchBar.tintColor = UIColor.white
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
    }
    
    func setupTableView(){
        self.listView.rowHeight = UITableView.automaticDimension
        self.listView.register(UINib(nibName: "SchoolTableViewCell", bundle: nil),forCellReuseIdentifier: APPConstant.schoolListCellID)
        self.listView.delegate = self
        self.listView.dataSource = self
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if self.isDataLoading {
            return
        }
        filteredSchoolList = (APPConstant.shared.schoolList?.filter({( schools : School) -> Bool in
            return schools.schoolName!.lowercased().contains(searchText.lowercased())
        }))!
        
        listView.reloadData()
    }
    
    // MARK: - Redirect the user to apple maps
    @objc func navigateToAddress(_ sender: UIButton){
        
        var nycHighSchoolList: School
        
        if isFiltering() {
            nycHighSchoolList = filteredSchoolList[sender.tag]
        } else {
            nycHighSchoolList = APPConstant.shared.schoolList![sender.tag]
        }
        guard let schoolLatitude = Double(nycHighSchoolList.latitude ?? "") else { return  }
        guard let schoolLongitude = Double(nycHighSchoolList.longitude ?? "") else { return  }
        
        
        let coordinate = CLLocationCoordinate2DMake(schoolLatitude, schoolLongitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
     
    // MARK: - Redirect the user to make a call
    @objc func callNumber(_ sender: UIButton){
     
        var nycHighSchoolList: School
        
        if isFiltering() {
            nycHighSchoolList = filteredSchoolList[sender.tag]
        } else {
            nycHighSchoolList = APPConstant.shared.schoolList![sender.tag]
        }
        
        let schoolPhoneNumber = nycHighSchoolList.schoolTelephoneNumber
        
        if let url = URL(string: "tel://\(String(describing: schoolPhoneNumber))"), UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }else{
            let alertView = UIAlertController(title: "Error!", message: "Please run on a real device to call \(schoolPhoneNumber!)", preferredStyle: .alert)
            
            let okayAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            
            alertView.addAction(okayAction)
            
            self.present(alertView, animated: true, completion: nil)
        }
    }
    
    // MARK: - Redirect the user to safari to load website
    @objc func showWebsite(_ sender: UIButton){
     
        var schoolList: School
        
        if isFiltering() {
            schoolList = filteredSchoolList[sender.tag]
        } else {
            schoolList = APPConstant.shared.schoolList![sender.tag]
        }
        
        guard let schoolWebSite = schoolList.schoolWebsite else { return }
        guard let url = URL(string: "https://\(schoolWebSite)") else { return }
        UIApplication.shared.open(url)
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Pass the selected school with sat score to the destinatiion view controller
        if segue.identifier == APPConstant.schoolDetailSegue{
            let schoolDetailView = segue.destination as! SchoolDetailViewController
            if let details = sender as? School {
                schoolDetailView.schoolDetail = details
            }
        }
    }
    
}
