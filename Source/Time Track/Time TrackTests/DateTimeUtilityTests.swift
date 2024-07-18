//
//  DateTimeUtilityTests.swift
//  Time TrackTests
//
//  Created by Heath Sinclair on 7/18/24.
//

import XCTest
@testable import Time_Track

final class DateTimeUtilityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSameDayTrue1() throws {
        let d1 = Date(timeIntervalSinceReferenceDate: 1)
        let d2 = Date(timeIntervalSinceReferenceDate: 1)
        let isSameDay = Time_Track.DateTimeUtility.sameCalenderDay(date1: d1, date2: d2)
        XCTAssertTrue(isSameDay)
    }
    
    func testSameDayTrue2() throws {
        let d1 = Date(timeIntervalSinceReferenceDate: 1)
        let d2 = Date(timeIntervalSinceReferenceDate: 86340)
        let isSameDay = Time_Track.DateTimeUtility.sameCalenderDay(date1: d1, date2: d2)
        XCTAssertTrue(isSameDay)
    }
    
    func testSameDayFalse1() throws {
        let d1 = Date(timeIntervalSinceReferenceDate: 1)
        let d2 = Date(timeIntervalSinceReferenceDate: 86401)
        let isSameDay = Time_Track.DateTimeUtility.sameCalenderDay(date1: d1, date2: d2)
        XCTAssertFalse(isSameDay)
    }
    
    func testSameDayFalse2() throws {
        let d1 = Date(timeIntervalSinceReferenceDate: 86401)
        let d2 = Date(timeIntervalSinceReferenceDate: 1)
        let isSameDay = Time_Track.DateTimeUtility.sameCalenderDay(date1: d1, date2: d2)
        XCTAssertFalse(isSameDay)
    }

}
