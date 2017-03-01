class QueryController < ApplicationController

  include HTTParty

  base_uri = 'api.knowthycustomer.com'

  def new
  end

  def search
    byebug
    'do stuff'
    query = params[:q]

    json = HTTParty.get(base_uri + query)
  end

end
