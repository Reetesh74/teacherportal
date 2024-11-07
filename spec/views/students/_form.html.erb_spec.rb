require 'rails_helper'

RSpec.describe "students/_form.html.erb", type: :view do
  let(:user) { create(:user) }
  let(:student) { build(:student, user: user) }

  before do
    sign_in user
    assign(:student, student)
  end

  context "when rendering the form" do
    it "renders the form correctly" do
      render

      expect(rendered).to have_selector('form')
      expect(rendered).to have_field('student[name]', with: student.name)
      expect(rendered).to have_field('student[subject]', with: student.subject)
      expect(rendered).to have_field('student[marks]', with: student.marks)
    end

    it "renders error messages if there are any validation errors" do
      student.name = nil
      student.valid?
      render

      expect(rendered).to have_content("Name can't be blank")
    end

    it "renders the 'Add' button when it's a new record" do
      render
      expect(rendered).to have_button('Add')
    end

    it "renders the 'Update' button when it's an existing record" do
      student.save
      render
      expect(rendered).to have_button('Update')
    end
  end
end
