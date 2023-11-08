class PromptsController < ApplicationController
  def search

  end

  def index
    if params[:prompt]
      @items = SearchItem.search(params[:prompt]).records
    end
  end
end
