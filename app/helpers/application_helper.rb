module ApplicationHelper



  #
  # showFlashMessages
  # flashメッセージを出力する
  #　Author kazuki.yamaguchi
  #　Created 2015/12/03
  #
  def showFlashMessages
    if !flash.blank?
      if flash[:error]
        return "<div class='alert alert-danger'>#{flash[:error]}</div>"
      end
      if flash[:notice]
        return "<div class='alert alert-success'>#{flash[:notice]}</div>"
      end
    end
  end

end
