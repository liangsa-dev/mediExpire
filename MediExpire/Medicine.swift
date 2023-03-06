//
//  File.swift
//  Medexpire
//
//  Created by Sabrina Liang on 3/4/21.
//

import Foundation

class Medicine: Codable {
    var name: String
    var expiryDate: Date
    
    init (name: String, expiryDate: Date){
        self.name = name
        self.expiryDate = expiryDate
    }
}
