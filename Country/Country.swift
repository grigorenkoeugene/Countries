//
//  Country.swift
//  Task4
//
//  Created by Евгений Григоренко on 28.12.21.
//

import Foundation

struct Country: Codable {
    let name: NameCountry
    var flag: String?
}

struct NameCountry: Codable {
    let common: String
}

