//
//  Landmark.swift
//  Landmarks
//
//  Created by Kim, Min Ho on 2020/12/21.
//

import Foundation

struct Landmark: Hashable, Codable {
    var id: Int
    var name: String
    var park: String
    var state: String
    var description: String 
}
