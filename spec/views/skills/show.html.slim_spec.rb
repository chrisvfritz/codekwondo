require 'rails_helper'

RSpec.describe "skills/show", :type => :view do
  before(:each) do
    @skill = assign(:skill, Skill.create!(
      :title => "Title",
      :creator_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/1/)
  end
end
