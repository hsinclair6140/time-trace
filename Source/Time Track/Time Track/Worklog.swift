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

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(entries) { entry in
                    NavigationLink(destination: EditEntryView(entryIn:entry)) {
                        Label("\(entry.project)-\(String(entry.ticket_num)):  \(String(entry.duration))", systemImage: "plus")
                    }
                }
                .onDelete(perform: deleteItems)
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
