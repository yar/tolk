module Tolk
  class Translation < ActiveRecord::Base
    set_table_name "tolk_translations"

    validates_presence_of :text
    validates_uniqueness_of :phrase_id, :scope => :locale_id

    belongs_to :phrase, :class_name => 'Tolk::Phrase'
    belongs_to :locale, :class_name => 'Tolk::Locale'

    attr_accessor :force_set_primary_update
    before_save :set_primary_updated

    before_save :set_previous_text

    private

    def set_primary_updated
      self.primary_updated = self.force_set_primary_update ? true : false
      true
    end

    def set_previous_text
      self.previous_text = self.text_was if text_changed?
      true
    end

  end
end
