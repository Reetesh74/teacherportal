class StudentsController < ApplicationController
  before_action :set_student, only: [:edit, :update, :destroy]

  def index
    @student = current_user.students.new
    @students = current_user.students

    if params[:query].present?
      query = params[:query]
      @students = @students.where("name LIKE ? OR subject LIKE ? OR CAST(marks AS TEXT) LIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
    end
  
    @students = @students.page(params[:page]).per(9)
  end

  def create
    formatted_name = student_params[:name].split.map(&:capitalize).join(' ')
    formatted_subject = student_params[:subject].split.map(&:capitalize).join(' ')
    @student = current_user.students.find_by(name: formatted_name, subject: formatted_subject)

    if @student
      @student.marks = student_params[:marks].to_i
      if @student.save
        redirect_to user_students_path(current_user), notice: 'Student marks were successfully updated.'
      else
        render :new
      end
    else
      @student = current_user.students.build(student_params.merge({name: formatted_name, subject: formatted_subject}))
      if @student.save
        redirect_to user_students_path(current_user), notice: 'Student was successfully created.'
      else
        render :new
      end
    end
  end

  def update
    if @student.update(student_params)
      redirect_to user_students_path(current_user), notice: 'Student was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @student.destroy
    redirect_to user_students_path(current_user), notice: 'Student was successfully deleted.'
  end

  private

  def set_student
    @student = current_user.students.find_by(id: params[:id])
    unless @student
      flash[:alert] = "Student not found."
      redirect_to user_students_path(current_user)
    end
  end

  def student_params
    params.require(:student).permit(:name, :subject, :marks)
  end
end
