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

end