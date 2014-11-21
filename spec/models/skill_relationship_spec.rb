describe SkillRelationship do

  it { should validate_presence_of :skill }
  it { should validate_presence_of :prereq }

  it { should validate_uniqueness_of(:skill_id).scoped_to :prereq_id }

  context 'when creating a new skill relationship with valid data' do
    before(:each) { @skill = create(:skill) }

    subject { @skill }

    it { should be_valid }
  end

end