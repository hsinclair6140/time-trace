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
    @Query private var items: [Entry]

    var body: some View {
        NavigationSplitView {
            List {
                ForEach(items) { entry in
                    NavigationLink(destination: EditEntryView(entryIn:entry)) {
                        Label("\(entry.project)-\(String(entry.ticket)):  \(String(entry.duration))", systemImage: "plus")
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
                modelContext.delete(items[index])
            }
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
