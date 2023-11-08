class Collaboration < ApplicationRecord
    belongs_to :general_info
    belongs_to :collaborator, class_name: "GeneralInfo", foreign_key: "collaborator_id"
  end