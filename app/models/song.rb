class Song < ApplicationRecord
  validates :title, presence: true
  validates :released, inclusion: {in: [true, false]}
  validates :artist_name, presence: true
  validate :not_repeated_by_same_artist_in_same_year, :release_year_validations

  def not_repeated_by_same_artist_in_same_year
    my_songs = Song.all.select {|s| s.artist_name == self.artist_name}
    my_songs_this_year = my_songs.select {|s| s.release_year == self.release_year}
    not_including_this_one = my_songs_this_year.select {|s| s != self}
    titles_this_year = not_including_this_one.map {|s| s.title}
    if titles_this_year.include?(self.title)
      errors.add(:title, "Title can't be repeated by an artist in the same year.")
    end
  end

  def release_year_validations
    if self.released && release_year == nil
      errors.add(:release_year, "Release year cannot be blank if song is released.")
    elsif self.released && release_year > 2019
      errors.add(:release_year, "Song must be released this year or before.")
    end
  end
end
