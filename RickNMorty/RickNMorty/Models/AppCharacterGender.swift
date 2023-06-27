//
//  CharacterGender.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.06.2023.
//

import Foundation

enum AppCharacterGender: String, Codable {
    // "Female", "male", "Genderless" or "unknown"
    case male = "Male"
    case female = "Female"
    case genderless = "Genderlesss"
    case unknown = "Unknown"

}
