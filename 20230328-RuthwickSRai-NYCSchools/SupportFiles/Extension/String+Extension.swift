//
//  String+Extension.swift
//  20230328-RuthwickSRai-NYCSchools
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Foundation

extension String {
    /// - Returns: This function will fetch the address without coodinates from the API response
    func getAddressWithoutCoordinate() -> String{
        let address = self.components(separatedBy: "(")
        return address[0]
    }
}
