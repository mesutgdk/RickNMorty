//
//  AppCharacterViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import UIKit

final class AppCharacterDetailedViewViewModel{
    
    private let character: AppCharacter
    
    enum SectionType {
        case photo(viewModel: AppCharacterPhotoCollectionViewCellViewModel)
        
        case information(viewModels: [AppCharacterInfoCollectionViewCellViewModel])
        
        case episodes(viewModels: [AppCharacterEpisodeCollectionViewCellViewModel])
        
    }
    
    public var section: [SectionType] = []
    
    // MARK: - Init

    
    init(character: AppCharacter) {
        self.character = character
        setUpSections()
    }
    private func setUpSections(){
        section = [
            .photo(viewModel: .init(imageUrl: URL(string: character.image))),
            .information(viewModels: [
                .init(type:.status, value: character.status.text),
                .init(type:.gender, value: character.gender.rawValue),
                .init(type:.type, value: character.type),
                .init(type:.specias, value: character.species),
                .init(type:.origin, value: character.origin.name),
                .init(type:.location, value: character.location.name),
                .init(type:.created, value: character.created),
                .init(type:.episodeCount, value: "\(character.episode.count)")
            ]),
            .episodes(viewModels: character.episode.map ({
                return AppCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0))
            }))
        ]
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
