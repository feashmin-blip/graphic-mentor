create table if not exists projects (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  description text,
  design_type text not null default 'poster',
  skill_area text not null default 'general',
  status text not null default 'active',
  created_at timestamptz not null default now()
);
alter table projects enable row level security;
drop policy if exists "projects_v1_read" on projects;
create policy "projects_v1_read" on projects for select using (true);
drop policy if exists "projects_v1_write" on projects;
create policy "projects_v1_write" on projects for all using (true) with check (true);

create table if not exists submissions (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references projects(id) on delete cascade,
  user_id uuid,
  version_number int not null default 1,
  image_url text not null,
  notes text,
  status text not null default 'uploaded',
  created_at timestamptz not null default now()
);
alter table submissions enable row level security;
drop policy if exists "submissions_v1_read" on submissions;
create policy "submissions_v1_read" on submissions for select using (true);
drop policy if exists "submissions_v1_write" on submissions;
create policy "submissions_v1_write" on submissions for all using (true) with check (true);

create table if not exists feedback (
  id uuid primary key default gen_random_uuid(),
  submission_id uuid not null references submissions(id) on delete cascade,
  user_id uuid,
  strengths text,
  weaknesses text,
  improvements text,
  overall_score numeric default 0,
  source text default 'ai',
  confidence numeric default 0,
  review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);
alter table feedback enable row level security;
drop policy if exists "feedback_v1_read" on feedback;
create policy "feedback_v1_read" on feedback for select using (true);
drop policy if exists "feedback_v1_write" on feedback;
create policy "feedback_v1_write" on feedback for all using (true) with check (true);

create table if not exists challenges (
  id uuid primary key default gen_random_uuid(),
  feedback_id uuid not null references feedback(id) on delete cascade,
  user_id uuid,
  title text,
  description text,
  skill_area text,
  difficulty text default 'beginner',
  status text default 'assigned',
  source text default 'ai',
  confidence numeric default 0,
  review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);
alter table challenges enable row level security;
drop policy if exists "challenges_v1_read" on challenges;
create policy "challenges_v1_read" on challenges for select using (true);
drop policy if exists "challenges_v1_write" on challenges;
create policy "challenges_v1_write" on challenges for all using (true) with check (true);

create table if not exists comparisons (
  id uuid primary key default gen_random_uuid(),
  project_id uuid not null references projects(id) on delete cascade,
  from_submission_id uuid not null references submissions(id) on delete cascade,
  to_submission_id uuid not null references submissions(id) on delete cascade,
  user_id uuid,
  what_improved text,
  what_needs_work text,
  progress_score numeric default 0,
  source text default 'ai',
  confidence numeric default 0,
  review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);
alter table comparisons enable row level security;
drop policy if exists "comparisons_v1_read" on comparisons;
create policy "comparisons_v1_read" on comparisons for select using (true);
drop policy if exists "comparisons_v1_write" on comparisons;
create policy "comparisons_v1_write" on comparisons for all using (true) with check (true);

insert into projects (id, name, description, design_type, skill_area, status) values
('a0000000-0000-0000-0000-000000000001', 'Coffee Shop Poster', 'A promotional poster for a local coffee shop grand opening.', 'poster', 'layout', 'active'),
('a0000000-0000-0000-0000-000000000002', 'Tech Startup Logo', 'Logo design for a fictional tech startup called Nuvex.', 'logo', 'branding', 'active'),
('a0000000-0000-0000-0000-000000000003', 'Album Cover Art', 'Cover art for an indie folk music album titled Wanderlight.', 'album-cover', 'color-theory', 'active')
on conflict (id) do nothing;

insert into submissions (id, project_id, version_number, image_url, notes, status) values
('b0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', 1, 'https://images.unsplash.com/photo-1572490122747-3968c75945c3', 'First draft of the coffee shop poster', 'reviewed'),
('b0000000-0000-0000-0000-000000000002', 'a0000000-0000-0000-0000-000000000001', 2, 'https://images.unsplash.com/photo-1572490122747-3968c75945c3', 'Revised version after feedback on hierarchy and spacing', 'reviewed'),
('b0000000-0000-0000-0000-000000000003', 'a0000000-0000-0000-0000-000000000002', 1, 'https://images.unsplash.com/photo-1620207418303-3a0b3a3a3a3a', 'Initial logo concept with geometric mark', 'reviewed')
on conflict (id) do nothing;

insert into feedback (id, submission_id, strengths, weaknesses, improvements, overall_score, source, confidence, review_status) values
('c0000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', 'Good use of warm coffee-toned colors; clear focal point on the coffee cup illustration; consistent visual style throughout', 'Text hierarchy is flat with no clear headline distinction; excessive whitespace at the bottom third; logo is too small relative to the headline', 'Increase headline font size by 30% and use weight contrast; reduce bottom margin to balance the composition; enlarge logo 2x for stronger brand presence', 5.5, 'ai', 0.82, 'reviewed'),
('c0000000-0000-0000-0000-000000000002', 'b0000000-0000-0000-0000-000000000001', 'Improved text hierarchy with clear 3-level structure; better balance across the composition; logo is now prominent and well-placed', 'Color contrast between body text and background is still low in the bottom section; slight crowding near the contact info area', 'Darken the bottom background by 20% or lighten the body text color; add 8px padding around the contact info block', 7.0, 'ai', 0.85, 'reviewed'),
('c0000000-0000-0000-0000-000000000003', 'Clean geometric shape with a memorable concept; good use of negative space in the mark', 'Color palette is too similar to competitor brands; logo lacks versatility in monochrome; tagline font is hard to read at small sizes', 'Test 3 alternative color palettes with distinct identities; ensure the logo works in pure black and white; simplify tagline to a heavier sans-serif weight', 6.0, 'ai', 0.78, 'reviewed')
on conflict (id) do nothing;

insert into challenges (id, feedback_id, title, description, skill_area, difficulty, status, source, confidence, review_status) values
('d0000000-0000-0000-0000-000000000001', 'c0000000-0000-0000-0000-000000000001', 'Typography Hierarchy Drill', 'Redesign the poster headline using a 3-level type hierarchy: dominant headline (48pt+), secondary subhead (24pt), and body text (12pt). Use size, weight, and color contrast to create clear visual order. Sketch 3 layout variations before committing.', 'typography', 'beginner', 'completed', 'ai', 0.80, 'reviewed'),
('d0000000-0000-0000-0000-000000000002', 'c0000000-0000-0000-0000-000000000002', 'Contrast and Readability Audit', 'Adjust the bottom section of your poster so all text meets WCAG AA contrast ratio of 4.5:1. Test by converting the design to grayscale — if any text disappears into the background, increase contrast. Document before and after.', 'color-theory', 'intermediate', 'assigned', 'ai', 0.83, 'reviewed'),
('d0000000-0000-0000-0000-000000000003', 'Brand Color Exploration', 'Generate 3 logo variations with different color palettes: one monochrome, one warm-toned, one cool-toned. Place them side by side and evaluate which is most distinctive against typical competitor brands in the tech sector.', 'branding', 'intermediate', 'assigned', 'ai', 0.75, 'reviewed')
on conflict (id) do nothing;

insert into comparisons (id, project_id, from_submission_id, to_submission_id, what_improved, what_needs_work, progress_score, source, confidence, review_status) values
('e0000000-0000-0000-0000-000000000001', 'a0000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000001', 'b0000000-0000-0000-0000-000000000002', 'Text hierarchy significantly improved with clear 3-level structure (+1.5); logo prominence and placement much stronger (+1.0); overall composition balance is noticeably better (+0.5)', 'Color contrast in the bottom section still needs work — darken background or lighten text; slight crowding near contact info needs padding adjustment', 1.5, 'ai', 0.84, 'reviewed')
on conflict (id) do nothing;