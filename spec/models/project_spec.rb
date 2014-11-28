describe Project do

  it { should validate_presence_of :title       }
  it { should validate_presence_of :description }
  it { should validate_presence_of :criteria    }
  it { should validate_presence_of :creator     }
  it { should validate_presence_of :skill       }

  it { should validate_uniqueness_of(:title).scoped_to :skill_id }

  context 'when creating a new project with valid data' do
    before(:each) { @project = create(:project, :with_criteria) }

    subject { @project }

    it { should be_valid }
  end

end