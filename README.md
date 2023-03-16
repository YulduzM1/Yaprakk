Original App Design Project - README Template
===

# Yaprak

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
A Turkmen recipe app where users can share their favorite recipes and add categories and tags that help users discover recipes that match their needs.

### App Evaluation
- **Category:** Food / Social Networking
- **Mobile:** We aim for this app to be developed for Mobile, but users can also access it through a computer/website. Since it is primarily focused on Mobile, Mobile will likely have more features and a friendly user interface compared to a website.
- **Story:** Allows the users to search a particular recipe based on tags and categories. Users can also share their favorite recipes and like/dislike recipes shared by other users. 
- **Market:** Anyone can use this app, but it would be more of an interest to food enthusiasts.
- **Habit:** Users can use this app often depending on what recipes they are looking for and if they want to share a recipe they loved.
- **Scope:** First, this will start as a way for users to discover and share their favorite recipes. This app will then evolve to let users create playlists of recipes and recommend new recipes based on their selections. 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

* [fill in your required user stories here]
* [x] User can login/logout of their account
* [x] User can create a new account
* [x] User can post a recipe and add appropriate tags
* [x] User can see posted recipes
* [x] User can take a photo, add a prep Time, cook Time, and post it to the server.
* [x] User can view the last 20 recipes. 
* [x] User can view existing posts from other users
* [x] User can like/dislike these posts, and will be less likely to see poorly received posts
* [x] User can save recipes they love and view them later
* [x] User can search for posts that have certain tags

## 1A. Gif Walkthrough


**Future Nice-to-have Stories**
* [ ] User can join communities around certain dietary or culinary topics / categories and see recipes liked by that community
* [ ] User can select topics they like when signing up


### 2. Screen Archetypes
Preliminary:

* Login
   * [x] User can login to the app
   * [x] User can create an account
   * [x] **Optional**: User can select topics they like while creating their account
* Home Page
    * This is a tableview
   * [x] User can see recipes and the tags / likes / dislikes associated
   * [x] User can select to create a recipe
   * [x] User can expand each recipe page modally
   * [x] User can infinite scroll through recipes
   * [x] User can add filters to the page to only see certain posts
   * [x] **Optional**: User can use a search bar to search for a particular recipe
* Detailed Recipe Page
    * [x] User can see the ingredients, the steps
    * [x] User can view a story associated with the recipe (e.g. this was my grandma's favorite dish for thanksgiving blah blah blah)
    * [x] User can choose to skip this story
    * [x] User can view a set of tips (e.g. you can use more sugar to make cakier cookies, you want to use a very hot skillet, you want to mix the batter very gently, etc.)
    * [x] User can skip the tips
    * [ ] **Optional**: User can post and see comments on the recipe
    * [ ] **Optional**: if the user created this recipe, they can edit or delete it
* Create a Recipe
    * [ ] User can view a template to help them separate their recipe into logical components: ingredients, steps, story, tips
    * [ ] User can cancel creation of their recipe
* Feed
    * [x] User can view the recipes
* Favorite Page
    * Tableview
    * [x] User can see the recipes in the Favorite Page

* Account
    * [x] User can logout
    * [ ] **Optional:** User can activate dark mode
    * [ ] **Optional:** User can view all the recipes they've created
* Communities (future)
    * [ ] User can view existing communities
    * [ ] User can view a summary of each community modally
    * [ ] User can search for a community by name
    * [ ] User can select an option to create a community
* Create Community (future)
    * [ ] User can create a new community and provide a description
    * [ ] User can add filters associated with community
    * [ ] User can create rules for community
    * [ ] **Optional**: The request will be reviewed before finally being created (developers approve community based on description, rules, and whether such a community already exists)


### 3. Navigation

**Tab Navigation** (Tab to Screen)

* [Home Page]
* [Recipe Feed Page]
* [Detailed Recipe Page]
* [Favorite Recipes Page]


**Flow Navigation** (Screen to Screen)

* [Forced Log-in -> Account creation if no log in is available]

* [Communities]
   * [Create a Community]

* [Playlist Page]
   * [Save a Recipe]
   * [Cart]

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="https://imgur.com/TXzAiMr.jpg" width=600>

### [BONUS] Digital Wireframes & Mockups

<img src="https://imgur.com/HKJXedG.gif">


### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
#### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | userId      | String   | unique id for the user (default field) |
   | username        | String | username of the user |
   | password | String | password of the user |
   | email         | String     | email of the user |
   | about         | String     | some description about the user |

#### Recipe

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | recipeId      | String   | unique id for the recipe (default field) |
   | userId | Pointer to User | recipe author
   | name        | String | name of the recipe |
   | description | String | description of the recipe |
   | image | File | image that user posts along with recipe |
   | likesCount    | Number   | number of likes for the recipe |
   | createdAt     | DateTime | date when recipe post is created (default field) |
   | updatedAt     | DateTime | date when recipe post is last updated (default field) |


#### Playlist

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | playlistId      | String   | unique id for the playlist (default field) |
   | recipeId      | Pointer to Recipe   | recipe information |
   | userId | Pointer to User | playlist author
   | name        | String | name of the playlist |
   | description | String | description of the playlist |
   | image | File | playlist cover image |
   | createdAt     | DateTime | date when playlist is created (default field) |
   | updatedAt     | DateTime | date when playlist is last updated (default field) |
   
#### Community

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | communityId      | String   | unique id for the community (default field) |
   | userId | Pointer to User | community member |
   | recipeId  | Pointer to Recipe | recipe information |
   | name        | String | name of the community |
   | description | String | description of the community |
   | image | File | community cover image |
   | createdAt     | DateTime | date when community is created (default field) |
   
### Networking
- Login Screen
    - POST - Sign in
    - Create/POST - Sign up
- Home/Feed Screen
    - Read/GET - Query recipes from communities user is subscribed to
    - Update/POST - Like a recipe
    - Update/DELETE - Remove a like
    - Update/POST - Add a recipe to a playlist
    - Update/DELETE - Remove recipe from playlist
- Recipe Details Screen
    - Update/POST - Like recipe
    - Update/DELETE - Remove like
    - Update/POST - Add recipe to a playlist
    - Update/DELETE - Remove recipe from playlist
- Create Recipe Screen
    - Create/POST - Create a new recipe object
- Playlists Screen
    - Read/GET - Query playlists where user is author
    - Create/POST - Create a new playlist object
- Playlist Members Screen
    - Update/DELETE - Delete playlist object
- Account Screen
    - Read/GET - Query user object
    - Update/DELETE - Delete user
- Communities Screen
    - Read/GET - Query communities
    - Update/POST - Join community
- Create Community Screen
    - Create/POST - Create Community
