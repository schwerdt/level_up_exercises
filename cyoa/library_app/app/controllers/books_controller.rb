#require_relative '../../lib/api_interaction/call_classify_api.rb'
require "api_interaction/call_classify_api"

class BooksController < ApplicationController
  #before_filter :authenticate_user!

  def index
  end

  def get_search_query
  end

  def perform_search
    response = CallClassifyAPI::query_api(params, true)
    @parsed_response = CallClassifyAPI::parse_response(response)
  end

  def select_item
    redirect_to new_user_session_path if !user_signed_in?
    puts 'who is the current user', current_user.email
    #Query the api again with the owi number for the user's selected book to get detailed listing (and oclc num)
    query = { "owi" => params["owi"] }
    response = CallClassifyAPI::query_api(query, false)
    @book = CallClassifyAPI::parse_response(response)
    #need to check if the book is already in book table and in user's collection
  end

end
