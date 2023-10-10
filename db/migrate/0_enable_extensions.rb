class EnableExtensions < ActiveRecord::Migration[7.0]
  def change
    enable_extension "hstore" unless extension_enabled?("hstore")
    enable_extension "pgcrypto" unless extension_enabled?("pgcrypto")
  end
end