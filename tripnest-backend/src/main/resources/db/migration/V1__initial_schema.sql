-- =============================================================================
-- V1: Initial TripNest Database Schema
-- Supabase PostgreSQL / Standard PostgreSQL 14+
-- =============================================================================

-- 1. Roles table
CREATE TABLE IF NOT EXISTS roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- 2. Destinations table
CREATE TABLE IF NOT EXISTS destinations (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    country VARCHAR(255),
    description TEXT,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    weather_info VARCHAR(255),
    is_popular BOOLEAN DEFAULT FALSE
);

-- 3. Users table
CREATE TABLE IF NOT EXISTS users (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    oauth_google BOOLEAN DEFAULT FALSE,
    location VARCHAR(255),
    created_at TIMESTAMP WITHOUT TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- 4. User languages (ElementCollection)
CREATE TABLE IF NOT EXISTS user_languages (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    language VARCHAR(100) NOT NULL,
    PRIMARY KEY (user_id, language)
);

-- 5. User preferences (ElementCollection Map)
CREATE TABLE IF NOT EXISTS user_preferences (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    preference_key VARCHAR(100) NOT NULL,
    preference_value TEXT,
    PRIMARY KEY (user_id, preference_key)
);

-- 6. User favorite destinations (ManyToMany)
CREATE TABLE IF NOT EXISTS user_favorite_destinations (
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    destination_id INTEGER NOT NULL REFERENCES destinations(id) ON DELETE CASCADE,
    PRIMARY KEY (user_id, destination_id)
);

-- 7. Attractions table
CREATE TABLE IF NOT EXISTS attractions (
    id SERIAL PRIMARY KEY,
    destination_id INTEGER NOT NULL REFERENCES destinations(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description VARCHAR(1000)
);

-- 8. Trips table
CREATE TABLE IF NOT EXISTS trips (
    id SERIAL PRIMARY KEY,
    owner_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    destination_id INTEGER NOT NULL REFERENCES destinations(id) ON DELETE RESTRICT,
    title VARCHAR(255) NOT NULL,
    description VARCHAR(2000),
    start_date DATE,
    end_date DATE,
    status VARCHAR(50) DEFAULT 'PLANNED'
);

-- 9. Trip Members table
CREATE TABLE IF NOT EXISTS trip_members (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    role VARCHAR(50) NOT NULL DEFAULT 'MEMBER',
    CONSTRAINT uq_trip_member UNIQUE (trip_id, user_id)
);

-- 10. Join Requests table
CREATE TABLE IF NOT EXISTS join_requests (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    requester_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(50) NOT NULL DEFAULT 'PENDING',
    CONSTRAINT uq_trip_join_request UNIQUE (trip_id, requester_id)
);

-- 11. Budgets table
CREATE TABLE IF NOT EXISTS budgets (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL UNIQUE REFERENCES trips(id) ON DELETE CASCADE,
    amount NUMERIC(12, 2) NOT NULL,
    currency VARCHAR(10) NOT NULL DEFAULT 'INR'
);

-- 12. Expenses table
CREATE TABLE IF NOT EXISTS expenses (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    budget_id INTEGER NOT NULL REFERENCES budgets(id) ON DELETE CASCADE,
    payer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    category VARCHAR(100) NOT NULL,
    amount NUMERIC(12, 2) NOT NULL,
    date DATE NOT NULL,
    receipt_link TEXT
);

-- 13. Itineraries table
CREATE TABLE IF NOT EXISTS itineraries (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    day_number INTEGER NOT NULL,
    title VARCHAR(255),
    description TEXT
);

-- 14. Activities table
CREATE TABLE IF NOT EXISTS activities (
    id SERIAL PRIMARY KEY,
    itinerary_id INTEGER NOT NULL REFERENCES itineraries(id) ON DELETE CASCADE,
    name VARCHAR(255) NOT NULL,
    description TEXT,
    location VARCHAR(255),
    start_time TIME WITHOUT TIME ZONE,
    end_time TIME WITHOUT TIME ZONE
);

-- 15. Notifications table
CREATE TABLE IF NOT EXISTS notifications (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    message VARCHAR(1000) NOT NULL,
    type VARCHAR(100) NOT NULL,
    read BOOLEAN NOT NULL DEFAULT FALSE,
    created_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- 16. Media Documents table
CREATE TABLE IF NOT EXISTS media_documents (
    id SERIAL PRIMARY KEY,
    trip_id INTEGER NOT NULL REFERENCES trips(id) ON DELETE CASCADE,
    uploaded_by INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    file_name VARCHAR(255) NOT NULL,
    file_type VARCHAR(100) NOT NULL,
    file_path VARCHAR(500) NOT NULL,
    file_size BIGINT NOT NULL,
    uploaded_at TIMESTAMP WITHOUT TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Performance Indexes
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_trips_owner ON trips(owner_id);
CREATE INDEX IF NOT EXISTS idx_trip_members_trip ON trip_members(trip_id);
CREATE INDEX IF NOT EXISTS idx_trip_members_user ON trip_members(user_id);
CREATE INDEX IF NOT EXISTS idx_expenses_trip ON expenses(trip_id);
CREATE INDEX IF NOT EXISTS idx_itineraries_trip ON itineraries(trip_id);
CREATE INDEX IF NOT EXISTS idx_activities_itinerary ON activities(itinerary_id);
CREATE INDEX IF NOT EXISTS idx_notifications_user_unread ON notifications(user_id, read);
