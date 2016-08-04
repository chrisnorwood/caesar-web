require 'sinatra'
require 'sinatra/reloader' if development?

def caesar_cipher string, shift = 3
  # Create array of charset arrays to be shifted
  alphabet  = [Array('A'..'Z'), 
               Array('a'..'z')]

  # empty encryption key
  cipher_key = {}

  # propogates cipher_key hash with pairs for each conversion
  # left-shift [-shift] default
  alphabet.each do |charset|
    cipher_key.merge! Hash[charset.zip(charset.rotate(-shift))]
  end

  # iterate through characters of input and match to value found in cipher_key
  output = string.chars.map do |char|
    # returns char as default if no match found
    cipher_key.fetch(char, char)
  end

  output.join
end

get '/' do
  erb :index
end

post '/cipher' do
  text = params[:text]
  
  caesar_cipher(text)
end