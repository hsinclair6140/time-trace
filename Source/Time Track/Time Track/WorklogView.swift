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
    @StateObject var csv = WorklogCSV()
    
    var body: some View {
        
        NavigationSplitView {
            DatePicker(
                    "Worklog Day: ",
                     selection: $date,
                     displayedComponents: [.date]
            ).onChange(of: date, {
                totalHours=0
                csv.clear()})
            
            Gauge(value: totalHours/8.0) {
                Text(String(format: "Hours: %f", totalHours))
            }
            List {
                ForEach(entries) { entry in
                    if(DateTimeUtility.sameCalenderDay(date1: date, date2: entry.start)){
                        NavigationLink(destination: EditEntryView(entryIn:entry)) {
                            Label("\(entry.project)-\(String(entry.ticket_num)):  \(String(entry.duration))", systemImage: "plus")
                        }
                        .onAppear(perform: {
                            totalHours+=entry.duration
                            csv.addEntry(entry: entry)})
                    }
                }
                .onDelete(perform: deleteItems)
            }
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
    WorklogView().modelContainer(for: Entry.self, inMemory: true)
}
