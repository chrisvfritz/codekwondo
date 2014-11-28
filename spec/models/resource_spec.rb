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

  context 'when passed a valid URL WITHOUT http or https' do
    before(:each) { @resource = create :resource, url: 'google.com' }

    it 'should prepend http:// to the url' do
      expect(@resource.url).to eq('http://google.com')
    end
  end

  context 'when passed a URL that is NOT formatted properly' do
    it 'should return a message saying it is NOT a valid web address' do
      expect {
        create :resource, url: 'arst'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url isn't a valid web address")
    end
  end

  context 'when passed a URL that\'s formatted properly but has a domain that does NOT exist on the web' do
    it 'should return a message saying it does NOT exist on the web' do
      expect {
        create :resource, url: 'oih1235oieh1235oihe12io3e5hoi1.com'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url doesn't seem to exist on the web")
    end
  end

  context 'when passed a URL that\'s formatted properly, with a valid domain, but does not have a page' do
    it 'should return a message saying that there is NOT a page on that domain' do
      expect {
        create :resource, url: 'www.google.com/not_a_page'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url doesn't appear to be a page on www.google.com (404: Not Found)")
    end
  end

  describe '#ci_lower_bound' do

    before(:each) do
      @resource = create :resource
      @user = create :user
    end

    context 'when it has 0 votes' do
      it 'should return 0' do
        expect(@resource.ci_lower_bound).to eq(0)
      end
    end

    context 'when it has 1 upvote' do
      before(:each) { @resource.liked_by @user }
      it 'should return 0.20654931654387707' do
        expect(@resource.ci_lower_bound).to eq(0.20654931654387707)
      end
    end

    context 'when it has 1 downvote' do
      before(:each) { @resource.disliked_by @user }
      it 'should return 0' do
        expect(@resource.ci_lower_bound).to eq(0)
      end
    end

  end

  describe '#rating' do

    before(:each) do
      @resource = create :resource
      @user = create :user
    end

    context 'when it has 0 votes' do
      it 'should return 0' do
        expect(@resource.rating).to eq(0)
      end
    end

    context 'when it has 1 upvote' do
      before(:each) { @resource.liked_by @user }
      it 'should return 21' do
        expect(@resource.rating).to eq(21)
      end
    end

    context 'when it has 1 downvote' do
      before(:each) { @resource.disliked_by @user }
      it 'should return 0' do
        expect(@resource.rating).to eq(0)
      end
    end

  end

end