# Stonx

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
# 
Stonx is a an application that allows users to simulate what it's like to finally win in the stock market. Our app allows every single one of our users to simulate buying and selling a stock without losing any money. 

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category: Finance + Education**
- **Mobile: This app is primarly mobile but could also be expanded to desktop.**
- **Story: Uses real time data to allow users to trade without actually investing money**
- **Market: Anyone interesting in investing.**
- **Habit: This app could be used frequently to check on the status of their app**
- **Scope: We could expand to a more learning based approach to investing. Allowing users to invest in options**


# 

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
- [x] User can log in 
- [x] user can create an account 
- [x] Reset password
- [x] User can search for stock 
- [x] user can see the information of a stock 
- [x] User can buy a stock
- [ ] User Can sell a stock
- [ ] User can see their portfolio
- [x] User can set their favorite stocks 
- [ ] User can see their profit from the stock 
- [ ] User can see their history of trades 
- [ ] User can change their profile information
- [ ] User can maneuver through dashboard.
* ...

**Optional Nice-to-have Stories**

- [ ] User can change their profile (e.g. dark mode, ligth mode)
- [ ] User can bookmark a stock so that it appears in the homepage  
- [ ] User can search for crypto 
- [ ] User can Buy crypto
- [ ] user can sell crypto
- [ ] User can comment on a specific stock (discussion)
- [ ] News headline 
- [ ] ask the user for the number of experiences (1 to 2 years)
- [ ] Comparing two different stocks
- [ ] add scaling to stocks for recommendations 

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
 
![video2](https://user-images.githubusercontent.com/29695936/199633533-55cd7cdf-e20d-4c80-8389-1913481650e4.gif)




