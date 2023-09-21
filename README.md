# RickNMorty
This is a simple funny iOS application that displays information about characters from an American adult animated science fiction sitcom series, Rick and Morty. 
The app fetches data from the Rick and Morty API (https://rickandmortyapi.com)

## Architecture

This application follows the MVVM (Model-View-ViewModel) architecture pattern.
- Model      : The model layer is responsible for fetching and processing data from the API.
- View       : The view layer displays the data to the user and captures user input. 
- Model View : The view model layer acts as a mediator between the view and model layers, processing user input and providing data to the view layer.

## Features
- Programmatically UI design
- It has high testability and readability with MVVM and Clean architecture.
- Cross-screen root control without using storyboard
- The images are kept in the cache with NSCache and the loading of the images is made easier 
- Repeated code blocks recommended for clean coding are combined in flexible methods
- Pagination structure is used to increase performance on list screens
- Ability to change list view with grid view in Run Time
- Dark Mode - Light Mode allowed
- In the application, the characters can be sorted and filtered according to the specified criteria.

