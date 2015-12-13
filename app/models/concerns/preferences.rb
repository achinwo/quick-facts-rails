module Preferences
  extend ActiveSupport::Concern

  included do
    has_many :preferences
    @@preferences = {}
  end

  module ClassMethods
    def preference(name, default)
      preferences = self.class_variable_get(:'@@preferences')
      preferences[name] = default
      self.class_variable_set(:'@@preferences', preferences)
    end
  end

  def read_pref(name)
    if p = self.preferences.where(name: name).first
      return p
    end
    return self.preferences.new(name: name, value: @@preferences[name]) if @@preferences.has_key?(name)
    nil
  end

  def write_pref(name, value)
    p = self.preferences.find_or_create_by(name: name)
    p.update_attribute(:value, value)
  end
end