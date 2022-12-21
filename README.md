# Karaoke Song Organizer
###### Live: http://www.karaoke.justins-portfolio.live (mobile only)

## Description
This application allows the user to search thousands of songs via the Genius API to organize a playlist for your next karaoke night.  It automatically looks up the lyrics for your songs and saves them to a postgreSQL database for easy access in the future.  

Additionally, users are able to search and save karaoke stores either by nearby places or an address or name incase you find a great deal or amazing room setups.  After saving a location the app will use several Google APIs to provide a map to the store and its hours of operation.

The organization of the site was fairly straightforward, but the biggest difficulty I encountered when making this project was gathering the necessary information, especially lyric information.  It was difficult to find a free or cheaply priced API which provided full lyrics for the large number of songs I wanted to support.  In the end I used the HTTParty gem along with webscraping in order to get the lyrics from Genius.com.

## Technologies Used
- Ruby on Rails
- Tailwind
- PostgreSQL
- Minitest
- Javascript
- CSS
- HTML
- Dokku/DigitalOcean

## Live Previews

###### Adding a new song:
![newsong](https://user-images.githubusercontent.com/38001874/208096708-ead0a33c-e7db-45e2-b51e-69c7a9002b96.gif)

###### Adding a new place:
![addingnewplace](https://user-images.githubusercontent.com/38001874/208097044-61d99422-6b0c-4b26-951c-fec956a5f05b.gif)

## Methods of Obtaining Data

In this project I used several APIs and webscraping in order to get the song information, location information, and karaoke store information.  These methods include: 
- Google Directions API
- Google Geocoding API
- Google Geolocation API
- Google Maps Embed API
- Google Places API
- Genius API
- IP2Location API
- HTTParty
