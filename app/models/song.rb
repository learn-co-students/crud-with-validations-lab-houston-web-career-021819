class Song < ApplicationRecord
    validates :title, presence: true
    validates_inclusion_of :released, in: [true, false]    #validate :release_check
    validate :year_check
    validate :same_song_same_year

    def year_check
       if released == true
           if release_year != nil && release_year <= Time.now.year
               return true
           else
              errors.add(:year_check, 'must have released year and the year can not be in the future')
           end
        else
            if release_year != nil
                errors.add(:year_check, 'Not released yet!')
            end
        end
    end

    def same_song_same_year
        artist_songs = Song.all.select do |song|
          song.artist_name == self.artist_name
        end

        answer = artist_songs.any? do |song|
          song.artist_name == self.artist_name && song.title == self.title && song.release_year == self.release_year
        end
      if answer == true
        errors.add(:same_song_same_year, 'An artist can not release the same song twice in a year!')
      end
    end
end
 