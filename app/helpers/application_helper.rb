module ApplicationHelper
  def flash_class flash
    if flash.key?(:success)
      'alert-success'
    elsif flash.key?(:warning)
      'alert-warning'
    end
  end

  def flash_body flash
    if flash.key?(:success)
      flash[:success]
    elsif flash.key?(:warning)
      flash[:warning]
    end
  end
end
