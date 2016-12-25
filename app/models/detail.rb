class Detail < ApplicationRecord

  #==== Validations ===================================================
  validates :property_key,
            length: {within: 1..191},
            presence: true,
            uniqueness: {scope: [:detailable_id, :detailable_type], case_sensitive: false}
  validates :property_key_stripped, presence: true, uniqueness: {scope: [:detailable_id, :detailable_type], case_sensitive: false}

  #==== Callbacks (Filters) ===========================================
  before_validation :populate_property_key_stripped


  private

  def populate_property_key_stripped
    self.property_key_stripped ||= self.property_key.to_s.strip.downcase.gsub(/[ ]/, '-')
  end

end
