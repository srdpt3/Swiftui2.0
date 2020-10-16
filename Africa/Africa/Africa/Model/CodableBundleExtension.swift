//
//  CodableBundleExtension.swift
//  Africa
//
//  Created by Dustin yang on 10/11/20.
//

import Foundation
extension Bundle {
    func decode<T: Codable>(_ file : String) -> T{
        // 1.Locate the json file
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError()
        }
        
        guard let data = try? Data(contentsOf : url) else {
            fatalError()
        }
        
        let decoder = JSONDecoder()
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError()
        }
        
        
        return loaded
    }
}
