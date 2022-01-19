//
//  Country.swift
//  Task4
//
//  Created by Евгений Григоренко on 28.12.21.
//

import Foundation

struct Country: Codable {
    let name: CountryName
    let flags: CountryFlag
}

struct CountryName: Codable {
    let common: String
}

struct CountryFlag: Codable {
    let png: String
}

