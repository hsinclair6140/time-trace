//
//  ContentView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        
        let onTheJobEntry = Entry()
        let _ = onTheJobEntry.setProject(project: "TEST")
        NavigationSplitView {
            GroupBox(label: Label("On the Job:", systemImage: "clock")) {
                if onTheJobEntry.project != "" {
                    LabeledContent("Job", value: "\(onTheJobEntry.project)-\(String(onTheJobEntry.ticket_num))")
                    LabeledContent("Duration", value: "\(String(onTheJobEntry.duration))")
                } else {
                    LabeledContent("", value: "Not Clocked In")
                }
            }
            GroupBox(label: Label("Favorites:", systemImage: "star")){
                let fm = FavoritesManager()
                let favorites = fm.getTickets()
                List(favorites) { favorite in
                    Text(favorite.ticket)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        EditButton()
                    }
                    ToolbarItem {
                        NavigationLink(destination: EditEntryView(entryIn:Entry())) {
                            Label("Add Item", systemImage: "plus")
                        }
                    }
                }
            }
        } detail: {
            Text("Select an item")
        }
    }
    private func deleteItems(offsets: IndexSet) {
        
    }
}

#Preview {

    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
