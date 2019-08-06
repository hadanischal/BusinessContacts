# BusinessContacts

## Goal:
* Create an iOS application implementing MVVM pattern in Swift which can run on iOS devices.
* It exhibit will a simple address book app to display business contacts. 
* User are able to scroll through the contacts and save favourite contacts.

## Instructions:
* Load contact from the following endpoint: https://gist.githubusercontent.com/pokeytc/ e8c52af014cf80bc1b217103bbe7e9e4/raw/4bc01478836ad7f1fb840f5e5a3c24ea654422f7/ contacts.json
* Display a control on the top of the screen to switch between All and Favourites. 
    * This selection must persist between launches. 
* Display alphabetically sorted contacts on screen with the following UI elements: first and last name, Favourite button, email address and generic avatar image (different for male and female). 
* The contacts must be displayed in a one column layout when the device trait collection horizontal size class is Compact.
* The contacts must be displayed in a two column layout when the device trait collection horizontal size class is Regular.
* Initially, up to 20 contacts must be displayed on screen followed by 'Show more' button. 'Show more' button adds up to 20 more contacts with appropriate animation. 
* The favourites must persist between launches `todo`.

## Expectations:
* The code written by yourself must be Swift.
* Usage of other third-party APIs/libraries/frameworks is not permitted.
* Please refrain from the use of storyboards or xib files for the purposes of this exercise `todo`. 
* The code must be written to support iOS9+ and all the devices that includes.
* You are expected to include unit tests where appropriate.
* You can use XCTest or any other testing framework you prefer. 
* Some examples of the use of size classes must be included.
* You are expected to include Git history and follow the same Git methodology and process as if you were working with others.
* Your project should build with the newest version of Xcode available at the time of your submission.
* Include a brief description of your design goals and any tradeoffs or compromises you made in your README file.

## TODO
* refrain the use of storyboards or xib file
* The favourites must persist between launches

# Ouput Screen
- All contact

![Alt text](/ScreenShots/screenshot-1.png?raw=true "All contact")

- Favourites contact

![Alt text](/ScreenShots/screenshot-2.png?raw=true "All contact")

- All contact landscape

![Alt text](/ScreenShots/screenshot-3.png?raw=true "All contact")

- Favourites contact landscape

![Alt text](/ScreenShots/screenshot-4.png?raw=true "All contact")

- Viewmodel

![Alt text](/ScreenShots/screenshot-5.png?raw=true "All contact")