class Image
  attr_reader :image, :credit

  def initialize(data, location)
    @image = {
      location: location,
      image_url: data[:results].first[:urls][:full]
    }
    @credit = {
      source: 'https://unsplash.com',
      author_username: data[:results].first[:user][:username],
      author_name: data[:results].first[:user][:name],
      author_profile: data[:results].first[:user][:links][:html]
    }
  end
end