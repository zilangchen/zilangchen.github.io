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
  "Real-Time Camera-Free Deformation Reconstruction via Flexible Sensor Array",
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
assert(publications.include?("Accepted to <i>IEEE/RSJ IROS 2026</i>, 2026"),
       "publication listing does not use accepted-status wording")

portfolio_dates = portfolio.scan(/<time datetime="([^"]+)"/).flatten.map do |value|
  DateTime.parse(value)
end
assert(portfolio_dates.length == 8,
       "expected 8 portfolio dates, found #{portfolio_dates.length}")
assert(portfolio_dates == portfolio_dates.sort.reverse,
       "portfolio entries are not ordered newest first")
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
