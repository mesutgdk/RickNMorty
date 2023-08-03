//
//  AppCharacterViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import UIKit

final class AppCharacterDetailedViewViewModel{
    
    private let character: AppCharacter
    
    enum SectionType: CaseIterable {
        case photo
        case information
        case episodes
    }
    
    public let section = SectionType.allCases
    
    // MARK: - Init

    
    init(character: AppCharacter) {
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    public var title: String {
        character.name.uppercased()
    }
    // MARK: -  Layout
    
  func createPhotoSectionLayout() -> NSCollectionLayoutSection {
     let item = NSCollectionLayoutItem(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(1.0)
         )
     )
     item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0) // layout of cell
     
     let group = NSCollectionLayoutGroup.vertical(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .fractionalHeight(0.5)  // fractionalheight 0.5 demek ekranın yarısı
         ),
         subitems: [item]
     )
     let section = NSCollectionLayoutSection(group: group)
     return section
 }
 
  func createInfoSectionLayout() -> NSCollectionLayoutSection {
     let item = NSCollectionLayoutItem(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(0.5),
             heightDimension: .fractionalHeight(1.0)
         )
     )
     item.contentInsets = NSDirectionalEdgeInsets(
         top: 2,
         leading: 2,
         bottom: 5,
         trailing: 2) // layout of cell
     
     let group = NSCollectionLayoutGroup.horizontal(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1.0),
             heightDimension: .absolute(150)  // height of cell
         ),
         subitems: [item, item]
     )
     let section = NSCollectionLayoutSection(group: group)
     return section
 }
 
  func createEpisodeSectionLayout() -> NSCollectionLayoutSection {
     let item = NSCollectionLayoutItem(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(1),
             heightDimension: .fractionalHeight(1.0)
         )
     )
     item.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 2, bottom: 5, trailing: 2) // layout of cell
     
     let group = NSCollectionLayoutGroup.horizontal(
         layoutSize: NSCollectionLayoutSize(
             widthDimension: .fractionalWidth(0.5),
             heightDimension: .absolute(150)  // height of cell
         ),
         subitems: [item]
     )
     let section = NSCollectionLayoutSection(group: group)
     section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary // to scroll the section
     return section
 }
}
