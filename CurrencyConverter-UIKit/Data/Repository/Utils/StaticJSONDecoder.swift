//
//  StaticJSONDecoder.swift
//  CurrencyConverter-UIKit
//
//  Created by winsen on 11/06/24.
//

import Foundation

struct StaticJSONDecoder {
    
    static func decode<T: Decodable>(file: String, type: T.Type) throws -> T {
        
        guard !file.isEmpty,
              let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw FileError.fileNotFound
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategyFormatters = [ DateFormatter.iso8601,
                                                   DateFormatter.lastUpdated,
                                                   DateFormatter.yearMonthDay ]
        return try decoder.decode(T.self, from: data)
    }
}

enum FileError: Error {
    case fileNotFound

    var description: String {
        switch self {
        case .fileNotFound:
            return "File not found"
        }
    }
}
