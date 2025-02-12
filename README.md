# RickNMorty
This is a simple funny iOS application that displays information about characters from an American adult animated science fiction sitcom series, Rick and Morty. 
The app fetches data from the Rick and Morty API (https://rickandmortyapi.com)

## Architecture

This application follows the MVVM (Model-View-ViewModel) architecture pattern.
- Model      : The model layer is responsible for fetching and processing data from the API.
- View       : The view layer displays the data to the user and captures user input. 
- Model View : The view model layer acts as a mediator between the view and model layers, processing user input and providing data to the view layer.

## Features
- UIKit - Programmatically UI design
- It has high testability and readability with MVVM and Clean architecture.
- Cross-screen root control without using storyboard
- The images are kept in the cache with NSCache and the loading of the images is made easier 
- Repeated code blocks recommended for clean coding are combined in flexible methods
- Pagination structure is used to increase performance on list screens
- Ability to change list view with grid view in Run Time
- Dark Mode - Light Mode allowed
- Splash Screen with Opening
- In the application, the characters can be sorted and filtered according to the specified criteria.
- Color display of picture frames depending on whether the characters are alive or not.
- No 3rd-party framwork used
- Communicate with the API using URLSession
- Filtering Character by name
- Singleton Design Pattern/Dispatch Group/async-await/Diffable Data Sources

![splash](https://github.com/mesutgdk/RickNMorty/assets/112901255/7dad65b1-dfda-49c9-bd4b-11b6b4a950d0)
![charListToGrid](https://github.com/mesutgdk/RickNMorty/assets/112901255/bcdd629d-f59e-46e5-908e-da5fffe2f2aa)
![charDetail](https://github.com/mesutgdk/RickNMorty/assets/112901255/c4348f8d-0ae6-4aec-a60e-985ae76b593f)
![loc](https://github.com/mesutgdk/RickNMorty/assets/112901255/994e5edd-7e25-427e-aedd-88576ce9d385)
![locaDetail](https://github.com/mesutgdk/RickNMorty/assets/112901255/b43f5f19-7df1-4867-adcc-f25479b824c2)


![epiAndDetail](https://github.com/mesutgdk/RickNMorty/assets/112901255/f792d5d0-d60a-49bb-91e8-7ef908201083)
![set](https://github.com/mesutgdk/RickNMorty/assets/112901255/e9597bb9-5656-4add-85c8-ba8678a598f9)
![epiSearch](https://github.com/mesutgdk/RickNMorty/assets/112901255/688d6e8b-643c-42a2-b8c7-73fb1f767fcc)
![charSerch](https://github.com/mesutgdk/RickNMorty/assets/112901255/8d7c4b58-0f30-4b32-873b-8923375c4c29)
![locSearcj](https://github.com/mesutgdk/RickNMorty/assets/112901255/66cb2371-4222-4110-a3d0-2df8f63d6ea9)

## Updates
Favorite-Unfavorite - Now you can favorite your character.

![favoritechars-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/0bd624d9-419a-490c-bb36-978a1a1736a3)
![favoritedpage-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/5aa570c3-1727-43e5-9887-7a6b5ea578c5)
![deletion-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/8343c431-0ead-464c-ac69-e7bd81ca3ebc)





