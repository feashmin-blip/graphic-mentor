# Data Model

## projects
| Field | Type | Notes |
|-------|------|-------|
| id | uuid PK | `gen_random_uuid()` |
| user_id | uuid | nullable (owner-scoping at lock-down) |
| name | text | not null |
| description | text | |
| design_type | text | poster, logo, album-cover, etc. |
| skill_area | text | layout, typography, color-theory, branding |
| status | text | active / archived |
| created_at | timestamptz | default now() |

**Relationships:** has many `submissions`; has many `comparisons`.

## submissions
| Field | Type | Notes |
|-------|------|-------|
| id | uuid PK | |
| project_id | uuid FK → projects | not null, cascade delete |
| user_id | uuid | nullable |
| version_number | int | default 1 |
| image_url | text | Supabase Storage path |
| notes | text | user's notes on this version |
| status | text | uploaded / reviewed |
| created_at | timestamptz | |

**Relationships:** belongs to `project`; has one `feedback`.

## feedback (AI-generated)
| Field | Type | Notes |
|-------|------|-------|
| id | uuid PK | |
| submission_id | uuid FK → submissions | not null, cascade delete |
| user_id | uuid | nullable |
| strengths | text | AI — what works well |
| weaknesses | text | AI — what's wrong |
| improvements | text | AI — specific actionable fixes |
| overall_score | numeric | AI — 0–10 |
| source | text | default 'ai' |
| confidence | numeric | 0–1 |
| review_status | text | default 'unreviewed' |
| created_at | timestamptz | |

## challenges (AI-generated)
| Field | Type | Notes |
|-------|------|-------|
| id | uuid PK | |
| feedback_id | uuid FK → feedback | not null, cascade delete |
| user_id | uuid | nullable |
| title | text | AI — task name |
| description | text | AI — detailed instructions |
| skill_area | text | AI — targeted skill |
| difficulty | text | beginner / intermediate / advanced |
| status | text | assigned / completed |
| source | text | default 'ai' |
| confidence | numeric | 0–1 |
| review_status | text | default 'unreviewed' |
| created_at | timestamptz | |

## comparisons (AI-generated)
| Field | Type | Notes |
|-------|------|-------|
| id | uuid PK | |
| project_id | uuid FK → projects | not null |
| from_submission_id | uuid FK → submissions | earlier version |
| to_submission_id | uuid FK → submissions | later version |
| user_id | uuid | nullable |
| what_improved | text | AI — areas that got better |
| what_needs_work | text | AI — remaining issues |
| progress_score | numeric | AI — delta vs previous score |
| source | text | default 'ai' |
| confidence | numeric | 0–1 |
| review_status | text | default 'unreviewed' |
| created_at | timestamptz | |

## RLS Notes (v1 — demo-first)
All tables have permissive select + write policies so the app renders without login. Lock-down sprint replaces these with `auth.uid() = user_id` policies.

**AI field convention:** every AI-generated table stores `source`, `confidence`, and `review_status` alongside its content fields.