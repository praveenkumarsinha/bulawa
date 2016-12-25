class OrganizingCommittee < ApplicationRecord

  #==== Associations ==================================================
  belongs_to :event, inverse_of: :organizing_committees
  belongs_to :entity, inverse_of: :organizing_committees

end
