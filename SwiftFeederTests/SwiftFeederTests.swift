//
//  SwiftFeederTests.swift
//  SwiftFeederTests
//
//  Created by Rick Windham on 6/9/15.
//  Copyright (c) 2015 Rick Windham. All rights reserved.
//

import UIKit
import XCTest

class SwiftFeederTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDataSourceLoad() {
        var expectation = self.expectationWithDescription("Fetch Feed")
        let dataSource = ListDataSource() { count in
            XCTAssertEqual(count, 50, "Bad Fetch")
            expectation.fulfill()
        }
        
        self.waitForExpectationsWithTimeout(5.0, handler: nil)
    }
    
    
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        self.measureBlock() {
//            // Put the code you want to measure the time of here.
//        }
//    }
    
}
