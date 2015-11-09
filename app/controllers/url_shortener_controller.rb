class UrlShortenerController < ApplicationController
  
  def index

  end

  # def default
  # end

  def expand
    url = URI.parse(params[:url]) rescue false

    if url != false
      slug = url.path.to_s[/[a-z,A-Z,0-9]{6}$/]
      link = ShortLink.find_by_slug_assisted(slug)

      if link.present? && url.host == request.host
        render json: { data: {url: link.long_link.url, slug: link.slug}, status: 200, message: "Found" }
      else
        render json: { data: {}, status: 200, message: "Short link not found" }
      end
    else
      render json: { data: {}, status: 200, message: "Invalid format" }
    end
  end

  def shorten
    url = params[:url]
    link = LongLink.find_or_create_by_url(url)

    if link.short_link.nil?
      ShortLink.create({long_link_id: link.id})
    end

    render json: { data: {url: link.url, slug: link.short_link.slug}, status: 200, message: "OK" }
  end

end