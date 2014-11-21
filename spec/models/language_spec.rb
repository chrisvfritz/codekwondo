describe Language do

  it { should validate_presence_of :name   }
  it { should validate_presence_of :abbrev }

  it { should validate_uniqueness_of :name   }
  it { should validate_uniqueness_of :abbrev }

  context 'when creating a new language with valid data' do
    before(:each) { @language = create(:language) }

    subject { @language }

    it { should be_valid }
  end

end