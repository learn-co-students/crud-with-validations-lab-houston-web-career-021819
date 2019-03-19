class Song < ApplicationRecord

    
    validates :title, presence: true
    validates :title, uniqueness: true
    validates :artist_name, presence: true

    validates :released, inclusion: { in: [true, false]} #use [] to include boolean true/false

    validates :release_year, numericality: {less_than_or_equal_to: Time.now.year}, if: :released #only released, we can validate the release_year as a number

end
