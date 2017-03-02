class QueryController < ApplicationController

  include HTTParty

  BASE_URI = 'https://api.knowthycustomer.com/phone'
  NO_RESULTS_RESPONSES = ['some jerk', 'who cares', 'a doodoohead', 'a penguin', 'nobody', 'som jackass', 'a mystery']

  def new
  end

  def search
    api_key = ENV["API_KEY"]

    query = params['q']

    composed_query = BASE_URI + '?api_key=' + api_key + '&phone=' + query

    json = HTTParty.get(composed_query)

    if json && json['names'] && json['names'].first && json['names'].first['parts'] && json['names'].first['parts'] && result_name = json['names'].first['parts']['first_name']
      @result = 'dis ' + result_name.downcase
    elsif query != ''
      @result = 'dis ' + NO_RESULTS_RESPONSES.sample
    else
      @result = 'put inna numbr'
    end

    respond_to do |format|
      format.html { render 'new' }
    end
  end

end
