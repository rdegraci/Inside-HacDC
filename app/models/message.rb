class Message < ActiveRecord::Base

  validates_presence_of :plaintext
  validates_length_of :plaintext, :maximum => 180
  validates_length_of :nickname, :maximum => 30
end
