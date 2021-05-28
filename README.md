# Rails Engine 

Rails engine is an API that allows users to look up specific e-commerce data on merchants, customers, items, invoices, transactions, and invoice items. The API endpoints are designed to manipulate the data and return what the user is searching for given a param. 

## Getting Started

If you're running this application on your local computer, please make sure to include these gems in your Gemfile. Once there, run `bundle` to install and update them.

### Versions

- Ruby 2.5.3

- Rails 5.2.5

### Local Setup

1. Fork and Clone this repo
2. Install gem packages above
3. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`
4. Run command `rails s` and navigate to http://localhost:3000 and consume API endpoints below 

## Endpoints 
The following are all API endpoints. Some endpoints have optional or required query parameters. These are denoted with `query params`. 
 - All Endpoints run off base connector: `http://localhost:3000`

### Merchants 

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v1/merchants`                             | Retrieve all merchants.                      |
| `GET`   | `/api/v1/merchants/<merchant_id>`                             | Retrieve single merchant.                       |
| `GET`    | `/api/v1/merchants/<merchant_id>/items`                          | Retrieve single merchants items.                       |
| `GET`  | `/api/v1/merchants/find?name=<name_fragment>`                          | Retrieve merchant with name fragment.                 |
| `GET`   | `/api/v1/revenue/merchants?quantity=<number_of_merchants>`                 | Retrieve merchants by top revenue.                 |
| `GET`   | `api/v1/revenue/merchants/<merchant_id>` | Retrieve a single merchant's revenue.

### Items:

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v1/items`                             | Retrieve all items.                      |
| `GET`   | `/api/v1/items/<item_id>`                             | Retrieve a single item.                       |
| `GET`    | `/api/v1/items/<item_id>/merchant`                          | Retrieve an item's merchant.                       |
| `GET`  | `/api/v1/items/find_all?name=<name_fragment>`                          | Retrieve all items by name fragment.                 |
| `POST`   | `/api/posts/28/comments`                 | Add comment to post #28.                 |


 - To create an item: post `/api/v1/items` 
 - To delete an item: delete `/api/v1/items/<item_id>
 - To update and item: patch `/api/v1/items/<item_id>`


## Running the tests

Run all tests in application with `bundle exec rspec`. When test is complete, run `open coverage` to see where tests are being run and where they are not.

## Deployment

- On Heroku: Add Heroku app link
- If you'd like to run this app locally, run `rails s` and navigate to `http://localhost:3000/` in your browser.

## Built Using

  - Ruby on Rails

## Built By

- [Klaudia Stewart](https://github.com/klaudiastewart)

## Acknowledgments

Id'd like to thank Turing School of Software and Engineering for helping me come up with the idea for this application, and thank you for reading through this project!
