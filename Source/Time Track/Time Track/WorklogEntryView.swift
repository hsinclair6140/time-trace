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
                Text(entry.getProject() + "-" + String(entry.getTicket()) + ": ")
                    .foregroundStyle(.blue)
                Text(entry.getShortDescription())
                    .foregroundStyle(.green)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text(entry.getComment())
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            HStack{
                Text(DateTimeUtility.getTimeStringFromDate(date: entry.getStart()))
                    .foregroundStyle(.orange)
                Text(" - ")
                    .foregroundStyle(.orange)
                Text(DateTimeUtility.getTimeStringFromDate(date: entry.getEnd()))
                    .foregroundStyle(.orange)
                Text("(" + String(entry.getDuration()) + ")")
                    .foregroundStyle(.orange)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    WorklogEntryView(entryIn:Entry()).modelContainer(for: Entry.self, inMemory: true)
}
