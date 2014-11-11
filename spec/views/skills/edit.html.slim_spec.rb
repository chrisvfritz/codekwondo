require 'rails_helper'

RSpec.describe "skills/edit", :type => :view do
  before(:each) do
    @skill = assign(:skill, Skill.create!(
      :title => "MyString",
      :creator_id => 1
    ))
  end

  it "renders the edit skill form" do
    render

    assert_select "form[action=?][method=?]", skill_path(@skill), "post" do

      assert_select "input#skill_title[name=?]", "skill[title]"

      assert_select "input#skill_creator_id[name=?]", "skill[creator_id]"
    end
  end
end
