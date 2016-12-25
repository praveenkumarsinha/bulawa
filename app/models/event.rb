class Event < ApplicationRecord

  #==== Associations ==================================================
  belongs_to :app, inverse_of: :events
  has_many :details, as: :detailable, dependent: :destroy

  has_many :organizing_committees, inverse_of: :event, dependent: :destroy
  has_many :entities, through: :organizing_committees

  has_many :watching_ocs, -> { where(kind: 'Watcher') }, class_name: 'OrganizingCommittee', inverse_of: :event, dependent: :destroy
  has_many :watching_entities, through: :watching_ocs, source: :entity

  #==== Validations ===================================================
  validates :app, presence: true

end
