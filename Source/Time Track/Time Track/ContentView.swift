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
    @State var onTheJobEntry = Entry(onTheJob:true)

    


    var body: some View {
        
        let timer = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: true) { timer in
            
            print(Date())
            let diffComponents = Calendar.current.dateComponents([.hour, .minute], from: onTheJobEntry.start, to: Date())
            let hours = Double(diffComponents.hour ?? 0)
            let min = Double(diffComponents.minute ?? 0)/60.0
            let duration = (hours + min) * 100.0
            
            print(duration.rounded() / 100.0)
        }
        
        NavigationView {
            Form {
                Section(header: Text("On the Job")){
                    GroupBox(label: Label("", systemImage: "none")) {
                        if onTheJobEntry.project != "" {
                            LabeledContent("Job", value: "\(onTheJobEntry.project)-\(String(onTheJobEntry.ticket_num))")
                            LabeledContent("Duration", value: "\(String(onTheJobEntry.duration))")
                        } else {
                            LabeledContent("", value: "Not Clocked In")
                        }
                    }
                    NavigationLink(destination: EditEntryView(entryIn: onTheJobEntry)) {
                        Label("Clock In/Out", systemImage: "clock")
                    }
                }
            }
        }
    }
    
}

#Preview {
    ContentView()
        .modelContainer(for: Entry.self, inMemory: true)
}
