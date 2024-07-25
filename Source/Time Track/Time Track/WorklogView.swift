//
//  Worklog.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/10/24.
//

import SwiftUI
import SwiftData

struct WorklogView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var entries: [Entry]
    @State private var date = Date()
    @State private var totalHours = 0.0
    private let secondsInDay = 86400.0
    @State private var entriesForDay: [Entry] = []
    @StateObject var csv = WorklogCSV()
    
    var body: some View {
        
        NavigationSplitView {
            DatePicker(
                    "",
                     selection: $date,
                     displayedComponents: [.date]
            ).onChange(of: date, {
                updateList()
                csv.clear()})
            
            Gauge(value: totalHours/8.0) {
                Text(String(format: "Hours: %f", totalHours))
            }
            List {
                ForEach(entriesForDay) { entry in
                    NavigationLink(destination: EditEntryView(entryIn:entry)) {
                        WorklogEntryView(entryIn: entry)
                    }
                    .onAppear(perform: {
                        csv.addEntry(entry: entry)})
                }
                .onDelete(perform: deleteItems)
            }
            .onAppear(perform: {
                updateList()
                csv.clear()
                })
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
                ToolbarItem {
                    NavigationLink(destination: ExportView(csv: csv)) {
                        Label("", systemImage: "square.and.arrow.up")
                    }
                }
                ToolbarItem {
                    NavigationLink(destination: EditEntryView(date:date)) {
                        Label("Add Item", systemImage: "plus")
                            .onTapGesture {
                                print("tapped Label")
                            }
         
                    }
                    .onTapGesture {
                        print("tapped NavigationLink")
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
        updateList()
    }
    
    private func updateList() {
        if (entries.count > 0){
            let entriesUtility = EntriesUtility(entries: entries)
            entriesForDay = entriesUtility.getEntriesForDay(date: date)
            totalHours = entriesUtility.getTotalHoursForDay()
        }
        else{
            totalHours = 0
        }
    }
    
}

#Preview {
    WorklogView().modelContainer(for: Entry.self, inMemory: true)
}
