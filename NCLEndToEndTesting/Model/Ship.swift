//
//  Ship.swift
//  NCLEndToEndTesting
//
//  Created by Sevy, Michael on 8/4/21.
//

import Foundation

struct Ship: Codable {
    let shipName: String?
    let shipDescription: String?
    let bgeImagePath: String?
    let shipFacts: [String: String?]
    let whatsIncluded: [String]
}
