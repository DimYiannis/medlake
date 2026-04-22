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
| Hosting    | Vercel

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
