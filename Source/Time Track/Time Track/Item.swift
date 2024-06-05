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
    var comment = ""
    
    init() {
    }
}
