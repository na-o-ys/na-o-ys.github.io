task :deploy do
  sh "bin/jekyll build"
  puts "! Push source branch"
  # push source branch (source file)
  sh "git push origin source:source"
  puts "! Copy static file from _site to _deploy"
  sh "rm -rf _deploy/*"
  sh "cp -r _site/* _deploy/"
  puts "! Change directory _deplay"
  cd "_deploy" do
    puts "! Push master branch"
    sh "git add *"
    message = "deploy at #{Time.now}"
    begin
      sh "git commit -m \"#{message}\""
      # push master branch (html)
      sh "git push origin master:master"
    rescue Exception => e
      puts "! Error - git command abort"
      exit -1
    end
  end
end
