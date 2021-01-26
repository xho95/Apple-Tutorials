//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/17.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    // NOTE: - Creating the source of truth of this app
    //@State private var scrums = DailyScrum.data
    @ObservedObject private var data = ScrumData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                data.load()
            }
        }
    }
}
