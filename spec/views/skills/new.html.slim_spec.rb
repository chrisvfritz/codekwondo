require 'rails_helper'

RSpec.describe "skills/new", :type => :view do
  before(:each) do
    assign(:skill, Skill.new(
      :title => "MyString",
      :creator_id => 1
    ))
  end

  it "renders new skill form" do
    render

    assert_select "form[action=?][method=?]", skills_path, "post" do

      assert_select "input#skill_title[name=?]", "skill[title]"

      assert_select "input#skill_creator_id[name=?]", "skill[creator_id]"
    end
  end
end
