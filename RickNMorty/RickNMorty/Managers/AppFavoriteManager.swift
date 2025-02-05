//
//  AppFavoriteManager.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import Foundation

enum ActionType {
    case add
    case remove
}

enum UserDefaultsService {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static private func saveFavorites(favorites: [AppCombinedCharacter]) -> AppError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .alreadyFavorited
        }
    }
    
    static func getFavorites(completion: @escaping (Result<[AppCombinedCharacter], Error>) -> Void) {
        if let favoritesData = defaults.data(forKey: Keys.favorites) {
            do {
                let decoder = JSONDecoder()
                let favorites = try decoder.decode([AppCombinedCharacter].self, from: favoritesData)
                completion(.success(favorites))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(error))
            }
        } else {
            print("No data found for key \(Keys.favorites)")
            completion(.success([]))
        }
    }
    
    static func updateFavorites(favorite: AppCombinedCharacter, actionType: ActionType, completion: @escaping (AppError?) -> ()) {
        getFavorites { result in
            switch result {
            case .success(var favorites):
                switch actionType {
                case .add:
                    guard !favorites.contains(favorite) else {
                        completion(.alreadyFavorited)
                        return
                    }
                    favorites.append(favorite)
                case .remove:
                    favorites.removeAll { $0.name == favorite.name }
                }
                completion(saveFavorites(favorites: favorites))
            case .failure(_):
                completion(.unableToFavorite)
            }
        }
    }
}
