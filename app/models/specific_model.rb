class SpecificModel < ApplicationRecord
    belongs_to :general_info
    attr_accessor :allgenres
end
