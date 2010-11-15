module Riakano
  RIAKANO=File.expand_path("app/map_reduce/", Rails.root)

  def self.map_reduce(file_name)
    _csfile = File.join(RIAKANO, file_name, ".coffee")
    return CoffeeScript.compile File.read(_csfile) if File.exist?(_csfile)

    _jsfile = File.join(RIAKANO, file_name, ".js")
    return File.read(_jsfile) if File.exist?(_jsfile)

    raise 'File Not Found'
  end
end