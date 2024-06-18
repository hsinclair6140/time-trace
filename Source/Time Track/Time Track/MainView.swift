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
            ContentView()
                .tabItem {
                    Label("Job", systemImage: "play")
                }

            Worklog()
                .tabItem {
                    Label("Worklog", systemImage: "book.fill")
                }
        }
    }
}

#Preview {
    MainView().modelContainer(for: Entry.self, inMemory: true)
}
