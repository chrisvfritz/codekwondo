describe ProjectCompletion do

  it { should validate_presence_of :url     }
  it { should validate_presence_of :project }
  it { should validate_presence_of :user    }

  it do
    create :project_completion, project: build(:project, :with_criteria)
    should validate_uniqueness_of(:url).scoped_to :project_id
  end
  it { should validate_uniqueness_of(:user_id).scoped_to :project_id }

  context 'when creating a new project completion with valid data' do
    before(:each) { @project_completion = create(:project_completion, project: build(:project, :with_criteria)) }

    subject { @project_completion }

    it { should be_valid }
  end

end