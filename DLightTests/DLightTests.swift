//
//  DLightTests.swift
//  DLightTests
//
//  Created by Zach Zeleznick on 3/15/16.
//  Copyright © 2016 zzeleznick. All rights reserved.
//

import XCTest
@testable import DLight

class DLightTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let Bob = Profile(name:"Bob", age: 20, diabetes: 2, activity: 0,intakeRestrictions: ["Sodium"], dietaryRestrictions: ["Pork"])
        print(Bob.dict)
        print("HELLO WORLD")
        print(Bob)
    }
    
    func testRestaurantConstruction() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        let restaurants = generateSampleRestaurants()
        print("HELLO WORLD")
        print(restaurants)
    }
    
    func testMenuConstruction() {
        let menu = generateSampleMenu()
        print(menu)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}
