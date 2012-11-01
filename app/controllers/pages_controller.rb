class PagesController < ApplicationController
  def root
    render text: 'Welcome to gether.ly'
  end
end
