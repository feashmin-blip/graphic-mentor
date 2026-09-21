# Test Plan

## v1 Success Scenario (manual)
1. Open app (no login) → verify 3 seeded projects appear on the projects list.
2. Click "New Project" → enter "Event Flyer", select design type "poster", skill area "layout" → submit.
3. Verify new project appears at top of list.
4. Open the project → verify empty timeline state shows ("Upload your first design").
5. Upload a design image (PNG/JPG) → verify loading state appears.
6. Verify AI feedback card appears: 3 strengths, 3 weaknesses, 3 improvements, score badge (0–10).
7. Verify challenge card appears: title, description, skill area, difficulty.
8. Upload a second image (revised version) → verify version number = 2.
9. Verify comparison report appears: side-by-side images, what improved, what needs work, progress score delta.
10. Verify project timeline shows submission 1 → feedback → challenge → submission 2 → comparison in order.

## Empty States
- **No projects:** Project list shows empty state with "Create your first project" CTA.
- **No submissions:** Project detail shows "Upload your first design to get AI feedback."
- **Only 1 submission:** Comparison section shows "Upload a revised version to see your improvement report."
- **No feedback yet:** Shows loading spinner with "Analyzing your design…" (not a blank card).

## Error States
- **AI call fails:** Feedback card shows error message + "Retry analysis" button. Submission row still exists.
- **Image upload fails:** Upload form shows error, no submission row created.
- **Comparison fails:** Shows error + retry; both submissions and feedback remain visible.
- **Network error on project list:** Shows error state + retry.

## Permission Tests (post lock-down)
- User A creates a project → User B cannot see it in their project list.
- User B tries to access User A's project URL → redirected / 404.
- Anonymous user can browse seed projects read-only but cannot create/upload.