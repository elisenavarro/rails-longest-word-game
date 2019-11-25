require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters_grid = (0...11).map { |_char| ('A'..'Z').to_a.sample }
  end

  # return the result if word is valid or not
  def score
    # set new variable @input_word to eq. the value of 'word:' in the params HASH > input given by users
    @input_word = params[:word]
    # @letters_grid returns the original grid of letters
    @letters_grid = params[:letters]
    # check if @input_word contains the same letters from the @letters_grid
    if !valid_word?(@input_word, @letters_grid)
      @result = "Sorry, but #{@input_word} cannot be built from #{@letters_grid}"
    # check is the word input is valid from the directory API
    elsif english_word?(@input_word)
      @result = "Congrats, #{@input_word} is a valid English word!"
    else
      @result = "Sorry, but #{@input_word} is not a valid English word."
    end
  end

  # INTERNAL METHODS WITHING THE CLASS BUT NOT CALLED ON ELSEWHERE
  def english_word?(word)
    # opening the API file with the input word
    result = open("https://wagon-dictionary.herokuapp.com/#{word}")
    # reading the results of the API as a complete HASH
    json = JSON.parse(result.read)
    # returning API result (hash) for a given word, if found then English word
    json['found']
  end

  # checking is input word is part of letters grid
  def valid_word?(word, letters)
    # take the word from user and split into Array of each letter
    input_word = word.upcase.split('')
    # iterate over the array of letters then
    # .all? checks each condition, returns T/F >>>
    # count of characters in input and the array @letters
    input_word.all? { |letter| input_word.count(letter) <= letters.count(letter) }
  end
end
