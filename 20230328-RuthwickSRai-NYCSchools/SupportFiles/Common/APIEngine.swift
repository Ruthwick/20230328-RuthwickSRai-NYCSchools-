//
//  APIEngine.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import Foundation
 
class APIEngine {
    
    static let shared = APIEngine()
    let session: URLSession
    
    init(configuration: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.session = URLSession(configuration: configuration)
    }
    
    func sendRequest(_ apiURL: String, onCompletion complete: @escaping CompletionHandler){
        
        guard let urlString = URL(string: apiURL) else {
            complete("", nil)
            return
        }
        
        let request = URLRequest(url:urlString)
        let task = session.dataTask(with: request) { (data, response, error) in
            if data != nil{
                do{
                    let dataObj = try JSONSerialization.jsonObject(with: data!, options: [])
                    complete(dataObj, error)
                }catch{
                    debugPrint("API request failed")
                    complete("", error)
                }
            }
        }
        task.resume() 
    }
}
