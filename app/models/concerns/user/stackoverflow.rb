module ::Concerns::User::Stackoverflow
  extend ActiveSupport::Concern

  # Connects a user to their Stack Overflow account
  def connect_stackoverflow(auth)
    self.stackoverflow_omniauth_hash = auth

    self.stackoverflow_id  = auth.uid
    self.stackoverflow_url = auth.info.urls.stackoverflow

    self.save
  end

  module ClassMethods

    def stackoverflow_questions(options={})
      return [] if (so_ids = self.stackoverflow_ids).empty?

      Rails.cache.fetch("stackoverflow_questions: #{Base64.encode64( so_ids.join('') )}, options: #{options}, version: 3", expires_in: 30.minutes) do

        # Get last 30 questions for each user connected to Stack Overflow, grouped by user
        Array( RubyStackoverflow.users_questions(so_ids).data ).
          # Map all the questions into a single array
          map(&:questions).flatten.
          # Weed out any questions that have an accepted answer
          select{|q| options[:unanswered] ? !q.is_answered : true }.
          # Sort results by creation date, descending
          sort_by(&:creation_date).reverse.
          # Only list the most recent 15 questions
          first(10).
          # Convert questions to OpenStructs to preserve access to attributes after caching
          map do |question|
            OpenStruct.new(JSON.parse(question.to_json))
          end

      end

    rescue
      []
    end

    def stackoverflow_ids
      # For the most recent 100 users with a stackoverflow_id (because the API limits
      # us to 100 users at a time), get the stackoverflow_id
      self.where.not(stackoverflow_id: nil).order(created_at: :desc).limit(100).pluck(:stackoverflow_id)
    end

  end

end