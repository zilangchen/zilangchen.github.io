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
assert(home.include?("Aug 2026 – Present"), "Penn education date is missing")
assert(home.include?("+1 (267) 521-3967"), "updated phone number is missing")
assert(home.include?("Philadelphia, PA, USA"), "updated location is missing")
assert(home.include?("currently an MSE student"), "current MSE profile statement is missing")
assert(home.include?("<strong>Email:</strong>"), "contact email label is missing")
assert(home.include?("<strong>Phone number:</strong>"), "contact phone label is missing")
assert(home.include?("<strong>Location:</strong>"), "contact location label is missing")
assert(!home.include?("(Personal)"), "obsolete personal-email label remains on the profile")
assert(!home.include?("Research Workshop: Computer Vision and Robot Sensors"),
       "removed online research workshop remains on the profile")
assert(!home.include?("Math 156 Machine Learning"),
       "removed UCLA course detail remains on the profile")

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
  "Remote-Controlled Multifunctional Ball Picking and Placing Robot"
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

education_order = [
  "University of Pennsylvania, Philadelphia",
  "South China University of Technology, Guangzhou",
  "International Summer Undergraduate Research Experience (ISURE)",
  "University of California, Los Angeles, USA"
]
education_positions = education_order.map { |text| home.index(text) }
assert(education_positions.all?, "one or more expected education entries are missing")
assert(education_positions == education_positions.sort,
       "education entries are not ordered by latest end date")

research_section = home[/<h2 id="research-experience">.*?(?=<h2 id="project-experience">)/m]
project_section = home[/<h2 id="project-experience">.*?(?=<h2 id="honors--awards">)/m]
assert(research_section, "research experience section is missing")
assert(project_section, "project experience section is missing")

research_titles = [
  "Real-Time Robotic-Arm Motion Planning from Temporal Logic",
  "Zero-Shot Deformation Reconstruction for Soft Robots",
  "Wine Quality Prediction with Ensemble Trees"
]
project_titles = [
  "Climbing-Assisted Hand Exoskeleton",
  "Embedded Smart Home Terminal Based on Lightweight Machine Learning",
  "Remote-Controlled Multifunctional Ball Picking and Placing Robot",
  "Bionic Water-Strider Robot"
]
research_titles.each do |title|
  assert(research_section.include?(title), "research entry is missing or misclassified: #{title}")
  assert(!project_section.include?(title), "research entry appears in project experience: #{title}")
end
project_titles.each do |title|
  assert(project_section.include?(title), "project entry is missing or misclassified: #{title}")
  assert(!research_section.include?(title), "project entry appears in research experience: #{title}")
end
assert(home.include?("Proceedings of the 2nd International Conference on Image Processing, Machine Learning, and Pattern Recognition"),
       "full IPMLP proceedings title is missing from the profile citation")
assert(home.include?("162–170"), "IPMLP publication page range is missing")
assert(home.include?('href="https://doi.org/10.1145/3759928.3759955"'),
       "clickable IPMLP DOI is missing")

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
  "Remote-Controlled Multifunctional Ball Picking and Placing Robot",
  "RoboCon ‘Angkor Bloom’ - National College Student Robotics Competition",
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
  "Sep 2024 – Jan 2025",
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
assert(deformation_portfolio.include?('href="https://arxiv.org/abs/2603.19543"'),
       "deformation project detail is missing its current public manuscript link")

project_galleries = {
  "deformation reconstruction" => [deformation_portfolio, 5, 5],
  "hand exoskeleton" => [exo_portfolio, 2, 2],
  "smart-home terminal" => [smart_home_portfolio, 3, 8],
  "wine-quality analysis" => [wine_portfolio, 7, 7],
  "ball-picking robot" => [ball_robot_portfolio, 1, 2],
  "RoboCon Angkor Bloom" => [angkor_portfolio, 0, 0],
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
