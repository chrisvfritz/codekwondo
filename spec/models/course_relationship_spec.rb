describe CourseRelationship do

  it { should validate_presence_of :course }
  it { should validate_presence_of :prereq }

  it { should validate_uniqueness_of(:course_id).scoped_to :prereq_id }

  context 'when creating a new course relationship with valid data' do
    before(:each) { @course = create(:course) }

    subject { @course }

    it { should be_valid }
  end

end