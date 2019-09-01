class LessonsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  protect_from_forgery prepend: true, with: :exception
  before_action :authenticate_user!
  before_action :require_authorized_for_current_course, only: [:show]


  def show
  end


  private 

  helper_method :current_lesson
  def current_lesson
      @current_lesson ||= Lesson.find(params[:id])
  end


  def require_authorized_for_current_course
    if current_lesson.section.course.user != current_user
      redirect_to course_path(current_lesson.section.course), alert: 'Not Enrolled in Lesson!'
    end
  end


end
