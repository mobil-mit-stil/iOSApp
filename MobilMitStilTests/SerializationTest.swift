//
//  SerializationTest.swift
//  MobilMitStil
//
//  Created by Schimweg, Luca on 27/02/2021.
//

import XCTest

@testable import MobilMitStil

class SerializationTest: XCTestCase {

    func testExample() throws {
        let json = "{\"locations\": [{\"latitude\": 3.131, \"longitude\": 5.21}, {\"latitude\": 2.56, \"longitude\": 52.25212}], \"seats\": 5, \"preferences\": {\"smoker\": false, \"children\": false}}".data(using: .utf8)!
        let data = try JSONDecoder().decode(RideConfig.self, from: json)
        XCTAssertEqual(data.seats, 5)
    }

}
