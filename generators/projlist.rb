require 'rubygems'
require 'json'

if !(ARGV[0] && ARGV[1])
	puts "missing file names"
	puts "Usage: \nprojlist.rb projectsfile templatefile [output]"
	exit
end

def replaceString(project, template)
	project.inject(template) do |out, (k, v)|
		out.gsub("%" + k + "%", v)
	end
end


projectsFile = ARGV[0]
templateFile = ARGV[1]
puts ARGV[2]
outFile = ARGV[2] || "projlist.html.partial"

projects = JSON.parse(File.read(projectsFile))

template = File.read(templateFile)


output = projects.inject("") do |out, project|
	out + replaceString(project, template)
end


puts outFile

File.write(outFile, output)

