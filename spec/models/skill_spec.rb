describe Skill do

  it { should validate_presence_of :title            }
  it { should validate_presence_of :primary_language }
  it { should validate_presence_of :course           }
  it { should validate_presence_of :creator          }

  it { should validate_uniqueness_of(:title).scoped_to :course_id }

  context 'when creating a new skill with valid data' do
    before(:each) { @skill = create(:skill) }

    subject { @skill }

    it { should be_valid }
  end

end