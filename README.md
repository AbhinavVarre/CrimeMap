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


## Video Walkthrough

<img src='https://user-images.githubusercontent.com/76499116/164873034-a904e81b-9962-4308-96a9-23235b570c6d.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/76499116/163656747-7f470ad9-ab6a-412f-ab45-17ac6c8d096b.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/76499116/162523605-6c0e7dfb-aa0d-440e-b81a-fbb5f7c07bd9.gif' title='Video Walkthrough' width='' alt='Video Walkthrough' />

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Travel/Safety
- **Mobile:** Mobile
- **Story:** Allow user to check the criminal incident happening or happened recently.
             Allow user to report the criminal incident. 

- **Market:** Anyone that is curious or concerned about crime data can use this app. Users can check location and type of crime committed in the map. 
- **Habit:** Users can look at crime incidents that have happened throughout the day. Users can explore crime records in any area around the city. 
- **Scope:** The initial scope of the app(v1) is to read data from the api and create/display a map with indications of calls that refreshes appropriately. V2 entails the addition of being able to interact with the red dots - this would display more information about the incident. V3 includes the addition of user reports, where the user can report and incident and this is added to the map along with any media the user decides to upload.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [X] The app is connect with a database recording data.
- [x] User is able to check the incidents through table view
- [x] An interactive map that users can drag, zoom in on, etc.
- [x] User is able to sign up, sign in and sign out.
- [x] User is able to post incidents.
- [x] Buttons at Map page and table page that can redirect to the detail page

**Optional Nice-to-have Stories**

- [x] Location of Crime is displayed as an address
- [x] User can post a crime by dragging a pin around a location
- [ ] User can choose to post a crime b selecting their current location
- [ ] User is able to update/ comment the incidents.
- [ ] Pictures related to the incident could shows on the map page

### 2. Screen Archetypes
* Login
* Map Screen
   * Interactive Map shows the criminal
   * Redirect to detail screen
* Table Screen
   * ViewTable shows the criminal happened around you
   * Redirect to detail screen
* Detail Screen
   * Back to Table/Map screen
   * Shows detail of the incident

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
    ```swift
          var user = PFUser()
          user.username = "myUsername"
          user.password = "myPassword"
          user.signUpInBackground {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
              let errorString = error.localizedDescription
              print(errorString)
            } else {
              //Login works, send user to Crime List Map
            }
          }
       ```
  - (Read/GET) Log User in
      ```swift
          PFUser.logInWithUsername(inBackground:"myname", password:"mypass") {
          (user: PFUser?, error: Error?) -> Void in
          if user != nil {
            // Do stuff after successful login.
          } else {
            // The login failed. Check error to see why.
          }
        }
       ```
- Crime List Screen
  - (Read/GET) Query all crimes and data(including author)
      ```swift
          let query = PFQuery(className: "Crimes")
          let crimesArr = query.findObjects()
       ```
- Map View Screen
  - (Read/GET) Query all crimes based on location
      ```swift
          let query = PFQuery(className: "Crimes")
          query.whereKey("location", equalTo: "target location")
          let crimesArr = query.findObjects()
       ```
  - (Delete) Delete all old posts after a number of days
      ```swift
          let query = PFQuery(className: "Crimes")
          query.whereKey("location", equalTo: "target location")
          let crimesArr = query.findObjects()
          PFObject.deleteAll(inBackground: crimesArr) { (succeeded, error) in
          if (succeeded) {
              // All of the crime objects were successfully deleted
          } else {
              // Could not delete
          }
        }
       ```
  
- Post Updates Screen
  - (Create/POST) Create a new Crime Post Object
     ```swift
          let myPost = PFObject(className:"Crime")
          myPost["title"] = "Armed Assailaint"
          myPost["content"] = "At around 4:15...."
       ```
- Settings Screen
  - (Update/PUT) Update User Password
      ```swift
          var currentUser = PFUser.current()
          if currentUser != nil {
            currentUser.password = "newPassword"
          } else {
            // Go back to login
          }
       ```
  - (Update/Put) Log Out
       ```swift
          PFUser.logOut()

- [OPTIONAL: List endpoints if using existing API such as Yelp]
