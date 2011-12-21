def run(*cmd)
  system(*cmd)
  raise "Command #{cmd.inspect} failed!" unless $?.success?
end

def confirm(message)
  print "\n#{message}\nAre you sure? [yn] "
  raise 'Aborted' unless STDIN.gets.chomp == 'y'
end

namespace :deploy do
  PRODUCTION_APP = 'docviewer'
  desc "Deploy to Production"
  task :production do
    iso_date = Time.now.strftime('%Y-%m-%dT%H%M%S')

    confirm('This will deploy DocViewer to production.')

    tag_name = "heroku-#{iso_date}"
    puts "\n Tagging as #{tag_name}..."
    run "git tag #{tag_name} master"

    puts "\n Pushing..."
    run "git push origin #{tag_name}"
    run "git push git@heroku.com:#{PRODUCTION_APP}.git #{tag_name}:master"

    puts "\n Migrating..."
    run "heroku rake db:migrate --app #{PRODUCTION_APP}"
    run "heroku rake db:seed --app #{PRODUCTION_APP}"

    puts "\n Deployment process completed"
  end
end

namespace :db do
  PRODUCTION_APP = 'docviewer'
  desc 'Migrate and Seed the Production Database'
  task :production  do
    confirm('This will migrate and seed your Production DB. Are you sure?')
    run "heroku rake db:migrate --app #{PRODUCTION_APP}"
    run "heroku rake db:seed --app #{PRODUCTION_APP}"

    puts "\n migrations ran completely"
  end
end





