class VotingSession < ActiveRecord::Base
  acts_as_voter

  def self.find_or_create_voting_session(ip)
    find_by(ip: ip) || create(ip: ip)
  end
end
