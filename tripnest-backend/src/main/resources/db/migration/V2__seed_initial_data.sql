-- =============================================================================
-- V2: Initial Seed Data for TripNest
-- Supabase PostgreSQL / Standard PostgreSQL 14+
-- =============================================================================

-- Seed system roles
INSERT INTO roles (name) VALUES 
    ('TRAVELER'),
    ('GROUP_ADMIN'),
    ('ADMINISTRATOR')
ON CONFLICT (name) DO NOTHING;

-- Seed default curated destinations
INSERT INTO destinations (name, country, description, weather_info, is_popular)
SELECT 'Paris', 'France', 'Art, cafes, and historic neighbourhoods.', 'Check forecast before departure', TRUE
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Paris');

INSERT INTO destinations (name, country, description, weather_info, is_popular)
SELECT 'Bali', 'Indonesia', 'Beaches, temples, and tropical landscapes.', 'Check forecast before departure', TRUE
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Bali');

INSERT INTO destinations (name, country, description, weather_info, is_popular)
SELECT 'Manali', 'India', 'Mountain trails and Himalayan views.', 'Check forecast before departure', TRUE
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Manali');

INSERT INTO destinations (name, country, description, weather_info, is_popular)
SELECT 'Tokyo', 'Japan', 'Food, culture, and modern city energy.', 'Check forecast before departure', TRUE
WHERE NOT EXISTS (SELECT 1 FROM destinations WHERE name = 'Tokyo');
