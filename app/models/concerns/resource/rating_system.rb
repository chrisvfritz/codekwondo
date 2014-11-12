module ::Concerns::Resource::RatingSystem
  extend ActiveSupport::Concern

  included do
    acts_as_votable
  end

  def ci_lower_bound
    pos = self.get_upvotes.count
    n = self.votes_for.count
    return 0 if n == 0
    z = 1.9599639715843482 # Statistics2.pnormaldist(1-(1-confidence)/2) # confidence = 0.95
    phat = 1.0 * pos / n
    (phat + z * z / (2 * n) - z * Math.sqrt((phat * (1 - phat) + z * z / (4 * n)) / n)) / (1 + z * z / n)
  end

  def rating
    return (ci_lower_bound*100).round.to_i
  end
end