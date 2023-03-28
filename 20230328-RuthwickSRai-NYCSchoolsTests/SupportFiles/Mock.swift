//
//  Mock.swift
//  20230328-RuthwickSRai-NYCSchoolsTests
//
//  Created by Ruthwick S Rai on 28/03/23.
//

import Foundation

enum Mocks: String {
    case schoolList = "SchoolListResponse.json"
    case schoolDetail = "SchoolDetailListResponse.json"

    var fileURL: URL {
        let thisSourceFile = URL(fileURLWithPath: #file)
        let thisDirectory = thisSourceFile.deletingLastPathComponent()
        return thisDirectory.appendingPathComponent("MocksResponse/\(self.rawValue)")
    }

    func getData() throws -> Data {
        return try Data(contentsOf: self.fileURL)
    }

    func getDictionary() throws -> [String: AnyHashable] {
        let data = try Data(contentsOf: self.fileURL)
        return try JSONSerialization.jsonObject(with: data) as! [String: AnyHashable]
    }
}
