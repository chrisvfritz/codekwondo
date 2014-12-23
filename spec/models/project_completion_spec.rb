describe ProjectCompletion do

  it { should validate_presence_of :url             }
  it { should validate_presence_of :github_repo_url }
  it { should validate_presence_of :project         }
  it { should validate_presence_of :user            }

  it do
    create :project_completion, project: build(:project, :with_criteria)
    should validate_uniqueness_of :url
  end

  it do
    create :project_completion, project: build(:project, :with_criteria)
    should validate_uniqueness_of :github_repo_url
  end

  it do
    create :project_completion, project: build(:project, :with_criteria)
    should validate_uniqueness_of(:user_id).scoped_to :project_id
  end

  context 'when creating a new project completion with valid data' do
    before(:each) { @project_completion = create(:project_completion, project: build(:project, :with_criteria)) }

    subject { @project_completion }

    it { should be_valid }
  end

  context 'when passed a valid URL WITHOUT http or https' do
    before(:each) { @project_completion = create :project_completion, project: build(:project, :with_criteria), url: 'google.com' }

    it 'should prepend http:// to the url' do
      expect(@project_completion.url).to eq('http://google.com')
    end
  end

  context 'when passed a URL that is NOT formatted properly' do
    before(:each) do
      require 'webmock'
      WebMock.allow_net_connect!
    end

    it 'should return a message saying it is NOT a valid web address' do
      expect {
        create :project_completion, project: build(:project, :with_criteria), url: 'arst'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url isn't a valid web address")
    end
  end

  context 'when passed a URL that\'s formatted properly but has a domain that does NOT exist on the web' do
    before(:each) do
      require 'webmock'
      WebMock.allow_net_connect!
    end

    it 'should return a message saying it does NOT exist on the web' do
      expect {
        create :project_completion, project: build(:project, :with_criteria), url: 'oih1235oieh1235oihe12io3e5hoi1.com'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url doesn't seem to exist on the web")
    end
  end

  context 'when passed a URL that\'s formatted properly, with a valid domain, but does not have a page' do
    it 'should return a message saying that there is NOT a page on that domain' do
      expect {
        create :project_completion, project: build(:project, :with_criteria), url: 'www.google.com/not_a_page'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: Url doesn't appear to be a page on www.google.com (404: Not Found)")
    end
  end

  context 'when a github_repo_url does NOT match a URL of the user\'s existing repos' do
    it 'should raise a validation error' do
      expect {
        create :project_completion, project: build(:project, :with_criteria), github_repo_url: 'www.google.com/not_a_page'
      }.to raise_exception(ActiveRecord::RecordInvalid, "Validation failed: That's odd. This repo doesn't belong to you. Suspicious activity has been logged.")
    end
  end

  describe '#completed?' do

    context 'when NOT completed' do
      before(:each) { @completion = create(:project_completion, project: create(:project, :with_criteria)) }

      it 'should return false' do
        expect( @completion.completed? ).to eq(false)
      end
    end

    context 'when completed' do
      before(:each) { @completion = create(:project_completion, :completed, project: create(:project, :with_criteria)) }

      it 'should return true' do
        expect( @completion.completed? ).to eq(true)
      end
    end
  end

end