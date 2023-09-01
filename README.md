# RoR API Application
This is a Rails API application that provides functionalities for users and articles,
including authentication, CRUD operations for articles, comments, and more.

## Docker Setup
### Prerequisites
Docker & Docker Compose
Installation & Running the App

### unzip and cd into the project directory

Setup Database:
```
docker-compose run api rails db:setup
```

Build and run the Docker Image:
```
docker-compose up --build
```

## API Endpoints
Postman collection you can find in the root directory of the project, in directory `postman`.

### Setting Up Postman Environment
To make the most of the API endpoints, you'll need to set up your Postman environment with the necessary variables.

In the environment, you'll need to add the following variables:

`api_v1_base_url`: The base URL for your API's version 1 - `http://localhost:3000/api/v1`.
`base_url`: The base URL for your API - `http://localhost:3000`.
`auth_token`: The authentication token you receive after signing in. This will be used for endpoints that require authentication.
To add a variable:

Using Variables in Requests:
When creating or editing a request in Postman, you can use the variables by wrapping them in double curly braces. For example:

URL: {{api_v1_base_url}}/articles
Headers: Authorization: Bearer {{auth_token}}
Postman will automatically replace the variable placeholders with their corresponding values from the selected environment.

### Endpoints

#### User Authentication

*using base_url*

**Sign Up:**

Method: **POST**
Endpoint: `/users/tokens/sign_up`
Headers:
 - ApiKey: Bearer [API_KEY]

Body:
- email: User email [String]
- password: User password [String]
- first_name: User first name [String]
- last_name: User last name [String]
- avatar: User avatar [File]

**Sign In:**

Method: **POST**
Endpoint: `/users/tokens/sign_in`
Body:
- email: User email [String]
- password: User password [String]

**Token Info:**

Method: **GET**
Endpoint: `/users/tokens/info`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

#### Articles

*using api_v1_base_url*

**Create:**

Method: **POST**
Endpoint: `/articles`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

Body:
- title: Article title [String]
- description: Article description [String]
- status: Article status  [enum: hidden, published]
- category_id: Category ID [Integer]
- tag_list: Comma-separated list of tags [String]
- cover: Article cover [File]

**Update:**

Method: **PUT**
Endpoint: `/articles/:id`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

Body:
- title: Article title [String]
- cover: Article cover [File]
- status: Article status [enum: hidden, published]
- tag_list: Comma-separated list of tags [String]

**Delete:**

Method: **DELETE**
Endpoint: `/articles/:id`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**List All Articles:**

Method: **GET**
Endpoint: `/articles`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

Body:
- page: Pagination page number (default: 1)
- query: Search query  [String]
- start_date: Start date for filtering [Date]
- end_date: End date for filtering [Date]

**View Single Article:**

Method: **GET**
Endpoint: `/articles/:id`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

#### Comments
**Create Comment:**

Method: **POST**
Endpoint: `/articles/:article_id/comments`

Headers:
- Authorization: Bearer [AUTH_TOKEN]

Body:
- value: Comment content [String]

**Like Comment:**

Method: **PUT**
Endpoint: `/articles/:article_id/comments/:comment_id/like`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**Dislike Comment:**

Method: **PUT**
Endpoint: `/articles/:article_id/comments/:comment_id/dislike`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**List All Comments for an Article:**

Method: **GET**
Endpoint: `/articles/:article_id/comments`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

Body:
- page: Pagination page number (default: 1)

#### Article Versions

**List All Versions for an Article:**

Method: **GET**
Endpoint: `/articles/:article_id/versions`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**View Single Version:**

Method: **GET**
Endpoint: `/articles/:article_id/versions/:id`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**Rollback to a Specific Version:**

Method: **POST**
Endpoint: `/articles/:article_id/versions/:id/rollback`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

#### Categories

**List All Categories:**
Method: **GET**
Endpoint: `/categories`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

#### Admin

**Ban User:**

Method: **PUT**
Endpoint: `/admin/users/:id/ban`
Headers:
- Authorization: Bearer [AUTH_TOKEN]

**Unban User:**

Method: **PUT**
Endpoint: `/admin/users/:id/unban`
Headers:
- Authorization: Bearer [AUTH_TOKEN]
