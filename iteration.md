# Iteration Log

## Timeline (append-only)

### 2026-08-13 19:11 | Establish website maintenance workflow
- Goal: Add repository-level maintenance rules and reproducible command entrypoints.
- Changed files: `AGENTS.md`, `Makefile`, `_config.local.yml`, `iteration.md`, `scripts/check_site_content.rb`.
- Commands: `make setup`; `make check`; `git status --short --branch`.
- Outputs: Installed a repository-local GitHub Pages toolchain and added local build, preview, and content regression checks.
- Validation: `make check` passed; Jekyll 3.9.5 built the site and the content checker reported `Site content checks passed.`
- Risks / follow-ups: System Ruby 2.6/RubyGems emits a compatibility warning, but the repository-local Bundler 2.4.22 path builds successfully.
- Commit: This entry is included in the workflow bootstrap commit.

### 2026-08-13 19:27 | Refresh profile, publication, and portfolio presentation
- Goal: Update current Penn MEAM information, mark the deformation-reconstruction paper accepted at IROS 2026, hide unavailable contact links, and show newest portfolio work first.
- Changed files: `_config.yml`, `_pages/about.md`, `_pages/cv.md`, `_pages/portfolio.html`, `_portfolio/2025-07-15-deformation-reconstruction.html`, `_publications/2026-05-31-deformation-reconstruction.md`, `_includes/archive-single.html`, `_includes/footer/custom.html`, `_sass/layout/_base.scss`.
- Commands: `make check`; `make serve`; local browser checks for content, portfolio order, JavaScript console, and lightbox open/close state; `git diff --cached --check`.
- Outputs: Updated the public profile and contact details, removed duplicate CV publications, corrected the sensor description, and repaired compressed inline JavaScript and global lightbox styling.
- Validation: `make check` passed; eight portfolio dates render newest-to-oldest; the local browser loaded local CSS; the lightbox changed from `display: none` to `display: flex` and back without page errors.
- Risks / follow-ups: Production remains unchanged until the local commits are pushed to GitHub Pages.
- Commit: `cfe604f`; `0aa9b1b`; the portfolio and gallery fixes are included in the current commit.

### 2026-08-13 19:46 | Refine Profile page structure and academic citation
- Goal: Improve the Profile page's wording, contact readability, education chronology, experience classification, and first-author publication citation.
- Changed files: `_pages/about.md`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `make serve`; local browser inspection of headings, contact labels, layout, links, and wrapping behavior; `git diff --check`.
- Outputs: Reorganized research and project experience, removed lower-value education details, added semantic contact links, and aligned the IPMLP citation with DOI metadata.
- Validation: Jekyll build and content checks passed; desktop rendering was visually reviewed; contact and DOI links use normal wrapping; education and experience placement are regression-tested.
- Risks / follow-ups: The CV and publication detail pages remain separate review scopes; production remains unchanged until this commit is explicitly pushed.
- Commit: This entry is included in the Profile refinement commit.

### 2026-08-13 20:36 | Audit and correct publication records
- Goal: Reconcile both publication pages with their public papers, distinguish accepted from published work, and synchronize duplicate descriptions across the website.
- Changed files: `_publications/2025-06-15-wine-quality-ensemble.md`, `_publications/2026-05-31-deformation-reconstruction.md`, `_pages/about.md`, `_pages/cv.md`, `_pages/publications.html`, `_portfolio/2024-06-15-wine-quality-analysis.html`, `_portfolio/2025-07-15-deformation-reconstruction.html`, `_includes/publication-links.html`, `_includes/archive-single.html`, `_includes/seo.html`, `_layouts/single.html`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `make serve`; local browser inspection of the publication list, both publication details, synchronized Profile/CV/Portfolio content, links, metadata, ordering, and rendered date labels; `git diff --check` on the owned files.
- Outputs: Adopted the current arXiv title and public manuscript for the IROS 2026 paper, recorded the user-confirmed June 16, 2026 acceptance date, corrected the wine paper against its ACM proceedings version, clarified model-specific feature selection on the Wine project page, and centralized publication-link rendering.
- Validation: Jekyll 3.9.5 built successfully; the regression checker reported `Site content checks passed.`; accepted work no longer emits published-date metadata; publications and portfolio projects render newest first; local browser checks confirmed the current arXiv/DOI/PDF links and corrected status wording.
- Risks / follow-ups: arXiv:2603.19543 is explicitly identified as the current public manuscript rather than the eventual IROS proceedings version; the website should be updated again when the final proceedings manuscript and canonical IEEE record become public.
- Commit: This entry is included in the publication audit commit.

### 2026-08-25 07:10 | Hide temporal-logic project and clarify portfolio periods
- Goal: Hide the temporal-logic project pending a factual rewrite, remove the unsupported RoboCon ranking, and display month-level project periods while retaining dates only for sorting.
- Changed files: Seven visible `_portfolio/` records, the hidden temporal-logic record, `_includes/archive-single.html`, `_layouts/single.html`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: Official ROBOCON date verification; `make check`; `git diff --check`; local and production browser review.
- Outputs: Recorded the RoboCon development period as approximately December 2022 through the July 5–8, 2023 national finals, removed all `Top 30%` claims, hid the temporal-logic page, and replaced exact public project dates with month-level periods.
- Validation: `make check` passed; the local Portfolio rendered seven projects in the expected order with month-level periods; the RoboCon page showed the verified July 5–8 finals dates without `Top 30%`; the hidden temporal-logic URL rendered the site's Page Not Found page; the checked pages emitted no browser warnings or errors.
- Risks / follow-ups: The remaining legacy project pages will be reviewed individually; project links, gallery alt text, heading hierarchy, contribution summaries, and media optimization remain intentionally deferred.
- Commit: This entry is included in the portfolio visibility and period commit.

### 2026-08-26 11:58 | Rewrite climbing hand-exoskeleton project page
- Goal: Reconcile the project page with the final report and user-confirmed facts while separating measured performance from prototype scope.
- Changed files: `_portfolio/2025-01-30-climbing-hand-exo.html`, `iteration.md`.
- Commands: `make check`; `git diff --check -- _portfolio/2025-01-30-climbing-hand-exo.html`; local Jekyll preview; desktop and 390 px browser inspection.
- Outputs: Replaced the slip-detection claim with pressure-based contact-state monitoring, separated 65 mm fingertip travel from servo angular accuracy, clarified the Arduino/UART-driver/HX08L architecture and single battery pack, recorded the measured non-battery mass, added the user's contribution, revised test and prototype-scope wording, removed unsupported future-work numbers and the placeholder report link, and added gallery alt text.
- Validation: `make check` passed; the task-scoped diff check passed; the rendered page uses an H1-to-H2 hierarchy, has no horizontal overflow at 390 px, and exposes descriptive alt text for all seven gallery images. The repository-wide diff check still reports a pre-existing trailing blank line in the unrelated dirty file `format_images.py`.
- Risks / follow-ups: The existing HEVC MOV remains incompatible with the tested browser and is intentionally deferred to a separate media-optimization task; the exact servo-driver model remains omitted because the report's BOM conflicts with its design and manufacturing sections.
- Commit: This entry is included in the climbing hand-exoskeleton page commit.
