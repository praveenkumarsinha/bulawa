class CommunicationKey < ApplicationRecord

  #==== Associations ==================================================
  belongs_to :app, inverse_of: :communication_keys
  belongs_to :generator, class_name: 'User', foreign_key: :generator_id

  #==== Validations ===================================================
  validates :app, presence: true

  #==== Filters =======================================================
  before_create :generate_access_token

  private

  def generate_access_token
    begin
      self.access_token = SecureRandom.hex
    end while self.class.exists?(access_token: access_token)
  end
end
