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
                Text(entry.getProject() + "-" + String(entry.getTicket()))
            }
            HStack{
                Text("Start Time: ")
                Text(DateTimeUtility.getTimeStringFromDate(date: entry.getStart()))
            }
            HStack{
                Text("End Time: ")
                Text(DateTimeUtility.getTimeStringFromDate(date: entry.getEnd()))
            }
            HStack{
                Text("Duration: ")
                Text(String(entry.getDuration()))
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    WorklogEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
