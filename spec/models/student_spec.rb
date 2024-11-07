require 'rails_helper'

RSpec.describe Student, type: :model do
  it { should belong_to(:user) }

  context 'validations' do
    it 'is valid with valid attributes' do
      student = build(:student)
      expect(student).to be_valid
    end

    it 'is invalid without a name' do
      student = build(:student, name: nil)
      expect(student).not_to be_valid
      expect(student.errors[:name]).to include("can't be blank")
    end

    it 'is invalid with a name containing numbers' do
      student = build(:student, name: "John123")
      expect(student).not_to be_valid
      expect(student.errors[:name]).to include("only allows letters")
    end

    it 'is invalid without marks' do
      student = build(:student, marks: nil)
      expect(student).not_to be_valid
      expect(student.errors[:marks]).to include("can't be blank")
    end

    it 'is invalid with marks less than 0' do
      student = build(:student, marks: -5)
      expect(student).not_to be_valid
      expect(student.errors[:marks]).to include("must be a number between 0 and 100")
    end

    it 'is invalid with marks greater than 100' do
      student = build(:student, marks: 105)
      expect(student).not_to be_valid
      expect(student.errors[:marks]).to include("must be a number between 0 and 100")
    end
  end
end
