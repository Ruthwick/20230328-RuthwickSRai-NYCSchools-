//
//  _0230328_RuthwickSRai_NYCSchoolsTests.swift
//  20230328-RuthwickSRai-NYCSchoolsTests
//
//  Created by Ruthwick S Rai on 27/03/23.
//

import XCTest
@testable import _0230328_RuthwickSRai_NYCSchools

final class _0230328_RuthwickSRai_NYCSchoolsTests: XCTestCase {

    
    private var mockURL: String {
        "https://www.google.com"
    }
    
    func testSchoolListMockJSONData() async throws {
        let mockEngine = MockAPIEngine()
        mockEngine.mockData = try Mocks.schoolList.getData()
        mockEngine.sendRequest(mockURL, onCompletion: { response, error in
            let schoolList = MockDataTransformer().fetchWithJsonData(response)
            XCTAssertEqual(schoolList!.count, 440) // 440 is the total number of school in the list
        })
    }
}
