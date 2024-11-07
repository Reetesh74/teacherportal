module ApplicationHelper
    def inline_svg(filename, options = {})
      file_path = Rails.root.join('app', 'assets', 'images', filename)
      svg = File.read(file_path)
      
      # Use Nokogiri to parse the SVG and allow for modifying attributes
      doc = Nokogiri::XML(svg)
  
      # Add additional attributes passed through options
      options.each do |key, value|
        doc.root[key.to_s] = value
      end
  
      doc.to_html.html_safe
    end
  end
  