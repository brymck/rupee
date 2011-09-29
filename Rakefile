require "bundler/gem_tasks"
require "rdoc/task"
require "sdoc"

Dir["tasks/**/*.rake"].each do |rake|
  load File.expand_path(rake)
end

RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include "README.rdoc"
  rdoc.rdoc_files.include "ext/**/*.{c, h, rb}"
  rdoc.rdoc_files.include "lib/**/*.rb"
  rdoc.options << "-f" << "sdoc"
  rdoc.options << "-c" << "utf-8"
  rdoc.options << "-g"
  rdoc.options << "-m" << "README.rdoc"
end
