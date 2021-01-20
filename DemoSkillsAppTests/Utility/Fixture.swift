//
//  Fixture.swift
//  DemoSkillsAppTests
//
//  Created by Stephen O'Connor on 20.01.21.
//

import Foundation

class Fixture {
    
    static func loadJSON(_ fileName: String) -> Data {
        guard let url = Bundle(for: self).url(forResource: fileName, withExtension: nil) else { fatalError("Could not find .json file named \(fileName) in the test bundle.") }
        guard let json = try? Data(contentsOf: url) else { fatalError("Could convert .json file to Data.") }
        return json
    }
    
    static func decodeJSON<T: Codable>(fileName: String) -> (result: T?, error: Error?) {
        do {
            let data = Fixture.loadJSON(fileName)
            let result = try JSONDecoder().decode(T.self, from: data)
            return (result, nil)
        } catch {
            if let error = error as? DecodingError {
                print("error: \(error)")
            }
            return (nil, error)
        }
    }
}
