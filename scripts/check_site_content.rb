#!/usr/bin/env ruby
# frozen_string_literal: true

require "cgi"
require "date"
require "open3"
require "tempfile"

ROOT = File.expand_path("..", __dir__)

def read_built(relative_path)
  path = File.join(ROOT, "_site", relative_path)
  abort("Missing built page: #{path}") unless File.file?(path)

  File.read(path, encoding: "UTF-8")
end

def assert(condition, message)
  abort("CHECK FAILED: #{message}") unless condition
end

home = read_built("index.html")
portfolio = read_built("portfolio/index.html")
cv = read_built("cv/index.html")
publications = read_built("publications/index.html")
deformation_publication = read_built("publication/2026-05-31-deformation-reconstruction.html")
wine_publication = read_built("publication/2025-06-15-wine-quality-ensemble.html")
deformation_portfolio = read_built("portfolio/deformation-reconstruction.html")
exo_portfolio = read_built("portfolio/climbing-hand-exo.html")
smart_home_portfolio = read_built("portfolio/smart-home-terminal.html")
wine_portfolio = read_built("portfolio/wine-quality-analysis.html")
ball_robot_portfolio = read_built("portfolio/ball-picking-robot.html")
angkor_portfolio = read_built("portfolio/angkor-bloom.html")
water_robot_portfolio = read_built("portfolio/water-surface-robot.html")

profile_pages = [home, cv, publications]
assert(profile_pages.all? { |html| html.include?("University of Pennsylvania") },
       "Penn affiliation is missing from a profile sidebar")

navigation_order = ['/portfolio/">Portfolio</a>', '/publications/">Publications</a>', '/cv/">CV</a>']
navigation_positions = navigation_order.map { |link| home.index(link) }
assert(navigation_positions.all?, "one or more primary navigation links are missing")
assert(navigation_positions == navigation_positions.sort,
       "primary navigation is not ordered as Portfolio, Publications, CV")

active_navigation = {
  home => /masthead__menu-item--lg persist is-active.*?aria-current="page".*?>Zilang Chen<\/a>/m,
  portfolio => /masthead__menu-item is-active.*?href="[^"]*\/portfolio\/" aria-current="page">Portfolio<\/a>/m,
  deformation_portfolio => /masthead__menu-item is-active.*?href="[^"]*\/portfolio\/" aria-current="location">Portfolio<\/a>/m,
  publications => /masthead__menu-item is-active.*?href="[^"]*\/publications\/" aria-current="page">Publications<\/a>/m,
  deformation_publication => /masthead__menu-item is-active.*?href="[^"]*\/publications\/" aria-current="location">Publications<\/a>/m,
  cv => /masthead__menu-item is-active.*?href="[^"]*\/cv\/" aria-current="page">CV<\/a>/m
}
active_navigation.each do |html, pattern|
  assert(html.match?(pattern), "current primary navigation item is not marked active")
end
assert(home.include?('<h1 class="page__title sr-only">Zilang Chen</h1>'),
       "homepage H1 is not preserved semantically while hidden from the repeated visual header")
assert(home.include?('aria-label="Toggle navigation menu"'),
       "masthead menu button is missing an accessible name")
assert(home.include?('aria-controls="site-nav-hidden-links" aria-expanded="false"'),
       "masthead menu button is missing disclosure state attributes")
assert(home.include?('role="button" tabindex="0" aria-label="Toggle color theme"'),
       "theme control is not keyboard focusable or named")

home_required = [
  "About",
  "Research Directions",
  "Embodied Perception",
  "Simulation and Transfer",
  "Robot Hardware and Embedded Systems",
  "Selected Work",
  "Recent Publications",
  "Explore",
  "experimental design, sensing, data processing, modeling, and physical testing",
  "transferring skills safely from simulation to real robots",
  "A flexible piezoresistive array drives a 3D Gaussian model",
  "The glove monitors grip pressure",
  "The terminal recognizes seven spoken commands locally",
  "Accepted to <em>IEEE/RSJ IROS 2026</em>.",
  "Published in <em>ACM IPMLP 2025</em>."
]
home_required.each do |text|
  assert(home.include?(text), "homepage identity or research section is missing: #{text}")
end

home_forbidden = [
  '<h2 id="contact">',
  '<h2 id="education">',
  '<h2 id="research-experience">',
  '<h2 id="project-experience">',
  '<h2 id="honors--awards">',
  "Real-Time Robotic-Arm Motion Planning from Temporal Logic",
  "Top 10%",
  "Top 20%",
  "Top 30%",
  "+1 (267) 521-3967",
  "Proceedings of the 2nd International Conference on Image Processing, Machine Learning, and Pattern Recognition"
]
home_forbidden.each do |text|
  assert(!home.include?(text), "CV-style detail remains on the redesigned homepage: #{text}")
end

home_project_titles = [
  "Zero-Shot Deformation Reconstruction for Soft Robots",
  "Climbing-Assisted Hand Exoskeleton",
  "Embedded Smart Home Terminal Based on Lightweight Machine Learning"
]
home_project_positions = home_project_titles.map { |title| home.index(title) }
assert(home_project_positions.all?, "one or more featured homepage projects are missing")
assert(home_project_positions == home_project_positions.sort,
       "featured homepage projects are not in the expected order")
assert(home.scan('class="home-project-card"').length == 3,
       "homepage does not contain exactly 3 featured project cards")
assert(home.scan("<strong>My role.</strong>").length == 3,
       "homepage project cards do not consistently separate individual roles")

home_project_paths = [
  "/portfolio/deformation-reconstruction",
  "/portfolio/climbing-hand-exo",
  "/portfolio/smart-home-terminal"
]
home_project_cards = home.scan(/<article class="home-project-card">(.*?)<\/article>/m).map(&:first)
home_project_paths.each_with_index do |path, index|
  card = home_project_cards[index]
  assert(card.scan(%{href="#{path}"}).length == 2,
         "featured homepage media and title do not share the detail link: #{path}")
  image_tag = card[/<img\b[^>]*>/]
  assert(image_tag&.include?('loading="lazy"') && image_tag.include?('decoding="async"'),
         "featured homepage image is missing lazy or async loading attributes: #{path}")
  image_src = image_tag&.match(/src="([^"]+)"/)&.captures&.first
  assert(image_src && File.file?(File.join(ROOT, image_src.sub(%r{\A/}, ""))),
         "featured homepage image source is missing on disk: #{path}")
  assert(card.match?(%r{<strong>My role\.</strong>\s+\S}),
         "featured homepage role is empty: #{path}")
end

assert(home.scan('class="home-output-card"').length == 2,
       "homepage does not contain exactly 2 recent research outputs")
home_output_positions = [
  "Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling",
  "Wine Quality Prediction with Ensemble Trees"
].map { |title| home.index(title) }
assert(home_output_positions.all?, "one or more homepage research outputs are missing")
assert(home_output_positions == home_output_positions.sort,
       "homepage research outputs are not ordered newest first")
assert(home.include?('href="/portfolio/">View all projects'),
       "homepage is missing the complete Portfolio entry point")
assert(home.include?('href="/publications/">View all publications'),
       "homepage is missing the complete Publications entry point")
assert(home.include?('href="/cv/">CV</a>'),
       "homepage Explore section is missing the CV entry point")

cv_required = [
  "Philadelphia, PA, USA",
  "(Personal)",
  "Visiting Student, UCLA Summer Sessions",
  "Math 156 Machine Learning",
  "Ecoflex",
  "R/R0 normalization",
  "Co-designed and executed the acquisition protocol",
  "separate inverse distance weighting step",
  "RTX 3070 Ti",
  "robot-specific retraining",
  "arXiv:2603.19543",
  "OneNET",
  "iFLYTEK Spark LLM",
  "pp. 162–170",
  "soft-robot fabrication",
  "Embedded Systems &amp; Electronics",
  "ROBOCON Third Prize in the National College Student Robotics Competition"
]
cv_required.each do |text|
  assert(cv.include?(text), "updated or retained CV detail is missing: #{text}")
end

cv_forbidden = [
  "Research Workshop: Computer Vision and Robot Sensors",
  "Real-Time Robotic Arm Motion Control Algorithm Based on Temporal Logic",
  "International Summer Undergraduate Research Experience (ISURE)",
  "Top 10%",
  "Top 20%",
  "Top 30%",
  "OneNet",
  "Xinghuo LLM",
  "TinyML",
  "on-chip inference",
  "extensive mechanical assembly",
  "soft robot manufacture",
  "Certificate of Achievement",
  "Angkor Bloom"
]
cv_forbidden.each do |text|
  assert(!cv.include?(text), "removed or superseded CV detail remains: #{text}")
end

cv_research_section = cv[/<h2 id="research-experience">.*?(?=<h2 id="publications">)/m]
assert(cv_research_section, "CV Research Experience section could not be extracted")
cv_research_projects = [
  "Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling",
  "Embedded Smart Home Terminal Based on Lightweight Machine Learning",
  "A Unified, Leak-Free Comparative Study of Wine Quality",
  "Remote-Controlled Multifunctional Ball-Collecting Robot"
]
cv_research_positions = cv_research_projects.map { |title| cv_research_section.index(title) }
assert(cv_research_positions.all?, "one or more CV research projects are missing")
assert(cv_research_positions == cv_research_positions.sort,
       "CV research projects are not in the expected order")
cv_research_positions.each_with_index do |start_position, index|
  end_position = cv_research_positions[index + 1] || cv_research_section.length
  project_html = cv_research_section[start_position...end_position]
  bullet_count = project_html.scan(/<li>/).length
  assert(bullet_count == 3,
         "CV research project does not contain exactly 3 bullet points: #{cv_research_projects[index]}")
end

cv_publication_heading = cv.index('<h2 id="publications">')
cv_skills_heading = cv.index('<h2 id="skills">')
assert(cv_publication_heading && cv_skills_heading,
       "CV Publications or Skills heading is missing")
assert(cv_publication_heading < cv_skills_heading,
       "CV Publications section is not placed before Skills")

cv_publication_section = cv[/<h2 id="publications">.*?(?=<h2 id="skills">)/m]
assert(cv_publication_section, "CV Publications section could not be extracted")
wine_cv_position = cv_publication_section.index("Wine Quality Prediction with Ensemble Trees")
deformation_cv_position = cv_publication_section.index("Zero-Shot Deformation Reconstruction for Soft Robots")
assert(wine_cv_position && deformation_cv_position,
       "one or more CV publication entries are missing")
assert(wine_cv_position < deformation_cv_position,
       "first-author wine paper is not listed before the IROS paper in the CV")

forbidden = [
  "zilangchen2026@163.com",
  "+86 136-6002-1792",
  "ICRA 2026",
  "Under Review",
  "Google Scholar"
]
all_checked = [home, portfolio, cv, publications].join("\n")
forbidden.each do |text|
  assert(!all_checked.include?(text), "stale public text remains: #{text}")
end
assert(all_checked.include?("IEEE/RSJ IROS 2026"), "accepted IROS venue is missing")
assert(publications.include?("Accepted to <i>IEEE/RSJ IROS 2026</i>"),
       "publication listing does not use accepted-status wording")
assert(publications.include?("June 16, 2026"), "IROS acceptance date is missing")

arxiv_title = "Zero-Shot Deformation Reconstruction for Soft Robots Using a Flexible Sensor Array and Cage-Based 3D Gaussian Modeling"
publication_pages = [home, cv, publications, deformation_publication, deformation_portfolio]
assert(publication_pages.all? { |html| html.include?(arxiv_title) || html.include?("Zero-Shot Deformation Reconstruction for Soft Robots") },
       "the current public deformation-reconstruction title is not synchronized")
assert(deformation_publication.include?('href="https://arxiv.org/abs/2603.19543"'),
       "arXiv abstract link is missing")
assert(deformation_publication.include?('href="https://arxiv.org/pdf/2603.19543"'),
       "arXiv PDF link is missing")
assert(deformation_publication.include?("Accepted to <i>IEEE/RSJ IROS 2026</i>"),
       "deformation detail page does not show accepted status")
assert(!deformation_publication.include?("Published in <i>IEEE/RSJ IROS 2026</i>"),
       "accepted IROS paper is incorrectly rendered as published")
assert(!deformation_publication.include?('itemprop="datePublished"'),
       "accepted paper incorrectly exposes a publication date")
assert(!deformation_publication.include?('property="article:published_time"'),
       "accepted paper incorrectly exposes Open Graph publication time")

deformation_required = ["0.67 IoU", "0.65 SSIM", "3.48 mm Chamfer", "4.9°", "5 FPS", "static geometric proxy"]
deformation_required.each do |text|
  assert(deformation_publication.include?(text), "current arXiv result or scope is missing: #{text}")
end

stale_publication_claims = [
  "Real-Time Camera-Free Deformation Reconstruction via Flexible Sensor Array and Cage-Based Deformation Model",
  "&lt;5% mean 3D displacement error",
  "Multi-Objective Tuning",
  "mutual information ranking",
  "95% CI",
  "significance testing",
  "90%+ of the predictive signal",
  "128GB DDR5",
  "All code, configurations, and detailed experimental logs",
  "Dimensionality reduction to these five variables"
]
corrected_pages = [home, cv, publications, deformation_publication, wine_publication, deformation_portfolio, wine_portfolio].join("\n")
stale_publication_claims.each do |text|
  assert(!corrected_pages.include?(text), "stale or unsupported publication claim remains: #{text}")
end

assert(wine_publication.include?("Weighted F1 is the sole hyperparameter-optimization objective"),
       "wine optimization objective is not corrected")
assert(wine_publication.include?("512 GB RAM"), "wine compute specification is not corrected")
assert(wine_publication.include?("162–170"), "wine proceedings page range is missing")
assert(wine_publication.include?("View ACM Record"), "ACM DOI link label is misleading")
assert(wine_publication.include?("Download PDF"), "local wine PDF link is missing")
assert(wine_portfolio.include?("each model-and-dataset combination"),
       "wine project page does not describe feature selection precisely")
assert(wine_portfolio.include?('href="https://doi.org/10.1145/3759928.3759955"'),
       "wine project page DOI is not clickable")

publication_title_positions = [arxiv_title, "Wine Quality Prediction with Ensemble Trees"].map do |title|
  publications.index(title)
end
assert(publication_title_positions.all?, "one or more publication titles are missing")
assert(publication_title_positions == publication_title_positions.sort,
       "publication entries are not ordered newest first")
assert(!publications.match?(/<p class="archive__item-excerpt"[^>]*>\s*<\/p>/),
       "publication listing contains an empty excerpt paragraph")

portfolio_titles = [
  "Zero-Shot Deformation Reconstruction for Soft Robots",
  "Climbing-Assisted Hand Exoskeleton",
  "Embedded Smart Home Terminal Based on Lightweight Machine Learning",
  "Analysis of Wine Quality Based on Multiple Machine Learning Methods",
  "Remote-Controlled Multifunctional Ball-Collecting Robot",
  "ROBOCON 2023 “Casting Flowers over Angkor Wat”",
  "Biomimetic Water Surface Robot with Automatic Obstacle Avoidance"
]
portfolio_title_positions = portfolio_titles.map { |title| portfolio.index(title) }
assert(portfolio_title_positions.all?, "one or more visible portfolio projects are missing")
assert(portfolio_title_positions == portfolio_title_positions.sort,
       "portfolio entries are not ordered by latest project end date")
assert(!portfolio.include?("Real-Time Robotic Arm Motion Control Algorithm Based on Temporal Logic"),
       "hidden temporal-logic project remains in the portfolio listing")
temporal_output = File.join(ROOT, "_site", "portfolio", "temporal-logic-motion-planning.html")
assert(!File.exist?(temporal_output), "hidden temporal-logic detail page was generated")

portfolio_periods = [
  "Jul 2025 – Sep 2025",
  "Feb 2025 – Jun 2025",
  "Sep 2024 – Dec 2024",
  "Jun 2024 – Aug 2024",
  "Feb 2024 – Jul 2024",
  "Dec 2022 – Jul 2023",
  "Sep 2022 – Jan 2023"
]
assert(portfolio.scan("Project period:").length == 7,
       "portfolio cards do not consistently label project periods")
portfolio_periods.each do |period|
  assert(portfolio.include?(period), "portfolio period is missing: #{period}")
end
assert(!portfolio.include?("Project date:"), "portfolio listing still exposes exact sort dates")
assert(deformation_portfolio.include?("Project period:"),
       "deformation project detail does not label its period clearly")
assert(!deformation_portfolio.include?('itemprop="datePublished"'),
       "portfolio detail incorrectly exposes its hidden sort date as a publication date")
assert(!angkor_portfolio.include?("Top 30%"), "unsupported RoboCon ranking remains")
assert(angkor_portfolio.include?("July 5–8, 2023"),
       "verified RoboCon national-finals dates are missing")
angkor_required = [
  "National Third Prize",
  "Rabbit Robot",
  "laser cutting and 3D printing",
  "fabrication and assembly of the ring pickup mechanism",
  "limited contribution to the embedded implementation",
  "official award list"
]
angkor_required.each do |text|
  assert(angkor_portfolio.include?(text), "RoboCon detail is missing confirmed content: #{text}")
end
angkor_forbidden = [
  "Control system development and implementation",
  "Strategic planning and competition execution",
  "Mechanical design and fabrication of robot components",
  'href="#"'
]
angkor_forbidden.each do |text|
  assert(!angkor_portfolio.include?(text), "unsupported RoboCon content remains: #{text}")
end
assert(deformation_portfolio.include?('href="https://arxiv.org/abs/2603.19543"'),
       "deformation project detail is missing its current public manuscript link")

portfolio_teaser_links = portfolio.scan(
  /<a class="archive__item-teaser-link" href="([^"]+)" aria-label="View project: ([^"]+)">/
)
assert(portfolio_teaser_links.length == 7,
       "expected 7 Portfolio teaser links to project details, found #{portfolio_teaser_links.length}")
portfolio_teaser_links.each do |href, label|
  assert(href.include?("/portfolio/") && !href.match?(/\.(?:jpe?g|png|gif|webp)\z/i),
         "Portfolio teaser does not link to a project detail: #{href}")
  assert(!label.strip.empty?, "Portfolio teaser link has an empty accessible label")
end
assert(!portfolio.include?('data-lightbox="portfolio-main"'),
       "Portfolio listing still opens cover images in a lightbox")

portfolio_detail_pages = {
  "deformation reconstruction" => deformation_portfolio,
  "hand exoskeleton" => exo_portfolio,
  "smart-home terminal" => smart_home_portfolio,
  "wine-quality analysis" => wine_portfolio,
  "ball-picking robot" => ball_robot_portfolio,
  "RoboCon Angkor Bloom" => angkor_portfolio,
  "water-surface robot" => water_robot_portfolio
}
portfolio_detail_pages.each do |name, html|
  assert(html.match?(%r{<nav class="page__back-nav" aria-label="Portfolio navigation">.*?<a class="page__back-link" href="[^"]*/portfolio/">.*?Back to Portfolio}m),
         "#{name} detail is missing the Back to Portfolio link")
  assert(!html.include?('href="#" class="pagination--pager disabled"'),
         "#{name} detail still exposes a disabled pagination link as href=#")
  assert(html.include?('<nav class="pagination" aria-label="Project pagination">') ||
         !html.include?('<nav class="pagination"'),
         "#{name} detail pagination landmark is missing an accessible name")
end
assert(!deformation_publication.include?('class="page__back-link"'),
       "Portfolio back navigation leaked into a publication detail")
assert(deformation_portfolio.include?('data-lightbox="gallery"'),
       "project-detail Gallery lightbox behavior is missing")

smart_home_required = [
  "89.1% validation accuracy",
  "seven Chinese command classes",
  "OneNET Device Control",
  "iFLYTEK Spark Voice Dialogue",
  "weather and time queries",
  "This subsystem did <strong>not</strong> generate device-control commands",
  "1.8-inch ST7735S TFT display",
  "INMP441 digital microphone",
  "MAX98357 I2S audio amplifier",
  "My Contribution",
  "Led project planning, task coordination, and team-wide integration",
  "Sep 2024 – Dec 2024",
  'preload="metadata"',
  'poster="/images/portfolio/smart-home/main.jpg"'
]
smart_home_required.each do |text|
  assert(smart_home_portfolio.include?(text),
         "corrected smart-home detail is missing: #{text}")
end

smart_home_forbidden = [
  "96.2",
  "8 h Mandarin",
  "13-dim MFCC",
  "120 k-parameter",
  "28 mW",
  "45 mA",
  "10 Mandarin/English",
  "4-layer PCB",
  "KiCad",
  "CMSIS-NN",
  "FreeRTOS",
  "OTA update",
  "24-hour soak tests",
  "achieving production-ready performance",
  "GitHub (partial)"
]
smart_home_forbidden.each do |text|
  assert(!smart_home_portfolio.include?(text),
         "unsupported smart-home claim remains: #{text}")
end
assert(!smart_home_portfolio.include?('href="#"'),
       "smart-home detail still contains a placeholder link")

smart_home_synced_pages = [cv, smart_home_portfolio]
assert(smart_home_synced_pages.all? { |html| html.include?("Sep 2024 – Dec 2024") },
       "smart-home project period is not synchronized")
assert(smart_home_synced_pages.all? { |html| html.include?("89.1%") },
       "smart-home validation accuracy is not synchronized")
assert(smart_home_synced_pages.all? { |html| html.include?("seven") },
       "smart-home seven-class scope is not synchronized")

ball_robot_required = [
  "Remote-Controlled Multifunctional Ball-Collecting Robot",
  "Feb 2024 – Jul 2024",
  "second overall in the final course competition",
  "50 cm × 50 cm × 50 cm",
  "C50C controller built around the STM32F407VET6",
  "24 V, 1:51 planetary-geared brushed motors",
  "My Contribution",
  "Wrote most of the STM32 control program",
  "Co-tuned the PID and PWM motor-control behavior",
  "Solely operated the robot by remote control during the competition",
  "¥3,401.43",
  'preload="metadata"',
  'poster="/images/portfolio/ball-robot/01.png"'
]
ball_robot_required.each do |text|
  assert(ball_robot_portfolio.include?(text),
         "corrected ball-robot detail is missing: #{text}")
end

ball_robot_forbidden = [
  "Remote-Controlled Multifunctional Ball Picking and Placing Robot",
  "28 N",
  "1.2 m",
  "&lt;3 °",
  "7.4 V",
  "5200 mAh",
  "20 min",
  "35°",
  "12-litre",
  "45 s",
  "30 % faster",
  "6 basketballs",
  "60 ping-pong balls",
  "15 tennis-ball equivalents",
  "L298N",
  "carbon-PETG",
  "180 g",
  "magnetic-encoder",
  "stable trajectory tracking",
  "precise grasp-transport-drop"
]
ball_robot_forbidden.each do |text|
  assert(!ball_robot_portfolio.include?(text),
         "unsupported ball-robot claim remains: #{text}")
end

ball_robot_synced_pages = [cv, ball_robot_portfolio]
assert(ball_robot_synced_pages.all? { |html| html.include?("Remote-Controlled Multifunctional Ball-Collecting Robot") },
       "ball-robot title is not synchronized")
assert(ball_robot_synced_pages.all? { |html| html.include?("Feb 2024 – Jul 2024") },
       "ball-robot project period is not synchronized")
assert(ball_robot_synced_pages.all? { |html| html.include?("second overall") },
       "ball-robot competition result is not synchronized")

project_galleries = {
  "deformation reconstruction" => [deformation_portfolio, 5, 5],
  "hand exoskeleton" => [exo_portfolio, 2, 2],
  "smart-home terminal" => [smart_home_portfolio, 3, 8],
  "wine-quality analysis" => [wine_portfolio, 7, 7],
  "ball-picking robot" => [ball_robot_portfolio, 3, 5],
  "RoboCon Angkor Bloom" => [angkor_portfolio, 2, 8],
  "water-surface robot" => [water_robot_portfolio, 3, 4]
}

gallery_images = []
project_galleries.each do |name, (html, expected_full, expected_contain)|
  image_tags = html.scan(/<img\b[^>]*>/).select do |tag|
    tag.match?(/\bclass="[^"]*\bgallery-image\b/)
  end
  gallery_images.concat(image_tags)

  full_count = html.scan("gallery-item--full").length
  contain_count = html.scan("gallery-image--contain").length
  assert(full_count == expected_full,
         "#{name} gallery expected #{expected_full} full-width images, found #{full_count}")
  assert(contain_count == expected_contain,
         "#{name} gallery expected #{expected_contain} contained images, found #{contain_count}")
end

assert(gallery_images.length == 49,
       "expected 49 visible project-gallery images, found #{gallery_images.length}")
gallery_images.each_with_index do |tag, index|
  alt_text = tag[/\balt="([^"]*)"/, 1]
  assert(alt_text && !alt_text.strip.empty?,
         "gallery image #{index + 1} has missing or empty alt text")
  assert(tag.include?('loading="lazy"'),
         "gallery image #{index + 1} does not use lazy loading")
  assert(tag.include?('decoding="async"'),
         "gallery image #{index + 1} does not use asynchronous decoding")
end

main_css = read_built("assets/css/main.css")
assert(main_css.include?(".lightbox-overlay{display:none"),
       "lightbox overlay is not hidden by default")
assert(main_css.include?(".lightbox-overlay.active{display:flex"),
       "active lightbox overlay styling is missing")
assert(!main_css.include?("figure .lightbox-overlay"),
       "lightbox overlay styling is incorrectly scoped under figure")
assert(main_css.include?(".project-gallery.half>.gallery-item--full{width:100%}"),
       "full-width project-gallery styling is missing")
assert(main_css.include?(".project-gallery .gallery-image--contain{object-fit:contain"),
       "contained project-gallery styling is missing")
assert(main_css.include?('.page__content mjx-container[display="true"]{display:block;max-width:100%;overflow-x:auto'),
       "narrow-screen display-math overflow protection is missing")
assert(main_css.include?(".home-direction-grid,.home-project-grid,.home-output-list{display:grid"),
       "homepage grid layout styling is missing")
assert(main_css.include?(".home-project-card__media{position:relative;display:flex;flex:0 0 auto;min-height:0;aspect-ratio:4 / 3"),
       "homepage featured-project media styling is missing")
assert(main_css.include?(".home-explore{padding:1.25rem;border-left:4px solid var(--global-link-color)"),
       "homepage Explore callout styling is missing")
assert(main_css.include?(".home-project-grid,.home-output-list{grid-template-columns:repeat(2, minmax(0, 1fr))"),
       "homepage medium-width project grid is missing")
assert(main_css.include?(".home-project-grid{grid-template-columns:repeat(3, minmax(0, 1fr))"),
       "homepage wide desktop project grid is missing")
assert(main_css.include?(".home-section-link{display:inline-flex;min-height:44px"),
       "homepage section links do not provide a sufficient touch target")
assert(main_css.match?(/\.home-explore__links a\.btn(?:,[^{]+)?\{[^}]*display:inline-flex;[^}]*min-height:44px/),
       "homepage Explore buttons do not provide a sufficient touch target")
assert(main_css.include?("@media (prefers-reduced-motion: reduce){.home-project-card"),
       "homepage card motion is not disabled for reduced-motion users")
assert(main_css.include?("background:rgba(127,127,127,0.16)"),
       "navigation interaction background does not preserve theme contrast")

cv_publications = cv.scan(/<article class="archive__item"/).length
assert(cv_publications == 2,
       "expected 2 generated CV publication entries, found #{cv_publications}")

[home, portfolio, cv, publications].each_with_index do |html, page_index|
  html.scan(/<script([^>]*)>(.*?)<\/script>/m).each_with_index do |(attributes, source), script_index|
    next if attributes.include?(" src=") || attributes.include?("application/ld+json")

    extension = attributes.include?('type="module"') ? ".mjs" : ".js"
    Tempfile.create(["site-script", extension]) do |file|
      file.write(CGI.unescapeHTML(source))
      file.flush
      output, status = Open3.capture2e("node", "--check", file.path)
      assert(status.success?,
             "inline script #{script_index} on checked page #{page_index} is invalid: #{output}")
    end
  end
end

puts "Site content checks passed."
