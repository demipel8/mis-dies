require 'net/http'
require 'uri'
require 'json'

class MisDies
  def initialize(repo, pull_request, token)
    @repo = repo
    @pull_request = pull_request
    @token = token
  end

  def give_plus_one
    response = approve(pull_request_uri)

    parse(response)
  end

  private

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end

  def pull_request_uri
    URI.parse("#{ENV['GITHUB_API_URL']}/repos/#{@repo}/pulls/#{@pull_request}/reviews")
  end

  def approve(uri, limit = 10)
    raise StandardError, 'HTTP redirect too deep' if limit == 0

    header = {'Authorization': "token #{@token}"}
    body = { event: 'APPROVE' }

    request = Net::HTTP::Post.new(uri.request_uri, header)
    request.body = body.to_json

    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = (uri.scheme == "https")

    response = http.request(request)

    case response
    when Net::HTTPSuccess     then response
    when Net::HTTPRedirection then fetch(response['location'], token, limit - 1)
    else
      response.error!
    end
  end
end
