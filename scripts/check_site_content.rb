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
wine_portfolio = read_built("portfolio/wine-quality-analysis.html")

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
  "All code, configurations, and detailed experimental logs"
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

publication_title_positions = [arxiv_title, "Wine Quality Prediction with Ensemble Trees"].map do |title|
  publications.index(title)
end
assert(publication_title_positions.all?, "one or more publication titles are missing")
assert(publication_title_positions == publication_title_positions.sort,
       "publication entries are not ordered newest first")
assert(!publications.match?(/<p class="archive__item-excerpt"[^>]*>\s*<\/p>/),
       "publication listing contains an empty excerpt paragraph")

portfolio_dates = portfolio.scan(/<time datetime="([^"]+)"/).flatten.map do |value|
  DateTime.parse(value)
end
assert(portfolio_dates.length == 8,
       "expected 8 portfolio dates, found #{portfolio_dates.length}")
assert(portfolio_dates == portfolio_dates.sort.reverse,
       "portfolio entries are not ordered newest first")
assert(portfolio.scan("Project date:").length == 8,
       "portfolio cards do not consistently label project dates")
assert(deformation_portfolio.include?("Project date:"),
       "deformation project detail does not label its date clearly")
assert(deformation_portfolio.include?('href="https://arxiv.org/abs/2603.19543"'),
       "deformation project detail is missing its current public manuscript link")
main_css = read_built("assets/css/main.css")
assert(main_css.include?(".lightbox-overlay{display:none"),
       "lightbox overlay is not hidden by default")
assert(main_css.include?(".lightbox-overlay.active{display:flex"),
       "active lightbox overlay styling is missing")
assert(!main_css.include?("figure .lightbox-overlay"),
       "lightbox overlay styling is incorrectly scoped under figure")

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
