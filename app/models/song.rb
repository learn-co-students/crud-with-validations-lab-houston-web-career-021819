require 'pry'

class Song < ApplicationRecord
  validates :title, presence: true
  validate :release_in_future?
  validate :already_released_this_year?
  validate :with_year_if_released?

  def release_in_future?
    if self.release_year != nil
      if self.release_year - Time.now.year > 0
        errors.add(:release_year, "This song cannot be released in the future")
      end
    end
  end

  def already_released_this_year?
    if self.release_year != nil && Song.all.find_by(release_year: self.release_year) != nil
      Song.all.where(:release_year == self.release_year).each do |released_song|
         if released_song.title == (self.title)
            errors.add(:release_year, "The same song can't be released twice in the same year.")
         end
      end
    end
  end

  def with_year_if_released?
    if self.released == true
      if self.release_year == nil
        errors.add(:release_year, "A released song must include a year of release.")
      end
    end
  end



end
