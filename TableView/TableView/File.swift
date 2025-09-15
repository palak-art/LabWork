//
//  File.swift
//  TableView
//
//  Created by Himanshi Godara on 21/08/25.
//

import Foundation

struct Emoji: Codable{
    var symbol: String
    var name: String
    var description: String
    var usage: String
}
extension Emoji {
    static let archiveURL: URL = {
        let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return documentsDirectory.appendingPathComponent("emojis").appendingPathExtension("plist")
    }()
}
extension Emoji {
    static func saveToFile(emojis: [Emoji]) {
        let encoder = PropertyListEncoder()
        if let data = try? encoder.encode(emojis) {
            try? data.write(to: Emoji.archiveURL, options: .noFileProtection)
        }
    }
    
    static func loadFromFile() -> [Emoji]? {
        guard let data = try? Data(contentsOf: Emoji.archiveURL) else { return nil }
        let decoder = PropertyListDecoder()
        return try? decoder.decode([Emoji].self, from: data)
    }}
