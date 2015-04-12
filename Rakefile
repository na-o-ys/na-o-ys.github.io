require 'rubygems'
require 'rake'
require 'rdoc'
require 'date'
require 'yaml'
require 'tmpdir'
require 'jekyll'

desc "Generate blog files"
task :generate do
  Jekyll::Site.new(Jekyll.configuration({
    "source"      => ".",
    "destination" => "_site"
  })).process
end

desc "Generate and publish blog to master"
task :publish => [:generate] do
  Dir.mktmpdir do |tmp|
    system "mv _site/* #{tmp}"
    system "git checkout -B master"
    system "rm -rf *"
    system "mv #{tmp}/* ."
    message = "Site updated at #{Time.now.utc}"
    system "git add ."
    system "git commit -am #{message.shellescape}"
    system "git push origin master --force"
    system "git checkout build"
    system "echo yolo"
  end
end

desc "Create new post"
task :create, :name do |task, args|
  name = args[:name]
  require 'date'
  date = Date.today.strftime "%Y-%m-%d"
  dir = "competitions/_posts/"
  filename = "#{dir}#{date}-#{name}.markdown"
  open(filename, "w") do |file|
    file.puts <<-EOS
---
layout: competition
date: #{date}
contest: Topcoder SRM
competition: 
problem_type: 
problem_name: #{name}
---

    EOS
  end
  puts "New post: #{filename}"
end
