-- ══════════════════════════════════════════
--  Medlake — Supabase Schema
--  Run this in: Supabase → SQL Editor → New Query
-- ══════════════════════════════════════════

-- 1. News posts
create table if not exists news_posts (
  id            bigserial primary key,
  title         text not null,
  slug          text unique,
  tag           text default 'News',
  content       text,
  image_url     text,
  published     boolean default false,
  published_at  timestamptz default now(),
  created_at    timestamptz default now()
);

-- 2. Team members
create table if not exists team_members (
  id          bigserial primary key,
  name        text not null,
  role        text,
  photo_url   text,
  sort_order  int default 0,
  created_at  timestamptz default now()
);

-- 3. Gallery photos
create table if not exists gallery_photos (
  id          bigserial primary key,
  url         text not null,
  caption     text,
  sort_order  int default 0,
  created_at  timestamptz default now()
);

-- 4. Site settings (key/value JSON store)
create table if not exists site_settings (
  key    text primary key,
  value  jsonb not null
);

-- ── Storage bucket ──
-- In Supabase Dashboard → Storage → New Bucket
-- Name: "medlake" | Public: YES

-- ── Row Level Security ──
-- Allow public reads, restrict writes to service role

alter table news_posts    enable row level security;
alter table team_members  enable row level security;
alter table gallery_photos enable row level security;
alter table site_settings  enable row level security;

-- Public read policies
create policy "Public read news"    on news_posts    for select using (published = true);
create policy "Public read team"    on team_members  for select using (true);
create policy "Public read gallery" on gallery_photos for select using (true);
create policy "Public read settings" on site_settings for select using (true);

-- Anon insert/update/delete disabled → admin panel uses service role key via API routes
-- (or you can add policies for authenticated users if you add Supabase Auth later)

-- ── Seed data ──
insert into team_members (name, role, sort_order) values
  ('Andrea Badstuber',  'Geschäftsführerin',       1),
  ('Natalie Oriet Rota','Fitnessinstruktorin',       2),
  ('Tiffany Ismann',    'Fitnessinstruktorin',       3),
  ('Leo Tomazini',      'Bewegungsspezialist',       4)
on conflict do nothing;

insert into news_posts (title, slug, tag, content, published, published_at) values
  (
    'Sommeraktion: 3 Monate Premium Fitness für 275 CHF',
    'sommeraktion-2025',
    'Aktion',
    '<p>Profitieren Sie vom 1. Mai bis 31. Juli 2025 von unserer Sommeraktion: 3 Monate Premium Fitness für 275 Franken! Krafttraining ist die beste Investition in Ihre Gesundheit.</p>',
    true,
    '2024-04-16'
  )
on conflict do nothing;
