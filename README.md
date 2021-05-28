# Rails Engine 

Rails Engine is an API that allows users to look up specific e-commerce data on merchants and items. The API endpoints are designed to manipulate data and return what the user is searching for within a query param. 

## Getting Started

Visit [Heroku](https://rails-engine-555.herokuapp.com/) or localhost:3000 and get started with the steps below. 

### Versions

- Ruby 2.5.3

- Rails 5.2.5

### Local Setup

1. Fork and Clone this repo
2. Install gem packages above
3. Setup the database: `rails db:(drop,create,migrate,seed)` or `rails db:setup`
4. Run command `rails s` and navigate to http://localhost:3000 to consume API endpoints below 

## Endpoints 
The following are all API endpoints. Note, some endpoints have optional or required query parameters.
 - All endpoints run off base connector `http://localhost:3000` if on local
 - All endpoints run off base connecter `https://rails-engine-555.herokuapp.com` if on [Heroku](https://rails-engine-555.herokuapp.com/)

### Merchants:

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v1/merchants`                             | Retrieve all merchants.                      |
| `GET`   | `/api/v1/merchants/<merchant_id>`                             | Retrieve single merchant.                       |
| `GET`    | `/api/v1/merchants/<merchant_id>/items`                          | Retrieve single merchants items.                       |
| `GET`  | `/api/v1/merchants/find?name=<name_fragment>`                          | Retrieve merchant with name fragment.                 |
| `GET`   | `/api/v1/revenue/merchants?quantity=<number_of_merchants>`                 | Retrieve merchants by top revenue.                 |
| `GET`   | `api/v1/revenue/merchants/<merchant_id>` | Retrieve a single merchant's revenue. | 
| `GET` | `/api/v1/merchants/most_items?quantity=<quantity>` | Retrieve merchants who sold the most items. |

### Items:

| Method   | URL                                      | Description                              |
| -------- | ---------------------------------------- | ---------------------------------------- |
| `GET`    | `/api/v1/items`                             | Retrieve all items.                      |
| `GET`   | `/api/v1/items/<item_id>`                             | Retrieve a single item.                       |
| `GET`    | `/api/v1/items/<item_id>/merchant`                          | Retrieve an item's merchant.                       |
| `GET`  | `/api/v1/items/find_all?name=<name_fragment>`                          | Retrieve all items by name fragment.                 |
| `GET` | `/api/v1/revenue/items?quantity=<quantity>` | Retrieve items with highest revenue. | 
| `POST`   | `/api/v1/items`                 | Create an item.                 |
| `DELETE` | `/api/v1/items/<item_id>` | Delete an item. | 
| `PATCH` | `/api/v1/items/<item_id>` | Update an item. |


### Pagination Examples: 

| Endpoint             | Description                              |
| -------------------- | ---------------------------------------- |
| `/api/v1/merchants`         | Initial request. Returns first 20 merchants.  |
| `/api/v1/merchants?page=2&per_page=10` | Second page, returns 10 merchants using an offset of 10. |
| `/api/posts/?per_page=10` | Initial request, returns page first page with 10 merchants using an offset of 10. |
| `/api/v1/items` | Initial request. Returns first 20 items.  |
| `/api/v1/items?page=2&per_page=10` | Second page, returns 10 items using an offset of 10. |
| `/api/posts/?per_page=10` | Initial request, returns page first page with 10 merchants using an offset of 10. |

### HTTP Errors: 

| Code  | Title                     | Description                              |
| ----- | ------------------------- | ---------------------------------------- |
| `200` | `OK`                      | When a request was successfully processed (e.g. when using `GET`, `PATCH`, `PUT` or `DELETE`). |
| `201` | `Created`                 | Every time a record has been added to the database (e.g. when creating a new item). 
| `400` | `Bad request`             | When the request could not be understood (e.g. invalid syntax or params). |
| `404` | `Not found`               | When URL or entity is not found. |

## Examples 

### A single merchant: 

``` 
{
   "data": {
     "id": "1",
     "type": "merchant",
     "attributes": {
        "name": "Schroeder-Jerde"
     }
   }
}
``` 

### A single item: 

``` 
{
    "data": {
      "id": "4",
      "type": "item",
      "attributes": {
         "name": "Item Nemo Facere",
         "description": "Sunt eum id eius magni consequuntur delectus veritatis. Quisquam laborum illo ut ab. Ducimus in est id  voluptas          autem.",
         "unit_price": 42.91,
         "merchant_id": 1
      }
    }
}
``` 

### A paginated collection of merchants 
``` 
{
    "data": [
      {
      "id": "1",
      "type": "merchant",
      "attributes": {
         "name": "Schroeder-Jerde"
      }
    },
      {
      "id": "2",
      "type": "merchant",
      "attributes": {
         "name": "Klein, Rempel and Jones"
      }
    },
      {
      "id": "3",
      "type": "merchant",
      "attributes": {
         "name": "Willms and Sons"
      }
    }
   ]
}
``` 

## Running the tests

Run all tests in application with `bundle exec rspec`. When test is complete, run `open coverage` to see where tests are being run and where they are not.

## Deployment

- [Rails-555-Heroku](https://rails-engine-555.herokuapp.com/)
- If you'd like to run this app locally, run `rails s` and navigate to `http://localhost:3000/` in your browser.

## Built Using

  - Ruby on Rails

## Developers

- [Klaudia Stewart](https://github.com/klaudiastewart)

## Acknowledgments

Id'd like to thank Turing School of Software and Engineering for helping me come up with the idea for this application, and thank you for reading through this project!
