Original App Design Project
===

# CrimeMap

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
This app allows users to interact and digest real - time crime data and police responses in their area. The interactive map allows users to view the location of the calls, allowing users to avoid areas of potential conflict, and monitor situations in real time. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Travel/Safety
- **Mobile:** Mobile
- **Story:** Allow user to check the criminal incident happening or happened recently.
             Allow user to report the criminal incident. 

- **Market:** Anyone who lives in NYC or is curious about NYC crime data can use this app. Users can check location and type of crime committed in the map. 
- **Habit:** Users can look at crime incidents that have happened throughout the day. Users can explore crime records in any area around the city. 
- **Scope:** The initial scope of the app(v1) is to read data from the api and create/display a map with indications of calls that refreshes appropriately. V2 entails the addition of being able to interact with the red dots - this would display more information about the incident. V3 includes the addition of user reports, where the user can report and incident and this is added to the map along with any media the user decides to upload.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* An interactive map that users can drag, zoom in on, etc.
* ...

**Optional Nice-to-have Stories**

* [fill in your required user stories here]
* ...

### 2. Screen Archetypes

* Map
   * Interactive Map
   * ...
* Table Section
   * ViewTable shows the crimal happened around you
   * ...

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* login tab 
* map tab 
* table tab
* post tab
* information tab

**Flow Navigation** (Screen to Screen)

* map screen
   * post tab
   * pop up information tab
   
* view table screen
   * information tab
   * post tab
* information/ detail screen
  * map tab (back)
  * table tab (back)

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://user-images.githubusercontent.com/62863377/161169734-2d85ee2d-3484-49a9-b862-cb0188eeeed1.jpg" width=600>


### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
|   Property     |     Type         | Description
| -------------- | ---------------- | -------------
| IncidentId     | String           | unique id for the incident
|   Creator      | Pointer to User  | incident creator
| IncidentDetail | String           | Detail informations of incidents
| updatedCount   | Number           | number of updated information
| commentsCount  | Number           | number of comments posted
| IncidentTime   | DateTime         | Time when the incident happened
| updatedTime    | DateTime         | Time when incident is last updated
### Networking
- Login Screen
  - (Create/POST) Create a new User
- Crime List Screen
  - (Read/GET) Query all crimes and data(including author)
- Map View Screen
  - (Read/GET) Query all crimes based on location
  -(Delete) Delete all old posts after a number of days
- Post Updates Screen
  - (Create/POST) Create a new Crime Post Object
- Settings Screen
  - (Update/PUT) Update User Password

- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
