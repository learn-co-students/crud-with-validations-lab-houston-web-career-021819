class Song < ApplicationRecord
    validates :title, presence: true
    validates :release_year, uniqueness: { scope: :artist_name }
    validates :released, inclusion: { in: [true, false] }
    validates :release_year, presence: true, if: :released
    validates :release_year, numericality: { 
        allow_nil: true,
        only_integer: true,
        less_than_or_equal_to: ->(_song) {Date.current.year}
    }
    validates :artist_name, presence: true

end
