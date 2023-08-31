# Hardcoded seed ensures that the data generated here
# always stays the same on each run
FFaker::Random.seed = 1_111

Dir[Rails.root.join('db', 'seeds', '*.rb')].sort.each { |file| require file }

generators = [
  Seeds::Categories, Seeds::Users, Seeds::Articles
]

generators.each do |g|
  puts " Running #{g}..."
  g.seed
end
