-- Run this in the Supabase SQL editor

-- Add translations JSONB column to all translatable tables
ALTER TABLE team_members  ADD COLUMN IF NOT EXISTS translations JSONB DEFAULT '{}';
ALTER TABLE services      ADD COLUMN IF NOT EXISTS translations JSONB DEFAULT '{}';
ALTER TABLE doctors       ADD COLUMN IF NOT EXISTS translations JSONB DEFAULT '{}';
ALTER TABLE news_posts    ADD COLUMN IF NOT EXISTS translations JSONB DEFAULT '{}';

-- Trigger function: wipe translations cache when German content changes
CREATE OR REPLACE FUNCTION clear_translations()
RETURNS TRIGGER LANGUAGE plpgsql AS $$
BEGIN
  NEW.translations = '{}';
  RETURN NEW;
END;
$$;

-- team_members: clear cache when role changes
DROP TRIGGER IF EXISTS team_members_clear_translations ON team_members;
CREATE TRIGGER team_members_clear_translations
  BEFORE UPDATE OF role ON team_members
  FOR EACH ROW EXECUTE FUNCTION clear_translations();

-- services: clear cache when name or description changes
DROP TRIGGER IF EXISTS services_clear_translations ON services;
CREATE TRIGGER services_clear_translations
  BEFORE UPDATE OF name, description ON services
  FOR EACH ROW EXECUTE FUNCTION clear_translations();

-- doctors: clear cache when specialty or bio changes
DROP TRIGGER IF EXISTS doctors_clear_translations ON doctors;
CREATE TRIGGER doctors_clear_translations
  BEFORE UPDATE OF specialty, bio ON doctors
  FOR EACH ROW EXECUTE FUNCTION clear_translations();

-- news_posts: clear cache when title, content or tag changes
DROP TRIGGER IF EXISTS news_posts_clear_translations ON news_posts;
CREATE TRIGGER news_posts_clear_translations
  BEFORE UPDATE OF title, content, tag ON news_posts
  FOR EACH ROW EXECUTE FUNCTION clear_translations();
