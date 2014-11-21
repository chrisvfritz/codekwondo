describe Course do

  it { should validate_presence_of :title   }
  it { should validate_presence_of :abbrev  }
  it { should validate_presence_of :creator }

  it { should validate_uniqueness_of(:title ).scoped_to :creator_id }
  it { should validate_uniqueness_of(:abbrev).scoped_to :creator_id }

  context 'when creating a new course with valid data' do
    before(:each) { @course = create(:course) }

    subject { @course }

    it { should be_valid }
  end

end