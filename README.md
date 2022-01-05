# Tea Service

This is a REST API for a tea subscription service. Customers can view available
teas and subscribe to receiving package of the respective teas at a chosen frequency.

## Local Setup
After cloning the repository to your local machine:

`bundle install`

`rails db:{create,migrate,seed}`

`rails s`

## Primary Technologies and Versions
- Ruby 3.0.3
- Rails 7.0.0
- PostgreSQL

## Testing Suite
- RSpec
- Coverage statistics by SimpleCov

### Execution
- `bundle exec rspec`

## Database Design

## Endpoints

### `GET /api/v1/teas`
Response:
```json
{
  "teas": [
    {
      "id": 1,
      "title": "Tea 1",
      "temperature": 70,
      "description": "Amazing tea 1",
      "brew_time": 120
    },
    {
      "id": 2,
      "title": "Tea 2",
      "temperature": 70,
      "description": "Amazing tea 2",
      "brew_time": 120
    }
  ]
}
```

### `POST /api/v1/customers`
Required request body content:
```json
{
  "customer": {
    "first_name": "Bob",
    "last_name": "Ross",
    "email": "bob_ross@painting.com",
    "address": "12345 Happy Little Trees Dr."
  }
}
```
Response:
```json
{
  "id": 4,
  "first_name": "Bob",
  "last_name": "Ross",
  "email": "bob_ross@painting.com",
  "address": "12345 Happy Little Trees Dr.",
  "created_at": "2022-01-05T18:47:33.648Z",
  "updated_at": "2022-01-05T18:47:33.648Z"
}
```

### `GET /api/v1/customers/:customer_id/subscriptions`
Response:
```json
{
  "id": 1,
  "subscriptions": {
    "canceled": [
      {
        "id": 1,
        "title": "subscription 1",
        "price": 1250,
        "status": "canceled",
        "frequency": "weekly",
        "tea_id": 2
      },
      {
        "id": 6,
        "title": "subscription 6",
        "price": 1250,
        "status": "canceled",
        "frequency": "daily",
        "tea_id": 1
      }
    ],
    "active": [
      {
        "id": 2,
        "title": "subscription 2",
        "price": 1250,
        "status": "active",
        "frequency": "daily",
        "tea_id": 1
      },
      {
        "id": 3,
        "title": "subscription 3",
        "price": 1250,
        "status": "active",
        "frequency": "weekly",
        "tea_id": 2
      }
    ]
  }
}
```

### `POST /api/v1/customers/:customer_id/subscriptions`
Required request body content:
```json
{
  "subscription": {
    "title": "Get the green tea",
    "price": 1250,
    "frequency": 0,
    "tea_id": 1
  }
}
```
Response:
```json
{
  "id": 22,
  "title": "Get the green tea",
  "price": 1250,
  "status": "active",
  "frequency": "daily",
  "customer_id": 1,
  "tea_id": 1,
  "created_at": "2022-01-05T19:04:32.049Z",
  "updated_at": "2022-01-05T19:04:32.049Z"
}
```

### `PATCH /api/v1/customers/:customer_id/subscriptions/:id`
Response:
`status: 204`

### Contributors
- Tanner Dale (GitHub)[https://github.com/TannerDale] (LinkedIn)[https://www.linkedin.com/in/tannerdale/]
