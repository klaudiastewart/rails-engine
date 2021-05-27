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

### Endpoints 
The following are all API endpoints. Some endpoints have optional or required query parameters. These are denoted with `query params *`. 
 - To find all merchants: http://localhost:3000/api/v1/merchants, to limit the amount of merchants per page and page number add `query params *` `?per_page<number_per_page>&page=<page_number>`


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
