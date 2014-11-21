describe Resource do

  it { should validate_presence_of :title   }
  it { should validate_presence_of :url     }
  it { should validate_presence_of :skill   }
  it { should validate_presence_of :creator }

  it { should validate_uniqueness_of(:title).scoped_to :skill_id }
  it do
    create :resource
    should validate_uniqueness_of(:url).scoped_to :skill_id
  end

  context 'when creating a new resource with valid data' do
    before(:each) { @resource = create(:resource) }

    subject { @resource }

    it { should be_valid }
  end

end