require 'rails_helper'

RSpec.describe "skills/index", :type => :view do
  before(:each) do
    assign(:skills, [
      Skill.create!(
        :title => "Title",
        :creator_id => 1
      ),
      Skill.create!(
        :title => "Title",
        :creator_id => 1
      )
    ])
  end

  it "renders a list of skills" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
