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

### 2026-08-26 12:33 | Standardize Portfolio cover layout
- Goal: Give every Portfolio listing cover the same centered dimensions while keeping diagrams, CAD renders, landscape photos, and portrait photos fully visible.
- Changed files: `_pages/portfolio.html`, `_sass/layout/_archive.scss`, `iteration.md`.
- Commands: `make check`; `make serve`; `git diff --check -- _pages/portfolio.html _sass/layout/_archive.scss`; local browser inspection at desktop and 390 px widths; cover-lightbox interaction check; Publication and project-gallery scope checks.
- Outputs: Added a Portfolio-only style scope and standardized all seven visible cover frames to a centered 4:3 layout with contained, non-cropped images, consistent spacing, a subtle neutral background, and no float-based positioning.
- Validation: `make check` passed; all seven frames measured 756 x 567 px in the 1280 px desktop preview and 343 x 257 px at 390 px, with identical horizontal positions, `object-fit: contain`, and no horizontal overflow. The lightbox opened and closed successfully; Publication markup and the existing project Gallery styles remained outside the new scope. The task-scoped diff check passed; the repository-wide diff check still reports the pre-existing trailing blank line in the unrelated dirty file `format_images.py`.
- Risks / follow-ups: Portrait and extra-wide source images intentionally show balanced internal whitespace instead of being cropped; the user will review this first production layout before any optional visual-density tuning.
- Commit: This entry is included in the Portfolio cover-layout commit.

### 2026-08-26 12:38 | Version the main stylesheet URL
- Goal: Prevent an already-open browser from retaining the previous Portfolio CSS for GitHub Pages' ten-minute cache window after a deployment.
- Changed files: `_includes/head.html`, `iteration.md`.
- Commands: production CSS header and content checks; `make check`; generated HTML inspection; `git diff --check -- _includes/head.html iteration.md`.
- Outputs: Added the GitHub Pages build revision to the main stylesheet URL, with a local-build timestamp fallback, so each deployment requests its own immutable CSS URL without changing the stylesheet itself.
- Validation: The production CSS contained the new Portfolio rules, while the initial browser review still held the old unversioned CSS; the revisioned build must render a non-empty `main.css?v=<revision>` URL and will be rechecked after deployment.
- Risks / follow-ups: GitHub Pages supplies the deployed commit SHA through `jekyll-github-metadata`; local builds use `site.time` so the query value is never empty. No user data, credentials, or external dependency is introduced.
- Commit: This entry is included in the stylesheet cache-versioning commit.

### 2026-08-26 13:16 | Expand soft-robot deformation project page
- Goal: Explain the complete training and inference pipeline, distinguish the team's method from the author's individual contributions, and align the public claims with the paper and user-confirmed experimental work.
- Changed files: `_portfolio/2025-07-15-deformation-reconstruction.html`, `iteration.md`.
- Commands: `make check`; `git diff --check -- _portfolio/2025-07-15-deformation-reconstruction.html`; local Jekyll preview; desktop and 390 px browser inspection.
- Outputs: Reorganized the page around the project overview, 4DGS training supervision, tactile preprocessing, cage-label extraction, graph-attention deformation, inverse-distance propagation, deployment, individual contributions, measured results, and the separate Ecoflex capacitive prototype.
- Validation: `make check` passed; the task-scoped diff check passed; the browser console reported zero errors and warnings; the page had no horizontal overflow at 1280 px or 390 px; the least-squares equation remained fully visible at 390 px.
- Risks / follow-ups: The website CV remains unchanged pending user confirmation of the differences found in the latest Word CV. Existing unrelated worktree changes, including the pre-existing gallery metadata on this project page, are intentionally excluded from this commit. Production remains unchanged until an explicit push.
- Commit: This entry is included in the soft-robot project-page commit.

### 2026-08-26 13:14 | Improve project-gallery readability and responsiveness
- Goal: Review all seven visible project galleries and preserve technical figures, diagrams, and portrait media without disruptive cropping while retaining an orderly photo layout.
- Changed files: `_includes/gallery`, `_sass/layout/_base.scss`, seven visible `_portfolio/` records, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: `make check`; `make serve`; task-scoped `git diff --check`; desktop and 390 px browser inspection of all seven project pages; Zero-Shot lightbox interaction check.
- Outputs: Added per-image full-width and contained-display options, applied full-width natural-ratio rendering to 21 technical figures, used contained rendering for 28 images, centered incomplete rows, added meaningful alt text to all 49 visible gallery images, and enabled lazy asynchronous image loading. A mobile equation-overflow guard was added after the Zero-Shot page review exposed a narrow-screen overflow.
- Validation: `make check` passed with all Gallery regressions; every project page rendered the expected image count with zero broken images and zero horizontal overflow at desktop and 390 px; Gallery items were centered; the Zero-Shot lightbox opened the selected high-resolution figure and restored body scrolling when closed.
- Risks / follow-ups: A concurrent, broader rewrite of the Zero-Shot project body appeared during this task and is intentionally preserved outside this Gallery commit; pre-existing unrelated dirty files also remain unstaged.
- Commit: This entry is included in the project-gallery refinement commit.

### 2026-08-26 15:36 | Synchronize website CV with the latest Word CV
- Goal: Apply the user-confirmed content and ordering changes from the latest Word CV while retaining accurate website-only details.
- Changed files: `_pages/cv.md`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; desktop and 390 px browser inspection.
- Outputs: Removed the CMU workshop, duplicate ISURE education entry, temporal-logic project, rankings, and deprecated skill wording; updated the Notre Dame, smart-home, wine, ball-robot, skills, and award text; moved Publications before Skills and placed the first-author wine paper before the IROS paper. Retained the website contact details, UCLA Math 156, RTX 3070 Ti, arXiv link, and no-retraining scope.
- Validation: `make check` and Ruby syntax checks passed; content regressions verify required and removed CV text plus section and publication order; browser inspection found no horizontal overflow at 1280 px or 390 px and no console errors or warnings.
- Risks / follow-ups: The ROBOCON award name follows the user-confirmed Word CV wording and can be revisited if the award certificate supplies a different official English title. Existing unrelated worktree changes remain unstaged. Production remains unchanged until an explicit push.
- Commit: This entry is included in the website CV synchronization commit.

### 2026-08-26 15:52 | Restore bullet structure in CV research projects
- Goal: Make every Research Experience entry use the same readable three-bullet structure instead of rendering several projects as uninterrupted paragraphs.
- Changed files: `_pages/cv.md`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; generated-CV bullet-count check; local desktop and 390 px browser inspection.
- Outputs: Split the Smart Home, wine-quality, and ball-robot descriptions into three bullets each. The concurrent Smart Home factual rewrite remains preserved in the worktree but outside this commit. Added a project-by-project regression requiring exactly three bullets for all four Research Experience entries.
- Validation: `make check` passed after the concurrent Smart Home assertions were synchronized; generated HTML reported bullet counts of `3, 3, 3, 3`; browser inspection found no horizontal overflow and no console errors or warnings at either tested width.
- Risks / follow-ups: Concurrent Smart Home edits in `_pages/cv.md` and `scripts/check_site_content.rb` belong to another task and are excluded from this commit. Production remains unchanged until an explicit push.
- Commit: This entry is included in the CV research-bullet structure commit.

### 2026-08-26 15:54 | Rewrite embedded smart-home terminal project page
- Goal: Reconcile the Smart Home project with the original presentation and user-confirmed facts, then reorganize the page so each technical figure appears beside the subsystem it explains.
- Changed files: `_portfolio/2024-09-10-smart-home-terminal.html`, `_pages/about.md`, `_pages/cv.md`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; task-scoped `git diff --check`; local Jekyll preview; desktop and 390 px browser inspection; gallery image-load and video-metadata checks.
- Outputs: Corrected the validation accuracy to 89.1% across seven classes; removed unsupported power, latency, packet-loss, production-readiness, four-layer PCB, firmware-stack, and placeholder-link claims; separated OneNET device control from iFLYTEK Spark dialogue; corrected hardware names; added the author's contribution; and distributed all eight images across architecture, recognition, cloud, and hardware sections. The vertical demo video is now centered with a bounded width and poster.
- Validation: `make check` passed with Smart Home regression coverage; all eight project images loaded with descriptive alt text; the page had no horizontal overflow at 1440 px or 390 px; the video reported valid 544 x 960 metadata with no media error and rendered at 360 px wide on desktop and 343 px on mobile. The task-scoped diff check passed; the repository-wide diff check still reports the pre-existing trailing blank line in the unrelated dirty file `format_images.py`.
- Risks / follow-ups: The 19 MB H.264/AAC demo remains intentionally uncompressed; a later media-specific task may reduce its mobile transfer size without changing the content. Concurrent CV bullet-formatting work remains separately owned and preserved.
- Commit: This entry is included in the embedded smart-home project-page commit.

### 2026-08-27 02:01 | Improve primary navigation affordances
- Goal: Reorder the primary navigation and make its clickable, current, hover, and keyboard-focus states easier to recognize.
- Changed files: `_data/navigation.yml`, `_includes/masthead.html`, `_sass/layout/_navigation.scss`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; generated-page navigation order and active-state assertions.
- Outputs: Reordered the navigation to Portfolio, Publications, and CV; added persistent active states and `aria-current` coverage for section indexes and collection details; enlarged link hit areas; strengthened hover and keyboard-focus feedback; and aligned the collapsed menu with light and dark themes.
- Validation: Jekyll built successfully and `Site content checks passed.`; generated pages expose the expected navigation order and identify the current Home, Portfolio, Publications, or CV section.
- Risks / follow-ups: Desktop, mobile, hover, focus, and dark-theme behavior will receive final browser verification together with the remaining approved interaction changes before deployment.
- Commit: This entry is included in the primary-navigation affordance commit.
