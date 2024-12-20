# ContactVault

ContactVault is a Ruby on Rails application for managing contacts with user authentication and activity logging.

## Features

- User authentication system
- Contact management (create, read, update, delete)
- Activity logging for contact changes
- Caching system for improved performance
- Background job processing with Solid Queue

## Technical Stack

- Ruby on Rails 8.0
- SQLite3 database
- Solid Queue for background jobs
- Fragment caching
- System tests with Capybara

## Setup

1. Clone the repository:

git clone https://github.com/RonNCI/contactvault.git

2. Install dependencies:
```bash
bundle install

3. Setup database:
```bash
rails db:create db:migrate

4. Start the server:
```bash
rails server
