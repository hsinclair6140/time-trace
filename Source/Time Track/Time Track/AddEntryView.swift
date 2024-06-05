//
//  AddEntryView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/1/24.
//

import SwiftUI

struct AddEntryView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        
        var entry = Item()
        @State var project: String = "PTEAE"
        @State var ticket: String = ""
        @State var start = Date()
        @State var end = Date()
        @State var comment: String = ""
        NavigationSplitView{
            Form {
                
                Section(header: Text("Project")){
                    TextField("PTEAE", text: $project)
                }
                .keyboardType(UIKeyboardType.default)
                .onSubmit {
                    entry.project = project
                }
                
                Section(header: Text("Ticket")){
                    TextField("1234", text: $ticket)
                }
                .keyboardType(UIKeyboardType.numberPad)
                .onSubmit {
                    entry.ticket = Int(ticket)!
                }
                
                Section(header: Text("Time")){
                    DatePicker(selection: $start, label: { Text("Start") })
                        .onSubmit {
                            entry.start = start
                        }
                    DatePicker(selection: $end, label: { Text("End") })
                        .onSubmit {
                            entry.end = end
                        }
                }
                
                Section(header: Text("Comment")){
                    TextEditor(text: $comment)
                }
                .onSubmit {
                    entry.comment = comment
                }
                .keyboardType(UIKeyboardType.default)
                
            }
            Button("Save") {
                modelContext.insert(entry)
                self.presentationMode.wrappedValue.dismiss()

            }
//            NavigationLink(destination: ContentView()) {
//                Label("Add Entry", systemImage: "plus")
//            }
//            .simultaneousGesture(TapGesture().onEnded {
//                modelContext.insert(entry)
//            })
            
        } detail: {
            Text("Select an item")
        }
    }
}

#Preview {
    AddEntryView()
}
