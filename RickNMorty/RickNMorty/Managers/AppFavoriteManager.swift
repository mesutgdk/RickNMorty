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

enum AppFavoriteManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys{
        static let favorites = "favorites"
    }
    
    static func updateWith(favoriteChar: AppCharacter,
                           actionType: ActionType,
                           completed: @escaping(AppError?)-> Void) {
        retriveFavorites { result in
            switch result {
            case .success(let favorites):
                var retrievedFollowers = favorites
                
                switch actionType {
                case .add:
                    guard !retrievedFollowers.contains(favoriteChar) else {
                        completed(.alreadyFavorited)
                        return
                    }
                    
                    retrievedFollowers.append(favoriteChar)
                    
                case .remove:
                    retrievedFollowers.removeAll {$0.name == favoriteChar.name}
                }
                
                completed(save(favorites: retrievedFollowers))
                
            case .failure(let error):
                completed(error)
            }
        }
    }
    
    // MARK: - takeing favorites from defaults

    static func retriveFavorites(completed: @escaping (Result<[AppCharacter], AppError>)-> Void){
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completed(.success([]))
            return
        }
        do{
            let decoder = JSONDecoder()
            
            let favorites = try decoder.decode([AppCharacter].self, from: favoritesData)
            
            
            completed(.success(favorites)) // işlem başarılı, decode ettiğimizi yukarı atıyoruz
        } catch{
            completed(.failure(.unableToFavorite))
        }
    }
    
    // MARK: - saving favorites to defaults
    
    static func save(favorites: [AppCharacter])-> AppError?{
        
        do{
            let encoder = JSONEncoder()
            let encodedFavorite = try encoder.encode(favorites)
            
            defaults.set(encodedFavorite, forKey: Keys.favorites)
            return nil
        }
        catch {
            return AppError.unableToFavorite
        }
    }

}
