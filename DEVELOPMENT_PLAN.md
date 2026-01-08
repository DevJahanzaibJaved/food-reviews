# Development Plan - QR Feedback SaaS MVP

## Phase Overview
Step-by-step implementation plan following project guidelines and best practices.

---

## Phase 0: Foundation & Setup ✅
**Status**: Already Complete
- Rails 8.0.2 application setup
- PostgreSQL database configured
- Tailwind CSS configured
- Hotwire (Turbo + Stimulus) configured
- RuboCop and Brakeman configured
- Basic project structure in place

---

## Phase 1: Authentication & User Management ✅

### 1.1 Authentication System
- [x] **Rails 8 built-in authentication** - Using Rails 8's authentication generator
  - `Current` model for session management
  - `Session` model with cookie-based authentication
  - `Authentication` concern with session handling
- [x] Set up User model with roles (Admin, RestaurantOwner)
- [x] Create authentication views and controllers
- [x] Implement role-based access control
- [x] **Password reset functionality** - Complete with email delivery
- [x] **Password complexity validation** - Strong password requirements
- [ ] Add authentication tests (to be added in Phase 10)

### 1.2 User Models
- [x] User model with `email_address`, `password_digest`, and `role` fields
- [x] Role enum (admin, restaurant_owner)
- [x] Role-based authorization helpers in Authenticatable concern
- [x] Role checking methods (admin?, restaurant_owner?)
- [x] Password reset token methods (signed_id with 15-minute expiration)

### 1.3 Password Security
- [x] **Strong password requirements**:
  - Minimum 8 characters
  - At least one number (0-9)
  - At least one uppercase letter (A-Z)
  - At least one lowercase letter (a-z)
  - At least one special character
- [x] Password complexity validation with clear error messages

### 1.4 Email System
- [x] **Password reset email** - HTML and plain text templates
- [x] **Letter Opener** configured for development email testing
- [x] Modern email templates matching brand design

### 1.5 UI/UX Components
- [x] **Modern black/white design system** - Clean, minimal, stylish
- [x] **Navbar partial** - Reusable navigation component
- [x] **Flash message system** - Success (green) and error (red) notifications
- [x] **Password requirements partial** - Elegant display of requirements
- [x] **Non-scrollable forms** - Fixed viewport height forms
- [x] Auto-hiding flash messages (5 seconds) with manual dismiss
- [x] Responsive design for mobile and desktop

### 1.6 JavaScript Organization
- [x] **Dedicated JavaScript files** - No inline JS in HTML templates
- [x] Flash message auto-hide functionality in `app/javascript/flash.js`
- [x] Turbo support for SPA-like navigation

**Deliverable**: ✅ Complete - Full authentication system with password reset, strong validation, and modern UI.

**Implementation Details**:
- **Authentication**: Rails 8 built-in with `Current` and `Session` models
- **User Model**: `email_address`, `password_digest`, `role` (enum)
- **Controllers**: 
  - `SessionsController` - Login/logout with flash messages
  - `RegistrationsController` - User signup
  - `PasswordsController` - Password reset flow
- **Views**: Modern, clean design with Tailwind CSS
- **Partials**: Navbar, flash messages, password requirements
- **Validation**: Strong password requirements enforced
- **Email**: Letter Opener for development, HTML email templates
- **Seed Data**: `admin@foodreviews.com` and `restaurant@example.com` (both: `password123`)

---

## Phase 2: Restaurant Management Core

### 2.1 Restaurant Model & CRUD
- [ ] Create Restaurant model with fields:
  - name, owner_name, email, phone, address
  - plan (enum: free, paid)
  - status (enum: pending, approved, suspended)
  - timestamps
- [ ] Restaurant validations
- [ ] Restaurant associations (has_many :dishes, has_many :feedbacks)
- [ ] Restaurant controller with CRUD operations
- [ ] Restaurant views (index, show, new, edit)
- [ ] Restaurant tests

### 2.2 Restaurant Registration Flow
- [ ] Public registration page
- [ ] Registration form with all required fields
- [ ] Post-registration confirmation/email
- [ ] Admin notification of new registration
- [ ] Registration tests

**Deliverable**: Restaurants can register, and basic restaurant data is stored.

---

## Phase 3: QR Code Generation & Management

### 3.1 QR Code Generation
- [ ] Add QR code gem (recommendation: `rqrcode`)
- [ ] Generate unique identifier for each restaurant
- [ ] Create QR code generation service
- [ ] Store QR code as image (Active Storage or generate on-the-fly)
- [ ] QR code URL routing (public review form link)

### 3.2 QR Code Management
- [ ] QR code display in restaurant dashboard
- [ ] QR code download functionality (PNG/PDF)
- [ ] QR code regeneration option
- [ ] QR code secret/token management

**Deliverable**: Each restaurant has a unique QR code that links to their review form.

---

## Phase 4: Dish Management

### 4.1 Dish Model & CRUD
- [ ] Create Dish model with fields:
  - restaurant_id (belongs_to)
  - name, description (optional)
  - active (boolean, default: true)
  - timestamps
- [ ] Dish validations
- [ ] Dish associations (belongs_to :restaurant, has_many :ratings)
- [ ] Dish controller (nested under restaurant)
- [ ] Dish views (manage dishes in restaurant dashboard)
- [ ] Dish tests

### 4.2 Dish Management Interface
- [ ] Add dish form
- [ ] Edit dish form
- [ ] Remove/deactivate dish functionality
- [ ] Dish list display in restaurant dashboard
- [ ] Real-time updates (Hotwire Turbo)

**Deliverable**: Restaurants can add, edit, and remove dishes from their menu.

---

## Phase 5: Customer Review Form

### 5.1 Public Review Form
- [ ] Public route for restaurant review form (via QR code)
- [ ] Review form view (mobile-optimized)
- [ ] Dynamic dish list display (fetches active dishes)
- [ ] Star rating component for each dish (Stimulus controller)
- [ ] Customer info form fields (name, email, WhatsApp)
- [ ] Optional text review field
- [ ] Form validation (client-side and server-side)

### 5.2 Review Form Logic
- [ ] Form submission handling
- [ ] Create Feedback and Rating records
- [ ] Success/thank you page with incentive message
- [ ] Error handling and display
- [ ] Mobile UX optimization

**Deliverable**: Customers can scan QR code and submit dish-level ratings and reviews.

---

## Phase 6: Feedback Storage & Models

### 6.1 Feedback Model
- [ ] Create Feedback model with fields:
  - restaurant_id (belongs_to)
  - customer_name
  - customer_email (optional)
  - customer_whatsapp (optional)
  - text_review (optional)
  - timestamps
- [ ] Feedback validations
- [ ] Feedback associations (belongs_to :restaurant, has_many :ratings)

### 6.2 Rating Model
- [ ] Create Rating model with fields:
  - feedback_id (belongs_to)
  - dish_id (belongs_to)
  - rating (integer, 1-5)
  - timestamps
- [ ] Rating validations
- [ ] Rating associations (belongs_to :feedback, belongs_to :dish)

### 6.3 Database Optimization
- [ ] Add database indexes:
  - restaurant_id on feedbacks, dishes
  - dish_id on ratings
  - created_at on feedbacks, ratings
- [ ] Add database constraints
- [ ] Model tests

**Deliverable**: Feedback and ratings are properly stored with correct relationships.

---

## Phase 7: Restaurant Dashboard - Analytics & Views

### 7.1 Feedback Summary
- [ ] Average rating calculation per dish
- [ ] Total reviews count
- [ ] Star ratings distribution/overview
- [ ] Review count per dish
- [ ] Dashboard analytics service/concern

### 7.2 Dashboard Views
- [ ] Restaurant dashboard layout
- [ ] Feedback summary display (charts/graphs - optional)
- [ ] Recent feedback list
- [ ] Dish ratings overview
- [ ] Filter feedback by dish
- [ ] Filter feedback by date range

**Deliverable**: Restaurants can view comprehensive feedback analytics.

---

## Phase 8: Data Export

### 8.1 CSV Export Functionality
- [ ] Export feedback as CSV service
- [ ] Export customer data as CSV service
- [ ] CSV export controller actions
- [ ] CSV export buttons in dashboard
- [ ] CSV formatting (proper headers, data formatting)
- [ ] Export tests

**Deliverable**: Restaurants can export feedback and customer data as CSV files.

---

## Phase 9: Admin Dashboard

### 9.1 Admin Interface
- [ ] Admin dashboard layout
- [ ] List all restaurants (with filters/search)
- [ ] Restaurant approval workflow
- [ ] Restaurant suspend/activate functionality
- [ ] Plan management (upgrade/downgrade)
- [ ] Admin-only routes and authorization

### 9.2 Admin Analytics
- [ ] Total registered restaurants count
- [ ] Total QR scans count
- [ ] Total reviews count
- [ ] Engagement metrics (optional)
- [ ] Adoption statistics (optional)

**Deliverable**: Admins can manage restaurants and view platform-wide analytics.

---

## Phase 10: Polish & Testing

### 10.1 Testing
- [ ] Write model tests (RSpec or Minitest)
- [ ] Write controller tests
- [ ] Write system/integration tests
- [ ] Test authentication flows
- [ ] Test QR code generation and scanning
- [ ] Test feedback submission
- [ ] Test export functionality
- [ ] Test admin workflows

### 10.2 UI/UX Polish
- [ ] Responsive design refinement
- [ ] Mobile optimization
- [ ] Error message improvements
- [ ] Loading states
- [ ] Success notifications
- [ ] Form validations (visual feedback)

### 10.3 Security & Performance
- [ ] Security audit (Brakeman)
- [ ] SQL injection prevention checks
- [ ] XSS prevention checks
- [ ] Rate limiting (if needed)
- [ ] Performance optimization (N+1 queries, caching)
- [ ] Database query optimization

**Deliverable**: Fully tested, polished MVP ready for deployment.

---

## Implementation Order (Recommended Sequence)

1. **Phase 1** - Authentication (foundation for everything)
2. **Phase 2** - Restaurant Management (core entity)
3. **Phase 3** - QR Code Generation (key feature)
4. **Phase 4** - Dish Management (required for reviews)
5. **Phase 6** - Feedback Models (data structure)
6. **Phase 5** - Review Form (customer-facing feature)
7. **Phase 7** - Restaurant Dashboard (value for restaurants)
8. **Phase 8** - Data Export (additional value)
9. **Phase 9** - Admin Dashboard (platform management)
10. **Phase 10** - Polish & Testing (quality assurance)

---

## Dependencies & Gems Added ✅

### Authentication ✅
- ✅ **Rails 8 built-in authentication** - Using Current and Session models
- ✅ `bcrypt` - Password hashing (required by has_secure_password)
- ✅ **Password reset** - Implemented with signed tokens (15-minute expiration)

### Email & Development ✅
- ✅ `letter_opener` - Email preview in development (opens in browser)
- ✅ Email templates - HTML and plain text formats

### QR Codes (Phase 3)
- `rqrcode` (QR code generation)
- `rqrcode_png` or `chunky_png` (PNG rendering)

### Export (Phase 8)
- `csv` (built-in Ruby, may need additional formatting)

### Optional (Future)
- `chartkick` or `chart.js` (analytics charts)
- `sidekiq` (background jobs if needed later)

---

## Database Schema

### ✅ Implemented (Phase 1)

```ruby
# Users table
- id
- email_address (string, unique, indexed)
- password_digest (string, bcrypt hashed)
- role (string, enum: admin, restaurant_owner, indexed)
- created_at, updated_at

# Sessions table (Rails 8 authentication)
- id
- user_id (foreign key)
- ip_address (string)
- user_agent (string)
- created_at, updated_at
```

### 📋 Planned (Future Phases)

```ruby
# Restaurants table (Phase 2)
- id, user_id, name, owner_name, email, phone, address, 
  plan, status, qr_code_secret, timestamps

# Dishes table (Phase 4)
- id, restaurant_id, name, description, active, timestamps

# Feedbacks table (Phase 6)
- id, restaurant_id, customer_name, customer_email, 
  customer_whatsapp, text_review, timestamps

# Ratings table (Phase 6)
- id, feedback_id, dish_id, rating, timestamps
```

---

## Testing Strategy

- **Unit Tests**: Models, services, helpers
- **Integration Tests**: Controller actions, workflows
- **System Tests**: End-to-end user flows (registration → QR scan → feedback)
- **Security Tests**: Authentication, authorization, input validation

---

## Next Steps

1. Review and approve this development plan
2. Decide on authentication approach (Rails 8 built-in vs Devise)
3. Begin Phase 1 implementation
4. Follow iterative development: build → test → refactor → repeat

---

**Plan Version**: 1.0  
**Last Updated**: Initial plan creation  
**Status**: Ready for approval and implementation start

