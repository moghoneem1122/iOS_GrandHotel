//
//  Weather.swift
//  iOS_GrandHotel
//
//  Created by Mohammed on 01/08/2026.
//

import Foundation
import SwiftUI

struct Weather: Codable {
    let location: Location
    let current: Current
}
struct Location: Codable {
    let name: String
}
struct Current: Codable {
    let condition: Condition
let temp_c: Double
}
struct Condition: Codable {
    let text: String
    let code: Int
}
