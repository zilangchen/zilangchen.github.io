# Website Maintenance Guide

## Scope and authority

This repository contains Zilang Chen's Jekyll/Academic Pages personal website.
Follow this file, then `objective.md`, for repository-specific work. The
repository root is the Jekyll source root; generic `src/` and experiment
directories are intentionally not used.

## Sources of truth

- `objective.md`: mission, scope, and technical overview.
- `iteration.md`: append-only maintenance record.
- `development_record.md`: legacy history; preserve it and do not append new
  maintenance entries there.
- `_config.yml`: site metadata and sidebar profile.
- `_pages/about.md`: homepage profile, contact details, education, and summary.
- `_pages/cv.md`: web CV.
- `_publications/`: publication metadata and publication detail pages.
- `_portfolio/`: project metadata and project detail pages.

## Content synchronization

When identity, affiliation, location, contact, or publication status changes,
search all sources above before editing. Keep duplicated public facts consistent.
Do not invent dates, affiliations, DOI values, acceptance status, or links.
Leave unavailable social profiles and URLs empty instead of using `#`.

Portfolio listings must be explicitly sorted by front-matter `date`, newest
first. Keep existing permalinks stable unless a redirect is added.

## Workflow

1. Inspect `git status` and preserve unrelated user changes.
2. Make minimal, reviewable edits.
3. Run `make check` and `git diff --check`.
4. Append the result to `iteration.md` using the repository template.
5. Stage only the files owned by the current task. Never use `git add .`.
6. Do not push unless the user explicitly authorizes deployment.

## Commands

```bash
make setup
make build
make check
make serve
```

If the local Ruby runtime cannot satisfy GitHub Pages dependencies, fail fast
and report the exact dependency error. Do not silently change the production
build path.
