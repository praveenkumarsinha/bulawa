class User < ApplicationRecord

  #==== Constants =====================================================
  EMAIL_REGEXP = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  #==== Associations ==================================================
  belongs_to :account, inverse_of: :users

  #==== Validations ===================================================
  validates :account, presence: true
  validates :email, presence: true, uniqueness: {scope: :account_id, case_sensitive: false}, format: {with: EMAIL_REGEXP}

  #==== Miscellaneous =================================================
  has_secure_password

  #==== Callbacks (Filters) ===========================================
  before_save :do_downcase_email


  private
  def do_downcase_email
    self.email.try(:downcase)
  end

end
