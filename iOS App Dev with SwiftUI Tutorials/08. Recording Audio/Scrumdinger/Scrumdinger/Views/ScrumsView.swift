//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/21.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
    @Environment(\.scenePhase) private var scenePhase
    
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
            .onDelete { indices in
                scrums.remove(atOffsets: indices)
            }
        }
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button {
            isPresented = true
        } label: {
            Image(systemName: "plus")
        })
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newScrum =
                            DailyScrum(title: newScrumData.title,
                                       attendees: newScrumData.attendees,
                                       lengthInMinutes: Int(newScrumData.lengthInMinutes),
                                       color: newScrumData.color)
                        scrums.append(newScrum)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            if phase == .inactive { saveAction() }
        }
    }
    
    // NOTE: - A utility method to retrieve a binding from an indivitual scrum
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
