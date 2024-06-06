//
//  Item.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import Foundation
import SwiftData

@Model
final class Item {
    var project = ""
    var ticket = 0
    var start = Date()
    var end = Date()
    var duration = 0.0
    var comment = ""
    
    init() {
    }
    
    func setStart(start:Date) {
        self.start = start
        self.duration = calcDuration(t1: self.start, t2: self.end)
    }
    
    func setEnd(end:Date) {
        self.end = end
        self.duration = calcDuration(t1: self.start, t2: self.end)
    }
    
    func calcDuration(t1: Date, t2: Date) -> Double {
        let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: t1, to: t2)
        let hours = Double(diffComponents.hour ?? 0)
        let min = Double(diffComponents.minute ?? 0)/60.0
        var duration = hours + min
        return duration.rounded()
    }
}
