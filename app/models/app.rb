class App < ApplicationRecord

  #==== Constants =====================================================
  ENVIRONMENTS = %w(staging production)

  #==== Associations ==================================================
  belongs_to :account, inverse_of: :apps
  has_many :communication_keys, inverse_of: :app, dependent: :destroy
  has_many :entities, inverse_of: :app, dependent: :destroy
  has_many :events, inverse_of: :app, dependent: :destroy

  #==== Validations ===================================================
  validates :account, presence: true
  validates :name, presence: true, length: {within: 1..191}
  validates :environment, inclusion: {in: ENVIRONMENTS}

  #==== Callbacks (Filters) ===========================================
  after_create :generate_default_communication_keys

  private

  def generate_default_communication_keys
    communication_keys.create
  end

end
