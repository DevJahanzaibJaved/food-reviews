# DineInsights - QR Feedback SaaS for Restaurants

A modern SaaS platform that enables restaurants to collect customer feedback via QR codes with dish-level ratings.

## 🚀 Features

- **Restaurant Registration**: Restaurants sign up and get their unique QR code
- **Customer Reviews**: Customers scan QR codes to leave dish-level ratings and feedback
- **Analytics Dashboard**: Restaurants view feedback summaries, ratings, and export data
- **Admin Panel**: Platform management and restaurant approval system

## 📋 Project Status

**Current Phase**: Phase 1 Complete ✅  
**Next**: Phase 2 - Restaurant Management Core

See `IMPLEMENTATION_STATUS.md` for detailed progress.

## 🛠️ Tech Stack

- **Framework**: Rails 8.0.2
- **Ruby**: 3.4.5
- **Database**: PostgreSQL
- **Authentication**: Rails 8 built-in (Current, Session models)
- **Frontend**: Tailwind CSS, Hotwire (Turbo + Stimulus)
- **Email Dev**: Letter Opener
- **Code Quality**: RuboCop, Brakeman

## 🏗️ Setup

### Prerequisites
- Ruby 3.4.5
- PostgreSQL
- Bundler

### Installation

```bash
# Install dependencies
bundle install

# Setup database
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

# Start server
bin/rails server
```

### Test Accounts

After seeding, you can use:
- **Admin**: `admin@foodreviews.com` / `password123`
- **Restaurant Owner**: `restaurant@example.com` / `password123`

**Note**: New accounts require passwords meeting complexity requirements (8+ chars, uppercase, lowercase, number, special char).

## 📁 Project Structure

- `app/models/` - User, Session, Current models
- `app/controllers/` - Authentication and page controllers
- `app/views/` - ERB templates with Tailwind CSS
- `app/views/shared/` - Reusable partials (navbar, flash, etc.)
- `app/javascript/` - JavaScript files (flash handling)
- `config/` - Application configuration
- `db/` - Migrations and seeds

## 📚 Documentation

- `PROJECT_GUIDELINES.md` - Development principles and standards
- `MVP_SPECIFICATION.md` - Complete feature specifications
- `DEVELOPMENT_PLAN.md` - Phase-by-phase implementation plan
- `IMPLEMENTATION_STATUS.md` - Current implementation status

## 🔐 Authentication

The app uses Rails 8's built-in authentication system:
- Cookie-based session management
- Password reset via email (15-minute token expiration)
- Strong password validation
- Role-based access control

## 🎨 Design

- **Color Scheme**: Black and white with subtle gray accents
- **Style**: Modern, minimal, clean design
- **Components**: Reusable partials for consistency
- **Responsive**: Mobile-first, works on all devices

## 🧪 Development

- Run linter: `bin/rubocop`
- Run security scan: `bin/brakeman`
- Email testing: Letter Opener opens emails in browser automatically

## 📝 License

[Add your license here]

---

**DineInsights** - Transforming restaurant feedback collection
