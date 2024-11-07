require 'rails_helper'

RSpec.describe StudentsController, type: :controller do
  let(:user) { create(:user) }
  let!(:student) { create(:student, user: user) }

  before do
    sign_in user # assuming Devise is being used for authentication
  end

  describe 'GET #index' do
    it 'assigns @students and @student' do
      get :index, params: { user_id: user.id }
      expect(assigns(:students)).to eq(user.students.page(1).per(6))
      expect(assigns(:student)).to be_a_new(Student)
      expect(response).to render_template(:index)
    end
  end

  describe 'POST #create' do
    # context 'when student with same name and subject exists' do
    #   let(:existing_student) { create(:student, name: 'John', subject: 'Math', user: user) }

    #   it 'updates marks of existing student and redirects' do
    #     post :create, params: { user_id: user.id, student: { name: 'john', subject: 'math', marks: 90 } }
    #     existing_student.reload
    #     expect(existing_student.marks).to eq(90)
    #     expect(response).to redirect_to(user_students_path(user))
    #     expect(flash[:notice]).to eq('Student marks were successfully updated.')
    #   end
    # end

    context 'when student does not exist' do
      it 'creates a new student and redirects' do
        post :create, params: { user_id: user.id, student: { name: 'New Student', subject: 'Science', marks: 85 } }
        new_student = user.students.find_by(name: 'New Student', subject: 'Science')
        expect(new_student).not_to be_nil
        expect(new_student.marks).to eq(85)
        expect(response).to redirect_to(user_students_path(user))
        expect(flash[:notice]).to eq('Student was successfully created.')
      end
    end

    context 'with invalid params' do
      it 'renders the new template' do
        post :create, params: { user_id: user.id, student: { name: '', subject: '', marks: nil } }
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the student and redirects' do
        patch :update, params: { user_id: user.id, id: student.id, student: { name: 'Updated Name', marks: 95 } }
        student.reload
        expect(student.name).to eq('Updated Name')
        expect(student.marks).to eq(95)
        expect(response).to redirect_to(user_students_path(user))
        expect(flash[:notice]).to eq('Student was successfully updated.')
      end
    end

    context 'with invalid params' do
      it 'renders the edit template' do
        patch :update, params: { user_id: user.id, id: student.id, student: { name: '', marks: nil } }
        expect(response).to render_template(:edit)
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the student and redirects' do
      expect {
        delete :destroy, params: { user_id: user.id, id: student.id }
      }.to change(user.students, :count).by(-1)
      expect(response).to redirect_to(user_students_path(user))
      expect(flash[:notice]).to eq('Student was successfully deleted.')
    end
  end

  describe 'before_action :set_student' do
    context 'when student is not found' do
      it 'redirects to students index with alert' do
        get :edit, params: { user_id: user.id, id: 0 }
        expect(response).to redirect_to(user_students_path(user))
        expect(flash[:alert]).to eq('Student not found.')
      end
    end
  end
end
