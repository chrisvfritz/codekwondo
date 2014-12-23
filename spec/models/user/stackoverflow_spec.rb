describe User do

  describe '.stackoverflow_ids' do

    before(:each) do
      @users_with_stackoverflow  = create_list :user, 150, :with_stackoverflow_id
      @user_without_stackoverlow = create :user
    end

    it 'should return an array' do
      expect( User.stackoverflow_ids ).to be_an(Array)

    end

    it 'should return exactly 100 items' do
      expect( User.stackoverflow_ids.size ).to eq(100)
    end

    it 'should list most stackoverflow_ids of 100 most recent users' do
      expect( User.stackoverflow_ids ).to eq( @users_with_stackoverflow.sort_by{|u| -u.created_at.to_f }.first(100).map(&:stackoverflow_id) )
    end

    it 'should NOT list users without a stackoverflow_id' do
      expect( User.stackoverflow_ids ).not_to include( @user_without_stackoverlow.stackoverflow_id )
    end

  end

  describe '.stackoverflow_questions' do

    before(:each) do
      @users_with_stackoverflow  = create_list :user, 10, :with_stackoverflow_id
    end

    it 'should return an array' do
      expect( User.stackoverflow_questions ).to be_an(Array)
    end

    describe 'each item in the returned array' do

      it 'should respond to is_answered' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:is_answered)
        end
      end

      it 'should respond to answer_count' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:answer_count)
        end
      end

      it 'should respond to answers' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:answers)
        end
      end

      it 'should respond to title' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:title)
        end
      end

      it 'should respond to link' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:link)
        end
      end

      it 'should respond to score' do
        User.stackoverflow_questions.each do |question|
          expect( question ).to respond_to(:score)
        end
      end

    end

  end

end