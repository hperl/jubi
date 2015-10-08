#encoding: utf-8
require 'base64'

class Group < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_many :invitations
  belongs_to :owner, class_name: User
  validates :name, presence: true, format: {
    with: /\A[a-z0-9üöäß ]+\z/i,
    message: "muss aus Buchstaben und/oder Zahlen bestehen"
  }

  attr_accessor :email_addresses

  def members
    [self.owner] + self.users
  end
end
