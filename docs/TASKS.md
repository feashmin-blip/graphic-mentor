# Tasks & Sprints

## Sprint 1 — Database & Core Upload Flow
**Goal:** App renders with seed data; user can create a project and upload a design.
- [ ] Create all 5 tables with permissive RLS + seed data (migration SQL)
- [ ] Build `lib/data/` queries for projects and submissions CRUD
- [ ] Build responsive sidebar nav shell (desktop sidebar / mobile hamburger)
- [ ] Project list page (shows seed projects + create button)
- [ ] Create project form (name, design type, skill area)
- [ ] Project detail page with submission timeline (renders seed data)
- [ ] Image upload to Supabase Storage → submission row (version 1)
- [ ] Handle loading / empty / error states on all screens

**DoD:** Anonymous visitor sees 3 seeded projects, can create a new project, upload an image, and see it appear in the timeline — no login required.

## Sprint 2 — AI Feedback & Challenges
**Goal:** Uploading a design triggers AI feedback + a personalized challenge.
- [ ] Build `lib/ai/analyze_design.ts` — calls vision API, parses into feedback JSON
- [ ] Build `lib/ai/generate_challenge.ts` — calls AI with feedback, generates practice task
- [ ] On submission upload, auto-run both tools server-side
- [ ] Persist feedback + challenge rows with source/confidence/review_status
- [ ] Feedback card on submission detail (strengths, weaknesses, improvements, score badge)
- [ ] Challenge card on submission detail (title, description, skill area, difficulty)
- [ ] Loading state during AI call; error state if AI fails; retry button

**DoD:** User uploads a design and sees AI-generated strengths, weaknesses, improvements, score, and a practice challenge within seconds.

## Sprint 3 — Improvement Comparison ← v1 FUNCTIONAL MILESTONE
**Goal:** Full loop works end-to-end: upload → feedback → challenge → re-upload → comparison.
- [ ] Allow second submission upload on existing project (version 2+)
- [ ] Build `lib/ai/compare_designs.ts` — sends both images + both feedback records, returns comparison
- [ ] Persist comparison row (what_improved, what_needs_work, progress_score)
- [ ] Comparison report view — side-by-side images + score delta + improvement breakdown
- [ ] Full project timeline: submissions, feedback, challenges, comparisons in chronological order
- [ ] Empty state when only 1 submission ("Upload a revised version to see your improvement")
- [ ] Error/loading states for comparison generation

**DoD (success scenario):** User creates project → uploads poster → gets feedback + challenge → uploads revised poster → sees comparison report with score delta. Zero manual steps. This is the v1 milestone — everything through here builds in the first pass.

## Sprint 4 — Lock It Down
**Goal:** Real users get private workspaces; demo policies replaced.
- [ ] Add Supabase Auth (login/signup pages)
- [ ] Populate `user_id` on all new records from session
- [ ] Replace permissive RLS with `auth.uid() = user_id` policies on all 5 tables
- [ ] Migrate seed data to a demo account or remove it
- [ ] Empty state for authenticated user with no projects ("Create your first project")
- [ ] Redirect anonymous users from create/upload actions to login (read-only browsing stays open)

**DoD:** Logged-in user sees only their own projects; another user cannot read or write another user's data.

## Text Gantt
```
Sprint 1  ████  DB + Upload Flow
Sprint 2  ████  AI Feedback + Challenges
Sprint 3  ████  Improvement Comparison  ← v1 functional
Sprint 4  ████  Lock Down (Auth + RLS)
```