//
//  Worklog.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/10/24.
//

import SwiftUI
import SwiftData

struct Worklog: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]
    @State private var date = Date()
    @State private var totalHours = 0.0
    private let secondsInDay = 86400.0
    
    var body: some View {
        
        NavigationSplitView {
            DatePicker(
                    "Worklog Day: ",
                     selection: $date,
                     displayedComponents: [.date]
            ).onChange(of: date, {totalHours=0})
            
            Gauge(value: totalHours/8.0) {
                Text(String(format: "Hours: %f", totalHours))
            }
            List {
                ForEach(entries) { entry in
                    if(entry.start.timeIntervalSince(date) > -secondsInDay && entry.start.timeIntervalSince(date) < 0 ){
                        NavigationLink(destination: EditEntryView(entryIn:entry)) {
                            Label("\(entry.project)-\(String(entry.ticket_num)):  \(String(entry.duration))", systemImage: "plus")
                        }
                        .onAppear(perform: {totalHours+=entry.duration})
                    }
                }
                .onDelete(perform: deleteItems)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: AddEntryView()) {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(entries[index])
            }
        }
    }
}

#Preview {
    Worklog().modelContainer(for: Entry.self, inMemory: true)
}
