//
//  SchoolDetailViewController.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import UIKit
import MapKit

class SchoolDetailViewController: UIViewController {

    @IBOutlet weak var detailView: UITableView!
    var schoolDetail = School()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = .black
        self.setupTableView()
    }
    
    func setupTableView(){
        self.detailView.rowHeight = UITableView.automaticDimension
        self.detailView.register(UINib(nibName: "DetailHeaderCell", bundle: nil),forCellReuseIdentifier: APPConstant.detailHeaderCellIdentifier)
        self.detailView.register(UINib(nibName: "SATScoreTableViewCell", bundle: nil),forCellReuseIdentifier: APPConstant.satScoreCellIdentifier)
        self.detailView.register(UINib(nibName: "SchoolOverViewCell", bundle: nil),forCellReuseIdentifier: APPConstant.schoolOverViewCellIdentifier)
        self.detailView.delegate = self
        self.detailView.dataSource = self
    }
    
    // MARK: - Redirect the user to apple maps
    @objc func navigateToAddress(_ sender: UIButton){
 
        guard let schoolLatitude = Double(schoolDetail.latitude ?? "") else { return  }
        guard let schoolLongitude = Double(schoolDetail.longitude ?? "") else { return  }
        
        
        let coordinate = CLLocationCoordinate2DMake(schoolLatitude, schoolLongitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary: nil))
        mapItem.name = "Destination"
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
    }
     
    // MARK: - Redirect the user to make a call
    @objc func callNumber(_ sender: UIButton){
 
        let schoolPhoneNumber = schoolDetail.schoolTelephoneNumber
        
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
 
        guard let schoolWebSite = schoolDetail.schoolWebsite else { return }
        guard let url = URL(string: "https://\(schoolWebSite)") else { return }
        UIApplication.shared.open(url)
    }
    

}
