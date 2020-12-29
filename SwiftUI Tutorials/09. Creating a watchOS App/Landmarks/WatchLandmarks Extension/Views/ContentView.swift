//
//  ContentView.swift
//  WatchLandmarks Extension
//
//  Created by Kim, Min Ho on 2020/12/29.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        LandmarkList()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ModelData())
    }
}
