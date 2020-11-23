require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @grid = ('A'..'Z').to_a.shuffle[0..9]
  end

  def score
    @attempt = params[:word]
    @grid = params[:grid].split("")
    url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
    user_word = JSON.parse(open(url).read)
      if user_word["found"]
        if @attempt.upcase.split("").all? { |letter| @attempt.upcase.count(letter) <= @grid.count(letter) }
          @message = "Well done!"
          @score = @attempt.length
        else
          @message = "Sorry #{@attempt} is not in the grid"
          @score = 0
        end
      else
        @message = "Sorry #{@attempt} is not an english word"
        @score = 0
    end
  end
end

