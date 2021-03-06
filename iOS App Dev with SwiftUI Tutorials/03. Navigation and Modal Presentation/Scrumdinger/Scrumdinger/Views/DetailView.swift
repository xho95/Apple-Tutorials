//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/22.
//

import SwiftUI

struct DetailView: View {
    @State private var isPresented = false

    let scrum: DailyScrum
    
    var body: some View {
        List {
            Section(header: Text("Meeting Info")) {
                NavigationLink(destination: MeetingView()) {
                    Label("Start Meeting", systemImage: "timer")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                        .accessibilityLabel(Text("Start meeting"))
                }
                HStack {
                    Label("Length", systemImage: "clock")
                        .accessibilityLabel(Text("Meeting length"))
                    Spacer()
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                HStack {
                    Label("Color", systemImage: "paintpalette")
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(scrum.color)
                }
                .accessibilityElement(children: .ignore)
            }
            Section(header: Text("Attendees")) {
                ForEach(scrum.attendees, id: \.self) { attendee in
                    Label(attendee, systemImage: "person")
                        .accessibilityLabel(Text("person"))
                        .accessibilityValue(Text(attendee))
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        // NOTE: - "A button can be written with the label as the first argument."
        // NOTE: - "What is the difference between a navigationBarItems and a toolbar."
        .navigationBarItems(trailing: Button("Edit") {
            isPresented = true
        })
        .navigationTitle(scrum.title)
        // NOTE: - "fullScreenCover"
        .fullScreenCover(isPresented: $isPresented) {
            NavigationView {
                EditView()
                    .navigationTitle(scrum.title)
                    .navigationBarItems(leading: Button("Cancel") {
                        isPresented = false
                    }, trailing: Button("Done") {
                        isPresented = false
                    })
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailView(scrum: DailyScrum.data[0])
        }
    }
}
