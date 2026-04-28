# Medlake — Nuxt 3 Website

Website for Medlake Training Küsnacht.
Built with Nuxt 3, Tailwind CSS, Three.js, Supabase, and DeepL.

---

## Stack

| Layer        | Tech                                                        |
|--------------|-------------------------------------------------------------|
| Framework    | Nuxt 3                                                      |
| Styling      | Tailwind CSS + CSS custom properties (dark/light theme)     |
| 3D / Hero    | Three.js (icosahedron + particles + mouse parallax)         |
| Backend      | Supabase (Postgres + Storage)                               |
| Translations | DeepL API (auto-translate locale files + DB records)        |
| Hosting      | Vercel                                                      |

---

## Quick Start

### 1. Install dependencies
```bash
npm install
```

### 2. Set up Supabase
1. Go to [supabase.com](https://supabase.com) → New project
2. In **SQL Editor** → run `supabase-schema.sql`
3. In **Storage** → create bucket `medlake` (Public)
4. In **Storage → Policies** → add anon INSERT policy on `medlake` bucket
5. In **Authentication → Policies** → add anon ALL policies on all tables

### 3. Configure environment
```bash
cp .env.example .env
```

| Variable              | Description                          |
|-----------------------|--------------------------------------|
| `SUPABASE_URL`        | Your Supabase project URL            |
| `SUPABASE_ANON_KEY`   | Supabase publishable key             |
| `SUPABASE_SERVICE_KEY`| Supabase secret key (server only)    |
| `ADMIN_PASSWORD`      | Password for `/admin`                |
| `DEEPL_API_KEY`       | DeepL API key (free tier works)      |

### 4. Run dev server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

---

## Admin Panel

Visit `/admin` → enter `ADMIN_PASSWORD`.

### Capabilities

| Section        | Actions                                                    |
|----------------|------------------------------------------------------------|
| News           | Create, edit, delete posts — image upload via Supabase Storage |
| Team           | Add/remove members, upload photos, set sort order          |
| Ärzte          | Add/edit doctors — name, specialty, photo, bio, phone      |
| Galerie        | Upload multiple photos, add captions, delete               |
| Leistungen     | Edit service names, descriptions, icons, links             |
| Feiertage      | Manage holiday opening hours                               |
| Jobs           | Create/edit job listings with sections (JSON), toggle active |
| Hero-Text      | Edit headline, subtitle, eyebrow text                      |
| Öffnungszeiten | Edit opening hours rows with optional links                |
| Kontakt        | Edit address, phone, fax, email                            |

---

## Internationalisation

Site supports **DE** (default), **EN**, **FR**, **IT**.

### Add a new language

1. Run the translation script:
```bash
DEEPL_API_KEY=your-key node scripts/translate-locales.mjs XX
```
Replace `XX` with a DeepL language code (e.g. `ES`, `PT`, `NL`).

2. Add the locale to `nuxt.config.ts`:
```ts
{ code: 'xx', name: 'Language Name', file: 'xx.json' }
```

The nav language dropdown picks it up automatically.

### DB record translation pipeline

`POST /api/translate-record` translates individual Supabase records via DeepL and caches results in a `translations` column. Supports plain text and HTML fields.

---

## Deployment (Vercel)

```bash
npm run build
```

Or connect GitHub repo to [vercel.com](https://vercel.com) and add environment variables in the Vercel dashboard.

---

## Customisation

- **Theme colors**: `assets/css/main.css` → `:root` (dark) and `[data-theme='light']`
- **Fonts**: `nuxt.config.ts` → `head.link` and `tailwind.config.ts` → `fontFamily`
- **Three.js scene**: `components/three/HeroCanvas.vue`
- **Marquee items**: `components/ui/MarqueeTicker.vue`
- **Nav links**: `components/SiteNav.vue` → `links` array
