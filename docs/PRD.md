# Graphic Mentor — PRD

## Problem
Beginner graphic designers can create designs but have no expert mentor to tell them what to improve next. They resort to random tutorials, generic AI chat, or unqualified friend feedback — no structured improvement loop.

## Target User
Beginner graphic designers who practice regularly but lack a professional reviewer. They can produce designs; they just don't know what's wrong or what to fix.

## Core Objects
- **Project** — a design task (e.g., "Coffee Shop Poster") that groups the full improvement loop.
- **Submission** — one uploaded design image with a version number. A project has ≥1 submissions.
- **Feedback** — AI analysis of a submission: strengths, weaknesses, specific improvements, overall score.
- **Challenge** — a personalized practice task generated from feedback (e.g., "Typography Hierarchy Drill").
- **Comparison** — AI comparison of two submissions: what improved, what still needs work, progress score.

## MVP (v1) Checklist
- [ ] Create a project and upload a design image
- [ ] AI returns 3 strengths, 3 weaknesses, 3 specific improvements, and an overall score (0–10)
- [ ] AI auto-generates a personalized practice challenge from the feedback
- [ ] User uploads a revised version of the same design
- [ ] AI compares v1 vs v2: what improved, what still needs work, progress delta score
- [ ] Project timeline shows all submissions, feedback, challenges, and comparisons in order
- [ ] All screens render with seed data — no login wall

## Non-Goals (v1)
Dashboards, skill-tracking graphs, community, mentor marketplace, payments, multi-user collaboration, career goals, streaks, portfolio scoring.

## Success Criteria
A user creates a project, uploads a poster → AI returns strengths/weaknesses/improvements/score → AI assigns a typography challenge → user uploads revised poster → AI shows "improved: hierarchy (+1.5), logo prominence (+1.0); still needs work: bottom contrast" with a progress score. The full loop completes with zero manual steps.