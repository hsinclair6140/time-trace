//
//  EntriesUtilityTests.swift
//  Time TrackTests
//
//  Created by Heath Sinclair on 7/19/24.
//

import XCTest
@testable import Time_Track

final class EntriesUtilityTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testGetEntriesForDay1() throws {
        
        // set the hours since ref to 5.5 days
        let day = 86400.0
        let halfDay = day/2
        let dayUnderTest = (5*day)+halfDay
        
        let e1 = Time_Track.Entry()
        e1.setProject(project: "a")
        e1.setTicket(ticket: 1)
        e1.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e1.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e1.setComment(comment: "b")
        
        let e2 = Time_Track.Entry()
        e2.setProject(project: "b")
        e2.setTicket(ticket: 1)
        e2.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e2.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e2.setComment(comment: "b")
        
        let e3 = Time_Track.Entry()
        e3.setProject(project: "c")
        e3.setTicket(ticket: 1)
        e3.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e3.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e3.setComment(comment: "b")
        
        let enrties = [e1, e2, e3]
        
        let eu = Time_Track.EntriesUtility(entries: enrties)
        let entriesForDay = eu.getEntriesForDay(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        
        XCTAssertEqual(entriesForDay.count, 3)
    }
    
    func testGetEntriesForDay2() throws {
        
        // set the hours since ref to 5.5 days
        let day = 86400.0
        let halfDay = day/2
        let dayUnderTest = (5*day)+halfDay
        
        let e1 = Time_Track.Entry()
        e1.setProject(project: "a")
        e1.setTicket(ticket: 1)
        e1.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e1.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e1.setComment(comment: "b")
        
        let e2 = Time_Track.Entry()
        e2.setProject(project: "b")
        e2.setTicket(ticket: 1)
        e2.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e2.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e2.setComment(comment: "b")
        
        let e3 = Time_Track.Entry()
        e3.setProject(project: "c")
        e3.setTicket(ticket: 1)
        e3.setStart(date: Date(timeIntervalSinceReferenceDate: dayUnderTest+day))
        e3.setEnd(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        e3.setComment(comment: "b")
        
        let enrties = [e1, e2, e3]
        
        let eu = Time_Track.EntriesUtility(entries: enrties)
        let entriesForDay = eu.getEntriesForDay(date: Date(timeIntervalSinceReferenceDate: dayUnderTest))
        
        XCTAssertEqual(entriesForDay.count, 2)
    }

}
