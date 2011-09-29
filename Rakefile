require "bundler/gem_tasks"
require "rdoc/task"
require "sdoc"

autoload :FileUtils, "fileutils"

Dir["tasks/**/*.rake"].each do |rake|
  load File.expand_path(rake)
end

RDoc::Task.new do |rdoc|
  rdoc.rdoc_dir = "doc/rdoc"
  rdoc.title = "Rupee Documentation"

  rdoc.options << "-f" << "sdoc"         # format with SDoc
  rdoc.options << "-T" << "rails"        # use the Rails template
  rdoc.options << "-c" << "utf-8"
  rdoc.options << "-g"                   # link to GitHub
  rdoc.options << "-m" << "README.rdoc"  # use README.rdoc as main file
  rdoc.options << "-v"                   # verbose output

  rdoc.rdoc_files.include "README.rdoc"
  rdoc.rdoc_files.include "ext/**/*.{c, h, rb}"
  rdoc.rdoc_files.include "lib/**/*.rb"
end

desc "Copies the documentation files to the path specified in the $RUPEE_DOC environment variable"
task :docs do
  FileUtils.cp_r "doc/rdoc/.", "#{ENV['RUPEE_DOC']}",
    :remove_destination => true
end
