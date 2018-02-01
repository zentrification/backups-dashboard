require 'sinatra'
require 'sinatra/config_file'
require 'slim'
require 'ostruct'

config_file './settings.yml'

get '/' do
  @backups = settings.backups
  slim :home
end

class Backup < OpenStruct
  def last_modified_at
    File.mtime(last_changed_file)
  end

  def last_changed_file
    Dir.glob("#{self.directory}/**").max_by { |f| File.mtime(f) rescue Time.now - 10**9 }
  end
end
