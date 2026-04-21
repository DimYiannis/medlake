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

-- 5. Doctors
create table if not exists doctors (
  id          bigserial primary key,
  name        text not null,
  role        text,
  specialty   text,
  phone       text,
  photo_url   text,
  bio         jsonb default '[]'::jsonb,
  sort_order  int default 0
);

-- 6. Services
create table if not exists services (
  id          bigserial primary key,
  name        text not null,
  description text,
  icon        text,
  link        text,
  sort_order  int default 0
);

-- 7. Holidays
create table if not exists holidays (
  id          bigserial primary key,
  year        text not null,
  date        text not null,
  holiday     text not null,
  hours       text not null,
  sort_order  int default 0
);

-- 8. Jobs
create table if not exists jobs (
  id          bigserial primary key,
  title       text not null,
  subtitle    text,
  intro       text,
  sections    jsonb default '[]'::jsonb,
  active      boolean default true,
  created_at  timestamptz default now()
);

-- ── Storage bucket ──
-- In Supabase Dashboard → Storage → New Bucket
-- Name: "medlake" | Public: YES

-- ── Row Level Security ──
-- Allow public reads, restrict writes to service role

alter table news_posts     enable row level security;
alter table team_members   enable row level security;
alter table gallery_photos enable row level security;
alter table site_settings  enable row level security;
alter table doctors        enable row level security;
alter table services       enable row level security;
alter table holidays       enable row level security;
alter table jobs           enable row level security;

-- Public read policies
create policy "Public read news"      on news_posts    for select using (published = true);
create policy "Public read team"      on team_members  for select using (true);
create policy "Public read gallery"   on gallery_photos for select using (true);
create policy "Public read settings"  on site_settings  for select using (true);
create policy "Public read doctors"   on doctors        for select using (true);
create policy "Public read services"  on services       for select using (true);
create policy "Public read holidays"  on holidays       for select using (true);
create policy "Public read jobs"      on jobs           for select using (active = true);

-- Anon insert/update/delete disabled → admin panel uses service role key via API routes
-- (or you can add policies for authenticated users if you add Supabase Auth later)

-- ── Seed data ──
insert into team_members (name, role, sort_order) values
  ('Andrea Badstuber',  'Geschäftsführerin',       1),
  ('Natalie Oriet Rota','Fitnessinstruktorin',       2),
  ('Tiffany Ismann',    'Fitnessinstruktorin',       3),
  ('Leo Tomazini',      'Bewegungsspezialist',       4)
on conflict do nothing;

insert into site_settings (key, value) values (
  'main',
  '{
    "hero_title_1": "Die Kraft",
    "hero_title_2": "zu heilen. Die Kraft zu bewegen.",
    "hero_subtitle": "Medizinisches Kompetenzzentrum für gesundheitsorientiertes Kraft- und Ausdauertraining.",
    "hero_eyebrow": "Küsnacht, Schweiz — seit 2001",
    "opening_hours": [
      { "day": "Montag – Freitag",  "time": "06:30 – 21:00", "link": null },
      { "day": "Samstag – Sonntag", "time": "08:00 – 18:00", "link": null },
      { "day": "Feiertage",         "time": "Variabel →",    "link": "/feiertage" }
    ],
    "contact": {
      "address": "Seestrasse 39, 8700 Küsnacht",
      "phone":   "+41 44 991 22 02",
      "fax":     "+41 44 991 22 03",
      "email":   "info@medlake.ch"
    },
    "services": []
  }'::jsonb
) on conflict (key) do nothing;

insert into doctors (name, role, specialty, phone, bio, sort_order) values
  ('Dr. med. Beat-Sven Maurer', 'Mitinhaber', 'Facharzt Allgemeine Medizin, Manuelle Medizin SAMM', '044 910 35 10',
   '["Staatsexamen 1990 in Zürich","Ausbildung zum Facharzt für Allgemeine Medizin","Ausbildung in medizinischer Kräftigungstherapie GMKT an der Universität San Diego","Praxistätigkeit in Gemeinschaftspraxis in Küsnacht"]'::jsonb, 1),
  ('Dr. med. Jiri Mach', 'Mitinhaber', 'Spezialarzt FMH Rheumatologie, Rücken und Gelenke. Manuelle Medizin SAMM, Ultraschall SGUM', '044 991 24 34',
   '["Staatsexamen 1991 in Zürich und Tschechien","Ausbildung zum Facharzt für Rheumatologie FMH","1998 Ausbildung an der Universität Gainesville / Florida in medizinischer Kräftigungstherapie","2003 Beitritt in rheumatologische Gemeinschaftspraxis in Winterthur und Küsnacht, Seestrasse 39","Fähigkeitsausweis für manuelle Medizin SAMM sowie Ultraschall SGUM Gelenkdiagnostik"]'::jsonb, 2)
on conflict do nothing;

insert into services (name, description, icon, link, sort_order) values
  ('Krafttraining', 'Gesundheitsorientiertes Krafttraining führt zu einem besseren Allgemeinzustand. Mitverantwortlich für akute und chronische Schmerzen des Bewegungsapparates sind schwache Muskeln. Wir trainieren präzise, medizinisch begleitet — mit messbaren Ergebnissen.', '/images/service-icon-6.png', '/leistungen/krafttraining', 1),
  ('Herz & Kreislauf', 'Cardio-Training führt zur Ökonomisierung des Herzkreislaufsystems mit verbesserter Muskeldurchblutung. Trainierte Herzen schlagen ruhiger, kraftvoller, ausdauernder.', '/images/service-icon-7.png', '/leistungen/herz-kreislauf', 2),
  ('Hilfe bei Schmerzen', 'Schmerzen im Nacken, Rücken und Gelenken werden von drei Spezialärzten mit computerisierten Kräftigungsgeräten behandelt — unterstützt von Physiotherapeutinnen.', '/images/service-icon-2.png', '/leistungen/hilfe-bei-schmerzen', 3),
  ('Firmenfitness', 'Ihr Beitrag zur Gesundheit Ihrer Mitarbeitenden. Profitieren Sie von unserer Firmen-Kooperation und investieren Sie in die Leistungsfähigkeit Ihres Teams.', '/images/service-icon-5.png', '/leistungen/firmenfitness', 4),
  ('Ärztliche Trainingstherapie (MED-X)', 'Computerisierte MedX-Geräte fördern den Muskelaufbau im Nacken- und Lendenbereich. Jede Therapieeinheit erfolgt in Einzelbehandlung mit dem Arzt.', '/images/service-icon-8.png', '/leistungen/med-x', 5),
  ('Physiotherapie & MTT', 'Medizinische Trainingstherapie zur Steigerung der Belastbarkeit des Bewegungsapparates — individuell abgestimmt und von Krankenkassen anerkannt.', '/images/service-icon-7.png', '/leistungen/physiotherapie', 6),
  ('Galileo Vibrationsplatte', 'Seitenalternierende Vibrationsbewegungen bringen Muskeln über Dehnreflexe zu vermehrten Kontraktionen — für Sport, Rehabilitation und Schmerztherapie.', '/images/service-icon-3.png', '/leistungen/galileo', 7),
  ('KINESIS Training', 'Einzigartiges Ganzkörpertraining durch Seilrollen-Widerstand. Kraft, Flexibilität, Koordination und Haltungskontrolle — alles in einem System.', '/images/service-icon-4.png', '/leistungen/kinesis', 8)
on conflict do nothing;

insert into holidays (year, date, holiday, hours, sort_order) values
  ('2026', '03.04.2026', 'Karfreitag',   '08:00–18:00', 1),
  ('2026', '06.04.2026', 'Ostermontag',  '08:00–18:00', 2),
  ('2026', '01.05.2026', '1. Mai',        '08:00–18:00', 3),
  ('2026', '14.05.2026', 'Auffahrt',      '08:00–18:00', 4),
  ('2026', '25.05.2026', 'Pfingstmontag', '08:00–18:00', 5),
  ('2026', '01.08.2026', '1. August',     '08:00–18:00', 6),
  ('2026', '24.12.2026', 'Heiligabend',   '09:00–16:00', 7),
  ('2026', '25.12.2026', 'Weihnachtstag', 'GESCHLOSSEN', 8),
  ('2026', '26.12.2026', 'Stephanstag',   '08:00–18:00', 9),
  ('2026', '31.12.2026', 'Silvester',     '09:00–16:00', 10),
  ('2027', '01.01.2027', 'Neujahr',       '09:00–16:00', 11),
  ('2027', '26.03.2027', 'Karfreitag',    '08:00–18:00', 12),
  ('2027', '29.03.2027', 'Ostermontag',   '08:00–18:00', 13),
  ('2027', '01.05.2027', '1. Mai',         '08:00–18:00', 14),
  ('2027', '06.05.2027', 'Auffahrt',       '08:00–18:00', 15),
  ('2027', '17.05.2027', 'Pfingstmontag',  '08:00–18:00', 16),
  ('2027', '01.08.2027', '1. August',      '08:00–18:00', 17),
  ('2027', '24.12.2027', 'Heiligabend',    '09:00–16:00', 18)
on conflict do nothing;

insert into jobs (title, subtitle, intro, sections, active) values
  (
    'Praktikum — Spezialist Bewegungs- und Gesundheitsförderung',
    'mit eidg. Fachausweis · ab 30.01.2026 oder nach Vereinbarung',
    'Du willst deine Leidenschaft für Fitness und Gesundheit zum Beruf und zu deiner Karriere machen? Dann bewirb dich jetzt für unser Praktikum in Küsnacht ZH.',
    '[{"title":"Hauptaufgaben","items":["Kundenbetreuung","Beratung und Verkauf von Mitgliedschaften","Erstellen von Trainingsplänen","Durchführen von Probe- und Kontrolltraining","Administrative Arbeiten am Empfang","Verantwortung für Ordnung und Sauberkeit im Betrieb"]},{"title":"Anforderungen","items":["Alter 20–35 Jahre","EFZ Abschluss oder Matura","Sportlich mit persönlicher Erfahrung im Fitness / Sport","Flexibel bezüglich Arbeitseinsätzen (Abend, Wochenende, Feiertage)","Gute Deutschkenntnisse in Wort und Schrift, Englisch von Vorteil","Pünktlichkeit, Zuverlässigkeit und Teamfähigkeit","Dienstleistungsorientiert — gepflegtes Erscheinungsbild","Talent, Menschen zu begeistern und zu motivieren"]},{"title":"Was wir bieten","items":["Ein freundliches, aufgestelltes und dynamisches Team","Attraktive Anstellungsbedingungen","Klare Strukturen und definierte Abläufe","Abwechslungsreiche Tätigkeit in unserem Kompetenzzentrum","Aus- und Weiterbildungsmöglichkeiten SAFS"]}]'::jsonb,
    true
  )
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
