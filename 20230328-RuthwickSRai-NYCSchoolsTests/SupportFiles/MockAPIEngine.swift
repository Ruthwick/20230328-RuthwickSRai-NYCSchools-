//
//  MockAPIEngine.swift
//  20230328-RuthwickSRai-NYCSchoolsTests
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Combine
import Foundation

class MockAPIEngine: APIEngine {
    
    typealias CompletionHandler = (Any, Error?) -> Void
    
    var mockData: Data? {
        didSet {
            guard mockData != nil else { return }
            mockFileURL = nil
            mockJSONDictionary = nil
        }
    }

    /// A local file URL for loading static JSON
    var mockFileURL: URL? {
        didSet {
            guard mockFileURL != nil else { return }
            mockData = nil
            mockJSONDictionary = nil
        }
    }

    var mockJSONDictionary: [String: AnyHashable]? {
        didSet {
            guard mockJSONDictionary != nil else { return }
            mockData = nil
            mockFileURL = nil
        }
    }

    // this is for requests that require an HTTP Response
    var mockHTTPResponse: HTTPURLResponse? 
    
    override func sendRequest(_ apiURL: String, onCompletion complete: @escaping CompletionHandler){
        guard let data = getMockData() else { return  complete("", nil) }
        do{
            let dataObj = try JSONSerialization.jsonObject(with: data, options: [])
            complete(dataObj, nil)
        }catch{
            debugPrint("API request failed")
            complete("", error)
        }
    }
    
    private func getMockData() -> Data? {
        return mockData ?? loadTestJSONFile() ?? loadJSONDictionaryData()
    }

    private func loadTestJSONFile() -> Data? {
        guard let mockURL = mockFileURL else { return nil }
        return try? Data(contentsOf: mockURL, options: .mappedIfSafe)
    }

    private func loadJSONDictionaryData() -> Data? {
        guard let dictionary = mockJSONDictionary else { return nil }
        do {
            return try JSONSerialization.data(withJSONObject: dictionary, options: .prettyPrinted)
        } catch {
            return nil
        }
    }
    
}
