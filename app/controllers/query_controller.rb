class QueryController < ApplicationController

  include HTTParty

  BASE_URI = 'https://api.knowthycustomer.com/phone'
  NO_RESULTS_RESPONSES = ['some jerk', 'who cares', 'a doodoohead', 'a penguin', 'nobody', 'som jackass', 'a mystery']

  def new
  end

  def search
    api_key = YAML.load_file(Rails.root.join('config').join('ktc.yml'))['api_key']
    query = params['q']

    composed_query = BASE_URI + '?api_key=' + api_key + '&phone=' + query

    json = HTTParty.get(composed_query)

    if json && json['names'] && json['names'].first && json['names'].first['parts'] && json['names'].first['parts'] && result_name = json['names'].first['parts']['first_name']
      @result = result_name.downcase
    else
      @result = NO_RESULTS_RESPONSES.sample
    end

    respond_to do |format|
      format.html { render 'new' }
    end
  end

end
