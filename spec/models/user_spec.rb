describe User do

  it { should validate_presence_of :provider   }
  it { should validate_presence_of :uid        }
  it { should validate_presence_of :username   }
  it { should validate_presence_of :name       }
  it { should validate_presence_of :email      }
  it { should validate_presence_of :image_url  }
  it { should validate_presence_of :github_url }

  context 'when creating a new user with valid data' do
    before(:each) { @user = FactoryGirl.create(:user) }

    subject { @user }

    it { should be_valid }
  end

end