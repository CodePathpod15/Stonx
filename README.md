# Stonx

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description

Stonx is a an application to help early investors gain experience in the stock market. Our app allows every investors to simulate what it is like to invest in the stock market without actually losing any money. Along with simulating transactions, we use user feedback to create a rating system for each stock. We use this system call smart stocks to create  stocks suggestions every single day (click on the lightbulb). Our app also allows users to save their favorite app and to also compare stocks with one another while looking at real time data. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Finance + Education**
- **Mobile: This app is primarly mobile but could also be expanded to desktop.**
- **Story: Uses real time data to allow users to trade without actually investing money**
- **Market: Anyone interesting in investing.**
- **Habit: This app could be used frequently to check on the status of their app**
- **Scope: We could expand to a more learning based approach to investing. Allowing users to invest in options**
- **Key Features: All UI is done programmatic, no storyboard or xib files. The app also uses websockets to retrieve real time data**

## Installation & tips 
 1. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
 2. Note that since our alphavantage API only allows us to do 5 request per minute, the app may not always return the about, sector,market cap,volume,P/E Ratio and EPS sections. 


## Features 
## Comparing stocks
 - user can search for two different stocks to compare
![video2](https://user-images.githubusercontent.com/29695936/201553036-f028f070-fc15-4934-8263-83a7b7732875.gif)


## Viewing Real time stock Data using alpaca markets Socket 
 - we provide our users with real time data using the stockets 
 - https://alpaca.markets/docs/api-references/market-data-api/stock-pricing-data/realtime/
![video2](https://user-images.githubusercontent.com/29695936/201725667-0a738425-0eb3-4092-806c-5650263f86b5.gif)


## Buying Stocks
![video2](https://user-images.githubusercontent.com/29695936/201553385-b420c064-6e30-440a-9aed-454094687417.gif)

## Selling Stocks 
![video2](https://user-images.githubusercontent.com/29695936/201553448-b621f90f-17f0-41e2-973a-dd96fcad4fad.gif)

## Creating A watchlist 
![video2](https://user-images.githubusercontent.com/29695936/201553881-747c59d2-713d-46c7-b7f3-b93fae40c2b3.gif)

![video2](https://user-images.githubusercontent.com/29695936/201553975-aa8586c2-70f1-4af3-9629-0f01d2d90ba2.gif)

## Smart stocks: receive recommendations based on user surveys 

# user survey
![video2](https://user-images.githubusercontent.com/29695936/201555430-7eb52f04-9793-453c-81a2-684432dfc4e0.gif)

# Recommendations
![video2](https://user-images.githubusercontent.com/29695936/201555554-13805d65-7a50-4f0a-8cd3-51aad34ae515.gif)


## Product Spec


### 1. User Stories (Required and Optional)

**Required Must-have Stories**
- [x] User can log in 
- [x] user can create an account 
- [x] reset password using email 
- [x] User can search for stock 
- [x] user can see the information of a stock 
- [x] User can buy a stock
- [x] User Can sell a stock
- [x] user gets a recommened stock 
- [x] user is able to look at the recommended sotck 
- [x] User can set their favorite stocks 
- [x] User can see their profit from the stock 
- [x] User can change their profile information
- [x] user can delete their account 
- [x] User can see their dashboard
- [x] user can see their updated stock chart
- [ ] User can see their history of trades 
- [x] Comparing two different stocks
- [x] programmatic UI
* ...

**Optional Nice-to-have Stories**

- [ ] User can change their profile (e.g. dark mode, ligth mode)
- [ ] User can comment on a specific stock (discussion)
- [ ] Walkthrough of the app
- [ ] News headline 
- [ ] ask the user for the number of experiences (1 to 2 years)



### 2. Screen Archetypes

* Login 
   * User can log in 
* Create account 
  *  User can create account 
* Home (Dashboard) [list second screen here]
   * Chart of profits and losses  
   * Your current porfolio 
* Favorites (Watch list)
   * Show your favorite
* Search Stock [list second screen here]
* View Stock 
   * Shows the data from the stock (charts)
   * The option to buy and sell
   * The option bookmark the stock 
   * Discussion of a stock 
   * News headline
* Settings
   * Edit profile 
   * deposit 
   * Reset profile (bankrupt)
   * Light mode and dark mode
   * The option to buy and sell
   * Deletre account 

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home (dashboard)
* Favorites 
* Search
* Settings

**Flow Navigation** (Screen to Screen)

* Favorites
   * Being able to click on each a stock 
* Seaching stock screen 
   * Clicking on a stock 
   * Confirm purchase of a stock 
* Home 
   * Being able to click on each a stock 
   * ...
* Home 
   * Edit money 
   * Username 
   * Image 
   * email 
   * Delete account 


## Wireframes


<img width="600" alt="Screen Shot 2022-10-17 at 6 45 18 PM" src="https://user-images.githubusercontent.com/29695936/196315941-e374d408-7b91-4227-8101-fdc2975e2be3.png">


### [BONUS] Digital Wireframes & Mockups

https://www.figma.com/file/uEPK45BGlDkHqQEa1qiZb6/Stonx?node-id=0%3A1

### [BONUS] Interactive Prototype

![video2](https://user-images.githubusercontent.com/29695936/197831462-6cbc6658-9a43-4980-9140-18261de6b14f.gif)



## Schema 
[This section will be completed in Unit 9]
### Models
#### user_stocks
   | Property      | Type     | Description                                 |
   | ------------- | -------- | ------------                                |
   | objectId      | String   | unique id for the user post (default field) |
   | ticker_id     | string.  | ticker symbol id                            |
   | ticker_symbol | string   | symbol.                                     |
   | buying_price  | double   | ticker symbol id                            |
   | date_purchased| string   | the purchased date                          |
   | quantity      | integer  | amount purchased                            |
   
####  Stocks_Bookmarked
   | Property      | Type     | Description                                 |
   | ------------- | -------- | ------------                                |
   | objectId      | String   | unique id for the user post (default field) |
   | ticker_id     | string.  | ticker symbol id                            |
   | ticker_symbol | string   | symbol.                                     |
  
  ####  stock_discussion
   | Property      | Type           | Description                                   |
   | ------------- | --------       | ------------                                  |
   | objectId      | String         | unique id for the user post (default field)   |
   | author        | Pointer to User| author                                        |
   | ticker_id     | Pointer to User| the id of ticker symbol                       |
   | ticker_symbol    string        | ticker smbil                                  |
   | comment_str   | String   |  caption by author                                  |
   | commentsCount | Number   | number of comments that has been posted to an image |
   | createdAt     | DateTime | date when post is created (default field)           |
   | updatedAt     | DateTime | date when post is last updated (default field)      |
  

### Networking
API: 
https://www.alphavantage.co/documentation/

- Home (Dashboard)
  - (Read/GET) Query all stocks owned by the user from user_stocks

- Favorites (Watch list)
  - (Read/GET) Query all stocks owned by the user from user_stocks
- Search Stock 
  - (Read/GET) Query stock from stocks API 
  - (Read/GET) Query individual stock from API 
- View Stock 
  - (Read/GET) Query stock from stocks API 
  - (create/POST) Add stock to Stocks_Bookmarked
  - (create/POST) Add stock to user_stocks
  - (create/POST) Add stock to stock_discussion
- Settings
  - (edit/Patch) edit name of user
  - (edit/Patch) modifying quantity 
 
 1st Submission Gif:
 version 1
![video2](https://user-images.githubusercontent.com/29695936/199633533-55cd7cdf-e20d-4c80-8389-1913481650e4.gif)


Version 2: 
![video2](https://user-images.githubusercontent.com/29695936/200395220-3c1a61ec-a35d-4a44-af91-8a3be1ce1eb7.gif)



