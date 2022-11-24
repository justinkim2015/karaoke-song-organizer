class Song < ApplicationRecord
  validates :title, length: { minimum: 1 }, presence: true

  belongs_to :user

  def self.filter(current_user, sort = 'title')
    where(user_id: current_user.id)

    case sort
    when 'artist'
      order(:artist)
    when 'recent'
      order(created_at: :desc)
    else
      order(:title)
    end
  end

  def save_lyrics
    test = HTTParty.get(lyrics_url)
    html = test.body

    document = Nokogiri::HTML(html)
    spaced = document.css('br').each{ |br| br.replace("\n") }
    lyrics = spaced.xpath("//div[contains(@class, 'Lyrics__Container')]")

    update(lyrics: lyrics.text)
  end
end
