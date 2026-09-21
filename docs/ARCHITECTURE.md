# Architecture

## Stack
Next.js 14 (App Router) · Supabase (Postgres + Storage + Auth) · Vercel deployment. AI via OpenAI vision API called server-side only.

## What to Build Now vs Later
**Now:** project CRUD, image upload, AI feedback generation, challenge generation, second-submission upload, AI comparison report, project timeline.
**Later:** auth + per-user isolation, skill progress tracking, challenge library, freemium limits, human mentor reviews.

## Key User Action Flow (Upload → Feedback → Challenge → Re-upload → Comparison)
1. User creates a **project** (name, design type).
2. User uploads a design image → stored in Supabase Storage, row created in `submissions` (version 1).
3. Server calls AI vision API with the image + design context → parses response into `feedback` (strengths, weaknesses, improvements, score).
4. Server calls AI with the feedback → generates a `challenge` (practice task targeted at the weakest area).
5. User reads feedback + challenge, does the work, uploads a revised image → `submissions` (version 2).
6. Server calls AI with both images + both feedback records → generates a `comparison` (what improved, what needs work, progress score).
7. Project timeline renders all entries chronologically.

## Responsive Nav Shell
Persistent left sidebar on desktop (Projects, current project highlighted); collapses to hamburger menu on mobile. Keyboard-accessible.

## Layer Plan (build order)
1. **Data layer** — all tables, RLS, seed data, `lib/data/` queries.
2. **App logic** — server actions in `lib/actions/` for project/submission CRUD.
3. **Smart features** — `lib/ai/` modules for feedback, challenge, and comparison generation.

The core (create project, upload image, view submissions) works fully without the AI module. AI is layered on top.

## Repo Structure
```
lib/data/          # all DB reads/writes (projects, submissions, feedback, challenges, comparisons)
lib/actions/       # server-side logic (create project, upload submission, trigger AI)
lib/ai/            # AI modules (analyze_design, generate_challenge, compare_designs)
app/               # Next.js routes
  projects/        # project list + detail
  projects/[id]/   # submission timeline, upload, feedback, comparison
components/        # shared UI (sidebar, image uploader, score badge, timeline)
__tests__/         # tests beside the code they test
```

## Module Map
| Module | Responsibility | Owns | Build Order |
|--------|---------------|------|-------------|
| **projects** | Project lifecycle CRUD | `projects` table | 1st |
| **submissions** | Image upload + version tracking | `submissions` table | 2nd |
| **feedback** | AI design analysis | `feedback` table | 3rd |
| **challenges** | AI practice task generation | `challenges` table | 4th |
| **comparisons** | AI v1-vs-v2 comparison | `comparisons` table | 5th |