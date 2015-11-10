class UrlShortenerController < ApplicationController
  
  def index

  end

  def expand
    url = get_url
    if url != false
      slug = url.path.to_s[/[a-z,A-Z,0-9]{6}$/]
      link = ShortLink.find_by_slug_assisted(slug)

      if link.present?
        render_result(link.long_link.url, link.slug)
      else
        render_not_found
      end
    else
      render_invalid
    end
  end

  def shorten
    url = get_url

    if url != false
      link = LongLink.find_or_create_by_url(url.to_s)
      ShortLink.create({long_link_id: link.id}) if link.short_link.nil?

      render_result(link.url, link.short_link.slug)
    else
      render_invalid
    end
  
  end

  private

  def get_url
    url = URI.parse(params[:url]) rescue false

    if url != false
      return url if url.kind_of?(URI::HTTP) || url.kind_of?(URI::HTTPS)
    end

    return false
  end


  def render_not_found
    render_invalid(404, "Not Found")
  end

  def render_invalid(status=400, message="Invalid format")
    render json: { data: {}, status: status, message: message }
  end

  def render_result(url, slug)
    render json: { data: {url: url, slug: slug}, status: 200, message: "OK" }
  end

end