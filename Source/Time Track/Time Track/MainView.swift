//
//  MainView.swift
//  Time Track
//
//  Created by Heath Sinclair on 6/10/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {

            WorklogView()
                .tabItem {
                    Label("Worklog", systemImage: "book.fill")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MainView().modelContainer(for: Entry.self, inMemory: true)
}
