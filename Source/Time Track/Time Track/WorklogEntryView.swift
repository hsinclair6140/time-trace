//
//  WorklogEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 7/24/24.
//

import SwiftUI

struct WorklogEntryView: View {
    
    var entry = Entry()
    
    init(entryIn:Entry) {
        self.entry = entryIn
    }
    
    var body: some View {
        VStack{
            HStack{
                Text(entry.project + "-" + String(entry.ticket_num))
            }
            HStack{
                Text("Start Time: ")
                Text(DateTimeUtility.getTimeStringFromDate(date: entry.start))
            }
            HStack{
                Text("Duration: ")
                Text(String(entry.duration))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    WorklogEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
