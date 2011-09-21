require "yui/compressor"
require 'yaml'
require 'erb'
require 'FileUtils'


CONFIG = YAML::load(File.open('deploy.yml'))

staging_config = CONFIG['staging']
production_config = CONFIG['production']
development_config = CONFIG['development']
compiled_destination = CONFIG['compiled_destination']

@viki_path = CONFIG['viki_path']
@widget_viki_path = @viki_path + '/public/widget'

def compile_asset(file_name, file_contents)

  js_compressor = YUI::JavaScriptCompressor.new(:munge => true)
  css_compressor = YUI::CssCompressor.new
  if file_name =~ /css/
    css_compressor.compress(file_contents)
  elsif file_name =~ /js/
    if CONFIG['minify_js'] == true
      js_compressor.compress(file_contents)
    else
      file_contents
    end
  else
    file_contents.gsub(/\n/, '')
  end
end

[staging_config, production_config, development_config].each do |config|
  @destination = config['destination']
  deploy_destination = "#{compiled_destination}/#{config['destination']}"
  
  erb_paths = ["index.html.erb", "iframe_inline.html.erb", "iframe_new_window.html.erb", "javascripts/viki.widget.js.erb",
    "stylesheets/viki.widget.css"]

  jslibs_path = ["javascripts/jquery.min.js"]

  images_path = ["images/*"]

  # setup the necessary directory to store widget contents
  FileUtils.mkdir_p("#{deploy_destination}/javascripts") unless File.exists?("#{deploy_destination}/javascripts")
  FileUtils.mkdir_p("#{deploy_destination}/stylesheets") unless File.exists?("#{deploy_destination}/stylesheets")
  FileUtils.mkdir_p("#{deploy_destination}/images") unless File.exists?("#{deploy_destination}/images")

  erb_paths.each do |template|

    @viki_web = config['viki_web']
    @viki_widget_url = @viki_web + "/widget/" + @destination
    
    erb_template = ERB.new(File.open(template).read)
    file_name = template.gsub(/\.erb/, '')
    f = File.new("#{deploy_destination}/#{file_name}", "w")
    f.write(compile_asset(file_name, erb_template.result))
    f.close
  end

  images_path.each do |path|
    FileUtils.cp(Dir.glob(path), "#{deploy_destination}/images")
  end
  
  jslibs_path.each do |path|
    FileUtils.cp(path, "#{deploy_destination}/#{path}")
  end
end

puts @widget_viki_path
FileUtils.mkdir_p("#{@widget_viki_path}") unless File.exists?(@widget_viki_path)
FileUtils.cp_r("#{compiled_destination}/.", @widget_viki_path)