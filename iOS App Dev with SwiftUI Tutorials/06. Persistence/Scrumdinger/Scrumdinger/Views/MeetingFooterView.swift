//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Kim, Min Ho on 2021/01/24.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers: [ScrumTimer.Speaker]
    
    var skipAction: () -> Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted }) else { return nil }
        return index + 1
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy { $0.isCompleted }
        // NOTE: - return speakers.dropLast().reduce(true) { $0 && $1.isCompleted }
    }
    
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "No more speakers" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                } else {
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(Text("Next speaker"))
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

struct MeetingFooterView_Previews: PreviewProvider {
    static var speakers = [
        ScrumTimer.Speaker(name: "Kim", isCompleted: false),
        ScrumTimer.Speaker(name: "Bill", isCompleted: false),
    ]
    static var previews: some View {
        MeetingFooterView(speakers: speakers, skipAction: {})
            .previewLayout(.sizeThatFits)
    }
}
