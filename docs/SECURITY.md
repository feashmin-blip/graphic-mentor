# Security

## Secret Handling
- OpenAI API key stored in environment variables on the server only — never in frontend code, never in client bundles.
- Supabase service role key used only in server actions / `lib/data/` — never exposed to the browser.
- Frontend uses Supabase anon key with RLS policies enforcing access.

## Permission Model
**v1 (demo-first):** permissive RLS — all tables readable and writable without login. Seed data renders for anonymous visitors.
**Lock-down sprint:** replace with owner-scoped policies: `auth.uid() = user_id` on every table. Each row carries `user_id` so data is isolated per authenticated user.

## Approved-Tools Rule
AI actions use named tools only: `analyze_design`, `generate_challenge`, `compare_designs`. No generic code execution, no raw model tool-calling that could run arbitrary operations. Each tool has a fixed input schema and a fixed output shape.

## Audit Principle
Every AI-generated record stores `source`, `confidence`, and `review_status`. Every AI action is traceable: which tool ran, what input it received, what output it produced, when. A user can see that feedback was AI-generated and has not been human-reviewed (`review_status = 'unreviewed'`).

## Data Integrity
- Foreign keys with cascade delete keep relationships consistent.
- Version numbers on submissions are sequential per project.
- Scores are numeric and bounded (0–10 for overall, any real for progress delta).
- No destructive AI actions — deletion is human-only.