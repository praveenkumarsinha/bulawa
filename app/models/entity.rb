class Entity < ApplicationRecord

  #==== Associations ==================================================
  belongs_to :app, inverse_of: :entities
  has_many :details, as: :detailable, dependent: :destroy

  has_many :organizing_committees, inverse_of: :entity, dependent: :destroy
  has_many :events, through: :organizing_committees

  has_many :watching_ocs, -> { where(kind: 'Watcher') }, class_name: 'OrganizingCommittee', inverse_of: :entity, dependent: :destroy
  has_many :spectators_to, through: :watching_ocs, source: :event

  #==== Validations ===================================================
  validates :app, presence: true

end
