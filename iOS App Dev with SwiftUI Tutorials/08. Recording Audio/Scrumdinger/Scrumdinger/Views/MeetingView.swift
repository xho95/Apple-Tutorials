//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/17.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    
    @StateObject var scrumTimer = ScrumTimer()
    
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                MeetingTimerView(speakers: scrumTimer.speakers, scrumColor: scrum.color)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        .onAppear {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                // NOTE: - Seeking to time .zero ensures the audio file always plays from the beginning.
                player.seek(to: .zero)
                player.play()
            }
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            let newHistory =
                History(attendees: scrum.attendees,
                        lengthInMinutes: scrumTimer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
