# Medlake — Nuxt 3 Website

Website for Medlake Training Küsnacht.
Built with Nuxt 3, Tailwind CSS, Three.js, and Supabase.

---

## Stack

| Layer      | Tech                        |
|------------|-----------------------------|
| Framework  | Nuxt 3                      |
| Styling    | Tailwind CSS                |
| 3D / Hero  | Three.js (icosahedron + particles + mouse parallax) |
| Backend    | Supabase (Postgres + Storage + Auth) |
| Hosting    | Vercel / Netlify / Node VPS |

---

## Quick Start

### 1. Install dependencies
```bash
npm install
```

### 2. Set up Supabase
1. Go to [supabase.com](https://supabase.com) → New project
2. In **SQL Editor** → run the contents of `supabase-schema.sql`
3. In **Storage** → create a bucket called `medlake` (set to **Public**)
4. Copy your project URL and API keys

### 3. Configure environment
```bash
cp .env.example .env
```

Fill in `.env`:
```
SUPABASE_URL=https://your-project.supabase.co
SUPABASE_ANON_KEY=your-anon-key
SUPABASE_SERVICE_KEY=your-service-role-key
ADMIN_PASSWORD=choose-a-secure-password
```

### 4. Run dev server
```bash
npm run dev
```

Open [http://localhost:3000](http://localhost:3000)

---

## Admin Panel

Visit `/admin` → enter your `ADMIN_PASSWORD`.

### What you can manage:

| Section       | Actions                                  |
|---------------|------------------------------------------|
| News          | Create, edit, delete posts with images   |
| Team          | Add/remove members, upload photos        |
| Galerie       | Upload/delete photos, add captions       |
| Hero-Text     | Edit headline, subtitle, eyebrow text    |
| Öffnungszeiten| Edit opening hours rows                  |
| Leistungen    | Edit service names and descriptions      |

---

## Project Structure

```
medlake/
├── assets/css/        # Global styles
├── components/
│   ├── three/         # HeroCanvas.vue (Three.js)
│   ├── ui/            # MarqueeTicker, etc.
│   └── sections/      # Hero, Stats, Services, Team, Gallery, News, HoursContact
├── composables/       # useReveal, useSupabase
├── layouts/           # default.vue, admin.vue
├── pages/
│   ├── index.vue      # Home
│   ├── news/          # Listing + detail
│   └── admin/         # Login + dashboard
├── server/api/        # Login endpoint
├── supabase-schema.sql
└── nuxt.config.ts
```

---

## Deployment (Vercel)

```bash
npm run build
```

Or connect your GitHub repo to [vercel.com](https://vercel.com) and add the environment variables in the Vercel dashboard.

---

## Customisation

- **Fonts**: Change in `nuxt.config.ts` → `head.link` and `tailwind.config.ts` → `fontFamily`
- **Three.js scene**: Edit `components/three/HeroCanvas.vue`
- **Marquee items**: Edit `components/ui/MarqueeTicker.vue`
- **Services list**: Editable via admin panel, or directly in `components/sections/ServicesSection.vue`
- **Colors**: All in `tailwind.config.ts` under `colors.ml`

---

## Pages to add

These stub pages can be created in `/pages/`:
- `/pages/team.vue` — full team page
- `/pages/aerzte.vue` — doctors
- `/pages/preise.vue` — pricing
- `/pages/kontakt.vue` — standalone contact page
- `/pages/jobs.vue` — jobs
- `/pages/agb.vue` — terms
