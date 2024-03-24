# frozen_string_literal: true
require 'yaml'

class YamlConfiguration
  class << self
    def load_file(file_name, environment = Rails.env)
      file_path = Rails.root.join('config', "#{file_name}.yml")
      YAML.safe_load_file(file_path, aliases: true)["#{environment}"]
    end
  end
end
