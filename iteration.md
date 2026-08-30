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

### 2026-08-27 02:03 | Connect Portfolio cards and project navigation
- Goal: Make Portfolio cover images open their project details and provide a clear, accessible route back to the Portfolio index from every project page.
- Changed files: `_includes/archive-single.html`, `_includes/footer/custom.html`, `_includes/post_pagination.html`, `_layouts/single.html`, `_sass/layout/_navigation.scss`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; generated-link, Back to Portfolio, Gallery, and pagination assertions.
- Outputs: Pointed all seven Portfolio cover images to their corresponding detail pages; limited lightbox behavior to project-detail Gallery images; added a 44 px contextual Back to Portfolio control; and replaced disabled `href="#"` pagination links with non-interactive disabled text.
- Validation: Jekyll built successfully and `Site content checks passed.`; all seven generated covers resolve to project routes, all seven detail pages include the contextual return link, Publication pages remain unaffected, and project Gallery lightboxes remain present.
- Risks / follow-ups: Mouse, keyboard, Gallery, desktop, and mobile interaction behavior will receive final browser verification before deployment.
- Commit: This entry is included in the Portfolio navigation commit.

### 2026-08-27 02:20 | Reshape homepage around research identity
- Goal: Replace the duplicate CV-style homepage with a concise research narrative, selected work, recent publications, and clear routes into the full Portfolio, Publications, and CV.
- Changed files: `_pages/about.md`, three featured `_portfolio/` records, `_sass/layout/_home.scss`, `assets/css/main.scss`, `_includes/masthead.html`, `_includes/footer/custom.html`, `_includes/post_pagination.html`, `_sass/layout/_navigation.scss`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; browser checks at 1440 x 1000, 768 x 900, and 390 x 844; card, Back to Portfolio, Gallery, theme, collapsed-menu, and active-navigation interaction checks.
- Outputs: Replaced the homepage chronology with About, Research Directions, three featured projects with explicit individual roles, two generated publication cards, and an Explore callout. Added natural homepage-only project summaries, responsive one/two/three-column layouts, fixed 4:3 image frames, theme-safe interaction colors, 44 px action targets, reduced-motion handling, named masthead controls, synchronized disclosure state, and section-aware `aria-current` values.
- Validation: Jekyll built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed. The three project media frames measured equally at 313 x 235 px on wide desktop, 348 x 261 px at 768 px, and 341 x 256 px on mobile. The 768 px layout used two columns with the third card centered; all tested widths had zero horizontal overflow; dark navigation hover contrast measured 5.77:1; the project-image, return, Gallery, theme, and collapsed-menu flows worked with zero browser warnings or errors.
- Risks / follow-ups: The existing Gallery lightbox still lacks full dialog focus management and remains a separate accessibility improvement. Repository-wide `git diff --check` continues to report the pre-existing trailing blank line in the unrelated dirty file `format_images.py`; that file and the other pre-existing dirty assets remain excluded.
- Commit: This entry is included in the homepage research-identity commit.

### 2026-08-27 02:26 | Tighten homepage mobile hierarchy and touch targets
- Goal: Remove the repeated visible name from the mobile first screen while preserving a semantic page heading, and ensure every Explore action meets the site's 44 px touch-target standard.
- Changed files: `_pages/about.md`, `_layouts/archive.html`, `_sass/layout/_home.scss`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local 390 x 844 browser inspection; semantic-heading, touch-target, fixed-overlay, and horizontal-overflow measurements.
- Outputs: Added a page-level option that visually hides the homepage title with the existing screen-reader-only utility; kept the `Zilang Chen` H1 in the document outline; and gave all three Explore buttons a 44 px minimum height. The initial CSS regression assertion was updated after it proved too dependent on Sass's grouped-selector output.
- Validation: Jekyll built successfully and `Site content checks passed.`; the homepage H1 measured 1 x 1 px in the screen-reader-only position, all Explore buttons measured 44 px high, no visible overlay covered the page, and the 390 px viewport had no horizontal overflow.
- Risks / follow-ups: The hidden-title option is opt-in and currently used only by the homepage, so other archive layouts retain their visible H1. Existing unrelated dirty files remain unstaged and unchanged.
- Commit: This entry is included in the mobile homepage-polish commit.

### 2026-08-27 02:36 | Rewrite remote-controlled ball-collecting robot project page
- Goal: Reconcile the Ball Robot page with the original 34-page course report, competition video, and user-confirmed responsibilities, then reorganize the images beside the engineering content they document.
- Changed files: `_portfolio/2024-02-20-ball-picking-robot.html`, `_pages/cv.md`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: original `.doc` conversion and 34-page render review; `ffprobe` and sampled competition-video frames; `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; desktop and 390 px browser inspection.
- Outputs: Renamed the project to `Remote-Controlled Multifunctional Ball-Collecting Robot`; retained the Feb 2024 – Jul 2024 period; documented the team's second-place result and the author's confirmed role; replaced unsupported performance numbers with evidence-bounded results; corrected the C50C/STM32, motor-control, collection, and release descriptions; and distributed all nine images across competition, mechanical, control, and prototype sections. The video now uses metadata preloading and a competition-frame poster.
- Validation: Jekyll built successfully and `Site content checks passed.`; all nine Gallery images loaded with descriptive alt text after normal lazy-loading scroll behavior; the page had no horizontal overflow at 1280 px or 390 px; the full-width control flow rendered legibly; the 1280 × 720, 89.24-second video reported valid metadata with no media error; and browser console checks returned no warnings or errors.
- Risks / follow-ups: The 17,005,289-byte H.264/AAC competition video remains intentionally uncompressed. Repository-wide `git diff --check` still reports the pre-existing unrelated `format_images.py` change; that file, existing `.DS_Store` changes, and the untracked Portfolio PDF remain excluded from this task.
- Commit: This entry is included in the Ball Robot project-page rewrite commit.

### 2026-08-27 07:30 | Rewrite ROBOCON 2023 project page
- Goal: Replace the generic ROBOCON description with the official competition task, the verified national result, and the author's confirmed Rabbit Robot fabrication role, while integrating all project images with the engineering narrative.
- Changed files: `_portfolio/2023-08-15-angkor-bloom.html`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: official rulebook, award-list, and national-finals source review; eight-image contact-sheet inspection; `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview and browser inspection.
- Outputs: Renamed the page to `ROBOCON 2023 “Casting Flowers over Angkor Wat”`; documented the Rabbit Robot and Elephant Robot challenge, July 5–8 national finals, and National Third Prize; limited the author's contribution to confirmed laser cutting, 3D printing, assembly, ring pickup mechanism fabrication, and a small embedded contribution; removed the placeholder video link and unsupported control, strategy, and robot-operation claims; corrected all eight image descriptions and distributed them across three technical galleries.
- Validation: Jekyll built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed; all eight Gallery images loaded at their natural dimensions with contained rendering, descriptive alt text, and no broken files; the local page had no horizontal overflow at 1280 px, used a correct H1/H2/H3 hierarchy, exposed no empty hash links, and produced no browser-console errors or warnings. The unchanged shared Gallery component places items at full width below the small breakpoint and has existing 390 px regression coverage.
- Risks / follow-ups: The exact embedded submodule is not documented, so the public wording remains deliberately limited. The project record does not assign each photographed mechanism to the Rabbit or Elephant Robot, so image descriptions identify visible configurations without inventing ownership. Existing `.DS_Store`, `format_images.py`, and untracked Portfolio PDF changes remain excluded.
- Commit: This entry is included in the ROBOCON project-page rewrite commit.

### 2026-08-27 11:25 | Simplify Publications metadata
- Goal: Reduce repetition on the Publications listing while keeping complete citation data available on paper detail pages and in the website CV.
- Changed files: `_publications/2025-06-15-wine-quality-ensemble.md`, `_includes/archive-single.html`, `_includes/publication-links.html`, `_layouts/single.html`, `_pages/about.md`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; `make check`; local Jekyll preview; desktop and 390 x 844 browser inspection; detail-page and CV citation-preservation checks.
- Outputs: Replaced the nonstandard `ACM IPMLP 2025` label with `IPMLP 2025 · Proceedings published by ACM`; hid full recommended citations only on the Publications listing; retained the paper and PDF links, detail-page citations, and CV citation data; and synchronized the homepage's generated Wine publication metadata.
- Validation: Ruby syntax, Jekyll build, task-scoped diff checks, and the complete site-content regression passed. The Publications listing contained two distinct articles, no recommended citation text, and no horizontal overflow at 1280 px or 390 px. Both detail pages retained their recommended citations, and the website CV retained the full Wine proceedings citation.
- Risks / follow-ups: July 12, 2025 remains the conference/issued date rather than ACM's later online-publication date. Concurrent water-surface-robot edits and the pre-existing dirty assets remain unstaged and excluded from this task.
- Commit: This entry is included in the publication-metadata simplification commit.

### 2026-08-27 11:30 | Rewrite biomimetic water-surface robot project page
- Goal: Reconcile the water-surface robot page with the original 11-page project report and user-confirmed responsibilities, separate implemented functions from explored ideas, and integrate the project media with the engineering narrative.
- Changed files: `_portfolio/2022-09-15-water-surface-robot.html`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: original `.docx` render review and media inspection; `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; 1280 px in-app browser inspection; isolated 390 x 844 Playwright inspection.
- Outputs: Clarified that foam floats, rather than surface tension, supplied buoyancy; documented the final four-support-leg and two-active-leg Chebyshev-linkage design; replaced unsupported PID, zero-radius-turn, target-stop, and performance claims with the Arduino/PWM/ultrasonic scope and recorded pool results; added the author's confirmed mechanical, control, fabrication, and testing contributions; removed the placeholder STL link; and distributed all six images across mechanical, control, and testing sections. The vertical demo now uses a matching 9:16 poster and a bounded responsive layout.
- Validation: Jekyll built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed. All six Gallery images loaded at their natural dimensions with descriptive alt text and contained rendering; heading hierarchy is H1/H2/H3; there are no empty hash links or horizontal overflow at 1280 px or 390 px. The video renders at 360 x 640 px on desktop and 358 x 636 px on mobile with a 9:16 aspect ratio, metadata preloading, and inline playback enabled.
- Risks / follow-ups: The 12,723,454-byte H.264/AAC demo remains intentionally uncompressed. Concurrent Publication changes in `scripts/check_site_content.rb` and `iteration.md`, plus the pre-existing `.DS_Store`, `format_images.py`, and untracked Portfolio PDF changes, remain outside this task and must be excluded from this commit.
- Commit: This entry is included in the water-surface robot project-page rewrite commit.

### 2026-08-27 12:33 | Rewrite wine-quality research project page
- Goal: Reconcile the Wine Quality Portfolio page with the complete nine-page paper and the author's confirmed independent role, then place each technical figure beside the result it documents.
- Changed files: `_portfolio/2024-06-15-wine-quality-analysis.html`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: complete paper and seven-figure review; `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; 1280 px in-app browser inspection; isolated 390 x 844 Playwright inspection and Gallery lightbox test.
- Outputs: Replaced the abbreviated project title with the official paper title; documented the UCLA course-project origin and subsequent sole-authored expansion; added the author's independent contribution; corrected the red/white label ranges, CatBoost figure descriptions, exact optimization times, publication wording, and model-specific feature-selection scope; removed unsupported state-of-the-art, first-of-kind, real-time-deployment, and public-script-release claims; and distributed all seven figures across pipeline, feature-selection, results, and error-analysis sections.
- Validation: Jekyll built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed. All seven Gallery images loaded at their natural dimensions with descriptive alt text; the page uses an H1/H2/H3 hierarchy, has no empty hash links or horizontal overflow at 1280 px or 390 px, and the complex feature-selection figure opens at its 1057 x 823 source resolution in the lightbox. The final same-origin browser session reported no console errors or warnings.
- Risks / follow-ups: The website intentionally provides no public code link; the page instead scopes reproducibility to the methods, search spaces, software versions, and seeds documented in the paper. Existing `.DS_Store`, `format_images.py`, and untracked Portfolio PDF changes remain excluded from this task.
- Commit: This entry is included in the wine-quality project-page rewrite commit.

### 2026-08-27 16:01 | Refocus homepage research interests and selected work
- Goal: Present VLA and robot algorithms as the author's intended research direction without overstating prior experience, and replace the third Selected Work card with the remote-controlled ball-collecting robot.
- Changed files: `_pages/about.md`, `_portfolio/2024-02-20-ball-picking-robot.html`, `_portfolio/2024-09-10-smart-home-terminal.html`, `scripts/check_site_content.rb`, `iteration.md`.
- Commands: `make check`; `ruby -c scripts/check_site_content.rb`; task-scoped `git diff --check`; local Jekyll preview; in-app browser inspection at 1280 px, 768 px, and 390 px.
- Outputs: Reframed the homepage around Vision-Language-Action Models, Robot Learning, Planning, and Control, and Embodied Systems and Evaluation; connected those future interests to the existing tactile sensing, 3D reconstruction, embedded control, and prototyping background; replaced the Smart Home featured card with the Ball Robot; and added a concise, evidence-bounded summary and individual role for the new card.
- Validation: Jekyll built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed. At 1280 px, all three interest cards and all three project cards were equal in height. A browser-driven wording refinement reduced the standalone Ball Robot card at 768 px from 784 px to 730 px, matching the first-row cards. The 390 px layout had no horizontal overflow, the 4:3 CAD cover remained fully visible, and the browser reported no errors or warnings.
- Risks / follow-ups: The new VLA and robot-algorithm language is explicitly framed as a current interest and intended study direction, not as completed research experience. The Smart Home project remains available in the full Portfolio. Existing `.DS_Store`, `format_images.py`, and untracked Portfolio PDF changes remain excluded from this task.
- Commit: This entry is included in the homepage research-interest and selected-work commit.

### 2026-08-28 07:04 | Restrict the public website and repository surface
- Goal: Apply the approved phase-B boundary by withdrawing raw source materials, duplicate and sample downloads, template routes, the example Feed, and inaccurate policy content without rewriting Git history or deleting the user's local source files.
- Changed files: `Gemfile`, `.gitignore`, `_config.yml`, `_includes/head.html`, `_includes/footer/custom.html`, `_pages/404.md`, fourteen disabled template pages under `_pages/`, `scripts/check_site_content.rb`, `iteration.md`, the tracked `Materials/` index entries, non-allowlisted files under `files/`, and tracked `.DS_Store` entries.
- Commands: SHA-256 parity checks for the retained local Temporal Logic and soft-robot PDFs; `git rm --cached -r -- Materials`; exact PDF and `.DS_Store` index cleanup; `ruby -c scripts/check_site_content.rb`; `make check`; task-scoped `git diff --check`; 1280 px and 390 px in-app browser review; three parallel read-only scope reviews.
- Outputs: Reduced the built site from the dirty-worktree baseline of about 612 MB to 133 MB and 110 files; retained only the approved Wine Quality PDF under `/files/`; limited XML Sitemap output to fourteen approved paths; disabled example Blog, Talks, Teaching, Feed, Terms, HTML Sitemap, CV JSON, archive, Markdown-guide, and talkmap routes; excluded hidden Temporal Logic media; and added four recovery links to the 404 page. `Materials/` and `.DS_Store` files remain on the local filesystem but are no longer tracked in the current branch.
- Validation: Jekyll 3.9.5 built successfully and `Site content checks passed.` under both production and local-preview URL configurations; the checker enforces the route, file, sitemap, Git-index, and 160 MiB size allowlists. Home, Portfolio, Publications, CV, seven public project pages, two publication pages, and the Wine PDF remained present. Desktop and mobile checks found no horizontal overflow, no broken content images, and no Feed or HTML Sitemap links. An initial exact `.DS_Store` cleanup command included a path already removed with `Materials/` and failed closed; rerunning it with the remaining tracked paths succeeded without deleting local files.
- Risks / follow-ups: Phase B removes files only from the current branch and future GitHub Pages builds. Historical commits and external caches still contain old copies until a separately approved phase-C history rewrite. The unrelated `format_images.py` modification remains unstaged and unchanged.
- Commit: `f0914f3`; this entry is included in the public-artifact cleanup commit.

### 2026-08-30 11:09 | Add undergraduate KV-cache quantization thesis
- Goal: Add the completed undergraduate KV-cache quantization thesis to the public Portfolio and place it first in the CV Research Experience section using facts reconciled against the final thesis.
- Changed files: `_portfolio/2026-05-15-kv-cache-quantization.html`, `_pages/cv.md`, three figures under `images/portfolio/kv-cache-quantization/`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: final-thesis PDF extraction and visual review; `ruby -c scripts/check_site_content.rb`; `make check`; task-scoped and staged `git diff --check`; local Jekyll preview; 1280 px and 390 x 844 in-app browser inspection.
- Outputs: Added a sole-authored thesis page covering behavior-guided INT8/INT4 calibration, K/V role-aware quantization, sensitivity-driven allocation, AutoK, system implementation, measured results, individual contribution, limitations, and future directions; added the Jan 2026 - May 2026 CV entry under Prof. Ziqian Zeng; sorted the May 2026 project first in Portfolio; and linked the public repository without displaying a submission target.
- Validation: Jekyll 3.9.5 built successfully and `Site content checks passed.`; Ruby syntax passed; the local Portfolio, project detail, and CV rendered without horizontal overflow or broken content images at desktop and mobile widths; the CV and Portfolio ordering, three descriptive image alternatives, required thesis claims, prohibited conference claims, sitemap entry, navigation state, and pagination are regression-tested.
- Risks / follow-ups: The official LongBench evidence remains explicitly scoped to one Qwen model, three tasks, at most 50 samples per task, and one seed; allocation comparisons use similar budget bands rather than strict matched budgets; runtime evidence is tied to the reported NVIDIA H20 and software configuration. The pre-existing unrelated `format_images.py` modification remains unstaged and unchanged.
- Commit: This entry is included in the KV-cache thesis project commit.

### 2026-08-30 14:56 | Add English KV-cache method figures
- Goal: Improve the KV-cache thesis page with two paper-derived English figures that explain the overall calibration framework and the asymmetric INT4-RoleAlign quantization axes.
- Changed files: `_portfolio/2026-05-15-kv-cache-quantization.html`, `images/portfolio/kv-cache-quantization/behavior-guided-framework.png`, `images/portfolio/kv-cache-quantization/int4-rolealign-axes.png`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: SHA-256 source/copy parity check; `make check`; task-scoped `git diff --check`; local Jekyll preview; 1280 x 900 and 390 x 844 in-app browser inspection; mobile Lightbox open/close test.
- Outputs: Added a full-width overall framework after Behavior-Guided Calibration and a full-width INT4-RoleAlign axes diagram before the existing K/V diagnostic results. Both figures use descriptive alternative text, concise captions, contained rendering, lazy loading, and the existing project-gallery Lightbox.
- Validation: Jekyll 3.9.5 built successfully and `Site content checks passed.`; both copied PNG files match their approved preview sources byte-for-byte. On desktop the figures render at 760 px wide; at 390 px they render at 343 px wide with no horizontal overflow. The RoleAlign Lightbox opened the 1492 x 786 source, hid page scrolling while active, and restored scrolling on close. The page retained its H1/H2/H3 hierarchy and five working Gallery links.
- Risks / follow-ups: Dense labels are intentionally supported by click-to-enlarge behavior on narrow screens. The AutoK layer-protection figure remains outside the page to avoid excessive method density. The pre-existing unrelated `format_images.py` modification remains unstaged and unchanged.
- Commit: This entry is included in the English KV-cache method-figure commit.

### 2026-08-30 15:41 | Add Google Scholar identity links
- Goal: Add the confirmed public Google Scholar profile to the website and strengthen the identity signals that help search engines associate the site, Scholar, and GitHub with the same person.
- Changed files: `_config.yml`, `_includes/author-profile.html`, `_includes/footer/custom.html`, `_sass/layout/_sidebar.scss`, `scripts/check_site_content.rb`, and `iteration.md`.
- Commands: public Google Scholar profile review; Google result and indexing diagnostics; robots, sitemap, canonical, and response-header inspection; `ruby -c scripts/check_site_content.rb`; `make check`; task-scoped `git diff --check`; local Jekyll preview; 1280 x 900 and 390 x 844 in-app browser inspection.
- Outputs: Added the stable Scholar profile URL to the author sidebar on all public pages; added Scholar and GitHub to the Person JSON-LD `sameAs` array; and repaired the mobile `Follow` menu with explicit ARIA state, reliable open/close behavior, outside-click dismissal, and Escape-key support.
- Validation: Jekyll 3.9.5 built successfully and `Site content checks passed.`; Ruby syntax and task-scoped diff checks passed. On desktop, Google Scholar is visible in the author sidebar with the confirmed URL. At 390 px, the `Follow` button changes from `aria-expanded=false` to `true`, reveals Email, Google Scholar, and GitHub, and closes on the second click. Both layouts were visually inspected after the final build, and the generated homepage emits a non-null Person `sameAs` array.
- Risks / follow-ups: Search visibility is not immediate or guaranteed. Google currently returns no indexed results for `site:zilangchen.github.io`, and searches for `Zilang Chen` are affected by correction to `Ziliang Chen` and same-name ambiguity. Google Search Console verification, sitemap submission, URL inspection, and updating the public GitHub profile remain recommended external follow-ups. The pre-existing unrelated `format_images.py` modification remains unstaged and unchanged.
- Commit: This entry is included in the Google Scholar identity-link commit.
