# Event Management API

## Overview
This is a **Rails API-only** application for an event management system. It supports authentication for customers and event organizers, event creation, ticket booking, and notifications via Sidekiq.

## Features
- JWT-based authentication for **Customers** and **Event Organizers**.
- CRUD operations for **Events**.
- Event ogranizers can create tickets for events
- Ticket booking system for customers.
- Asynchronous email notifications using **Sidekiq** (placeholder print statements for now).
- Admin interface for Sidekiq.

## Tech Stack
- **Backend**: Ruby on Rails (API Mode)
- **Authentication**: JWT
- **Background Jobs**: Sidekiq
- **Database**: PostgreSQL

## Getting Started

### Prerequisites
Ensure you have the following installed:
- Ruby 2.7.6
- Rails 7.x
- PostgreSQL
- Redis (for Sidekiq)
- Bundler & Yarn

### Setup
1. **Clone the repository**
   ```sh
   git clone https://github.com/sathwik-1309/event_booking_api.git
   cd event_booking_api
   ```
2. **Install dependencies**
   ```sh
   bundle install
   ```
3. **Set up the database**
   ```sh
   rails db:create
   rails db:migrate
   ```
4. **Start the server**
   ```sh
   rails s
   ```
5. **Start Sidekiq** (for background jobs)
   ```sh
   bundle exec sidekiq
   ```
6. **Access the Sidekiq Dashboard**
   - Visit `http://localhost:3000/sidekiq`
   - If you encounter session issues, enable middleware in `config/application.rb`:
     ```ruby
     config.middleware.use ActionDispatch::Cookies
     config.middleware.use ActionDispatch::Session::CookieStore, key: '_session'
     ```

## API Endpoints

### Authentication
#### **Customer Signup**
```http
POST /customers/signup
```
#### **Event Organizer Signup**
```http
POST /event_organizers/signup
```
#### **Login**
```http
POST /login
```

### Events
#### **Create Event** (Organizer Only)
```http
POST /events
Authorization: Bearer <token>
```
#### **Get Events**
```http
GET /events
```
#### **Update Event** (Organizer Only)
```http
PUT /events/:id
Authorization: Bearer <token>
```
#### **Delete Event** (Organizer Only)
```http
DELETE /events/:id
Authorization: Bearer <token>
```

### Tickets
#### **Book Ticket** (Organizer Only)
```http
POST /tickets
Authorization: Bearer <token>
```
#### **Get Event Tickets**
```http
GET /tickets
Authorization: Bearer <token>
```

#### **Update Ticket**
```http
PUT /tickets/:id
Authorization: Bearer <token>
```

#### **Cancel Ticket**
```http
DELETE /tickets/:id
Authorization: Bearer <token>
```

### Booking
#### **Create Booking** (Organizer Only)
```http
POST /bookings
Authorization: Bearer <token>
```
#### **View Bookings**
```http
GET /bookings
```

## Background Jobs (Sidekiq)
- **Booking Confirmation Email** (Prints message for now)
- **Event Update Notification** to attendees (Prints message for now)

## Code Structure
```sh
app/
├── controllers/      # API controllers for events, users, tickets
├── models/           # ActiveRecord models
├── jobs/             # Sidekiq background jobs
```

## Contributing
1. Fork the repo.
2. Create a feature branch: `git checkout -b feature-name`
3. Commit changes: `git commit -m 'Add feature'`
4. Push to branch: `git push origin feature-name`
5. Open a pull request.

## License
[MIT License](LICENSE)

---
🚀 Happy coding!

