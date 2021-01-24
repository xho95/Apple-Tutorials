//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/17.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                HStack {
                    Text("Speaker 1 or 3")
                    Spacer()
                    Button {
                        // TODO: something!
                    } label: {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(Text("Next speaker"))
                }
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
