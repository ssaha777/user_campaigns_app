
# README

## Introduction

This is a Ruby on Rails application that manages users and their associated campaigns. The application provides both a web UI for basic user management and an API for advanced operations, including filtering users by campaign names. The application is hosted on an EC2 instance at the following URL:

```
http://3.81.174.146/
```

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Setup](#setup)
3. [API Documentation](#api-documentation)
4. [UI Paths](#ui-paths)
5. [Usage](#usage)

## Prerequisites

Before you begin, ensure you have met the following requirements:

- Ruby (version 2.7.6)
- Rails (version 7.0.8.4)
- Bundler (if not already installed, you can install it using `gem install bundler`)
- postgresql


## Setup

1. Clone the repository:
   ```bash
   git clone git@github.com:ssaha777/user_campaigns_app.git
   cd user_campaigns
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Setup environment variables:
   - Create a file .env
   - Copy content of .env.sample
   - Put values accordingly in .env file

4. Setup the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

## API Documentation

### List Users

**Endpoint:**
```
GET /api/v1/users
```

**Response:**
- `200 OK`: A list of all users.

**Example Request:**
```bash
curl -X GET "http://3.81.174.146/api/v1/users"
```

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "campaigns": ["Campaign1", "Campaign2"]
  },
  {
    "id": 2,
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "campaigns": ["Campaign1"]
  }
]
```

### Create User

**Endpoint:**
```
POST /api/v1/users
```

**Parameters:**
- `name` (required): The name of the user.
- `email` (required): The email of the user.
- `campaigns_list` (optional): A JSON array of campaign names associated with the user.

**Response:**
- `201 Created`: The newly created user.
- `422 Unprocessable Entity`: If there is an issue with the request parameters.

**Example Request:**
```bash
curl -X POST "http://3.81.174.146/api/v1/users" -H "Content-Type: application/json" -d '{
  "user": {
    "name": "John Doe",
    "email": "john.doe@example.com",
    "campaigns_list": ["Campaign1", "Campaign2"]
  }
}'
```

**Example Response:**
```json
{
  "id": 1,
  "name": "John Doe",
  "email": "john.doe@example.com",
  "campaigns": ["Campaign1", "Campaign2"]
}
```

### Filter Users by Campaign Names

**Endpoint:**
```
GET /api/v1/users/filter
```

**Parameters:**
- `campaign_names` (optional): A comma-separated list of campaign names to filter users by.

**Response:**
- `200 OK`: A list of users filtered by the provided campaign names.

**Example Request:**
```bash
curl -X GET "http://3.81.174.146/api/v1/users/filter?campaign_names=Campaign1,Campaign2"
```

**Example Response:**
```json
[
  {
    "id": 1,
    "name": "John Doe",
    "email": "john.doe@example.com",
    "campaigns": ["Campaign1", "Campaign2"]
  },
  {
    "id": 2,
    "name": "Jane Smith",
    "email": "jane.smith@example.com",
    "campaigns": ["Campaign1"]
  }
]
```

## UI Paths

- `/`: Root path, displays the list of users.
- `/users/new`: Displays a form to create a new user.

## Usage

### Accessing the Web UI

Open your web browser and navigate to `http://3.81.174.146/`. You will see the list of users and can create new users via the provided form.

### Using the API

You can interact with the API using tools like `curl` or Postman. For example, to filter users by campaign names, you can use the following curl command:

```bash
curl -X GET "http://3.81.174.146/api/v1/users/filter?campaign_names=Campaign1,Campaign2"
```

This will return a list of users associated with the specified campaigns.
