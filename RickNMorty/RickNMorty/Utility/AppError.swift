//
//  AppError.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import Foundation

enum AppError: Error {
    case invalidUsername
    case cantHandleRequest
    case invalidResponce
    case invalidData
    case cantAuthorize
    case decodingError
    case unableToFavorite
    case alreadyFavorited
    
    var errorDescription: String {
        switch self {
        case .invalidUsername:
            return "This username created an invalid request. Please try again "
        case .cantHandleRequest:
            return "Unable to complete your request. Please check your internet connection. "
        case .invalidResponce:
            return "Invalid responce from the server. Please try again. "
        case .invalidData:
            return "The data received from the server was invalid, Please try again. "
        case .cantAuthorize:
            return "The request requires user authentication."
        case .decodingError:
            return "The data can not be decoded, Please try again. "
        case .unableToFavorite:
            return "There was a problem favoriting the user. Please try again."
        case .alreadyFavorited:
            return "You've allready favorited this user. You must REALLY like them!"
        }
    }
}
