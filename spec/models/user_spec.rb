describe User do

  it { should validate_presence_of :provider   }
  it { should validate_presence_of :uid        }
  it { should validate_presence_of :username   }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :email      }
  it { should validate_presence_of :image_url  }
  it { should validate_presence_of :github_url }

  context 'when creating a new user with valid data' do
    before(:each) { @user = create(:user) }

    subject { @user }

    it { should be_valid }
  end

  context 'when trying to create a user with a mock mentor' do
    it 'should raise a RecordInvalid exception' do
      expect { create(:user, :mentor) }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context 'when trying to create a user with a mock instructor' do
    it 'should raise a RecordInvalid exception' do
      expect { create(:user, :instructor) }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  context 'when trying to create a user with a mock admin' do
    it 'should raise a RecordInvalid exception' do
      expect { create(:user, :admin) }.to raise_exception(ActiveRecord::RecordInvalid)
    end
  end

  describe '#completed_courses' do
    before(:each) do
      @user = create :user
    end

    context 'when the user has completed NO courses' do
      it 'should return an empty array' do
        expect(@user.completed_courses).to eq( [] )
      end
    end

    context 'when the user has completed courses' do
      before(:each) do
        @completed_course = create(:course, creator: @user)
        skill = create :skill, course: @completed_course
        project = create :project, :with_criteria, skill: skill

        create :project_completion, :completed, project: project, user: @user
      end

      it 'should return an array of the completed courses' do
        expect(@user.completed_courses).to eq( [@completed_course] )
      end
    end

  end

end