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
    
    func testRemoveSeconds1() throws {
        let dayInSeconds = 86400.0
        let date = Date(timeIntervalSinceReferenceDate: dayInSeconds+10)
        let newDate = Time_Track.DateTimeUtility.removeSeconds(date: date)
        XCTAssertEqual(newDate.timeIntervalSinceReferenceDate, dayInSeconds)
    }
    
    func testRemoveSeconds2() throws {
        let dayInSeconds = 86400.0
        let minuteInSeconds = 60.0
        let date = Date(timeIntervalSinceReferenceDate: dayInSeconds+5*minuteInSeconds+30.0)
        let newDate = Time_Track.DateTimeUtility.removeSeconds(date: date)
        XCTAssertEqual(newDate.timeIntervalSinceReferenceDate, dayInSeconds+5*minuteInSeconds)
    }
    
    func testGetDateFromString1() throws {
        let day = 86400.0
        let hr = 3600.0
        let min = 60.0
        let date = Date(timeIntervalSinceReferenceDate: 10*day + 5*hr + 30*min)
        let dateString = "Jan 11, 2001 at 5:30AM"
        let convertedDate = Time_Track.DateTimeUtility.getDateFromString(dateString: dateString)
        XCTAssertEqual(convertedDate, date)
    }
}
