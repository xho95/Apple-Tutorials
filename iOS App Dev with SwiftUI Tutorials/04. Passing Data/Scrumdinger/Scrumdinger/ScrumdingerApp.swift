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
            // @State might not update the views.
            // If you want to update views automatically, then it prefer to use @Published.
    @State private var scrums = DailyScrum.data
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
