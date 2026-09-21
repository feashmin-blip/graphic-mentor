# Agentic Layer

## Risk Levels & Actions

### Low — Auto-execute (no approval)
- **Generate feedback** — AI analyzes uploaded design, writes strengths/weaknesses/improvements/score. Tool: `analyze_design`.
- **Generate challenge** — AI creates a practice task from feedback. Tool: `generate_challenge`.
- **Generate comparison** — AI compares two submissions, writes what improved / needs work / progress score. Tool: `compare_designs`.

### Medium — Light approval (user confirms)
- **Mark challenge complete** — user clicks "I did this" on an assigned challenge.
- **Update project status** — user archives a project.

### Human-only — Never automated
- **Delete project** — permanent data loss; user must confirm explicitly.
- **Delete submission** — permanent; user must confirm.

## Named Tools
| Tool | Input | Output | Risk |
|------|-------|--------|------|
| `analyze_design` | image_url, design_type, skill_area | feedback JSON | low |
| `generate_challenge` | feedback record | challenge JSON | low |
| `compare_designs` | two submission records + feedback records | comparison JSON | low |

No raw `run_any` / `send_any` — approved named tools only.

## Audit Log Fields
Every AI action logs: `action_type`, `tool_name`, `input_ref` (submission/feedback id), `output_ref` (result id), `confidence`, `timestamp`, `user_id` (when auth enabled).

## v1 vs Later
**v1:** all three AI tools auto-run on upload / second-upload. No human-in-the-loop approval for AI generation.
**Later:** allow user to edit/regenerate feedback before challenge is created; human mentor review as a medium-risk action; bulk re-analysis of older submissions.