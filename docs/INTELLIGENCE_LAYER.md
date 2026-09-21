# Intelligence Layer

## Messy Inputs
- Uploaded design images — varying quality, resolution, format (PNG/JPG/WEBP), design type (poster, logo, cover).
- User notes — free text, may be empty or vague.
- No structured metadata from the user beyond project name and design type.

## Auto-Structure Schema (AI response for feedback)
```json
{
  "strengths": [
    "Good use of warm colors",
    "Clear focal point on the coffee cup",
    "Consistent visual style"
  ],
  "weaknesses": [
    "Text hierarchy is flat",
    "Excessive whitespace at bottom",
    "Logo is too small relative to headline"
  ],
  "improvements": [
    "Increase headline font size by 30%",
    "Reduce bottom margin to balance composition",
    "Enlarge logo 2x for brand presence"
  ],
  "overall_score": 5.5,
  "scores_by_criteria": {
    "hierarchy": 4,
    "contrast": 6,
    "alignment": 5,
    "spacing": 4,
    "color": 7,
    "concept": 6
  }
}
```

## Events to Track
- `submission_uploaded` — version, project, timestamp
- `feedback_generated` — score, confidence, timestamp
- `challenge_assigned` — skill area, difficulty, timestamp
- `challenge_completed` — timestamp
- `comparison_generated` — progress score, timestamp

## Scoring Rules (v1 — rule-based weights)
Overall score = weighted average of 6 criteria (0–10 each):
- Hierarchy: 25%
- Contrast: 20%
- Alignment: 20%
- Spacing: 15%
- Color: 10%
- Concept: 10%

Progress score = `to_submission_score − from_submission_score`.

## What Gets Ranked
- Projects by improvement delta (most improved first on project list).
- Challenges by priority (weakness severity × skill gap).

## v1 vs Later
**v1:** single-image analysis, one challenge per feedback, one comparison per submission pair.
**Later:** multi-image batch analysis, skill progress trends across projects, challenge difficulty calibration, improvement streaks.