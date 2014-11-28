describe ProjectCriterion do

  it { should validate_presence_of :description }
  #it { should validate_presence_of :project     }

  it { should validate_uniqueness_of(:description).scoped_to :project_id }

  context 'when creating a new project criterion with valid data' do
    before(:each) { @project_criterion = create(:project_criterion, project: build(:project)) }

    subject { @project_criterion }

    it { should be_valid }
  end

end