require 'date'
require 'time'

module ProjectHelper

  #
  # deadLine(deadline_at)
  # author kazuki.yamaguchi
  # Created 2015/12/04
  #
  def deadLine(deadline_at)
    if deadline_at.blank?
      return "<td></td>"
    else
      # 日数差を求める
      diffDay = (Date.parse(Time.at(deadline_at.to_i).strftime("%Y-%m-%d")) - Date.today)
      day = diffDay.to_i
      if 0 < day and day < 10
        return "<td id='dead-danger'>#{day}</td>"
      elsif 10 < day and day < 15
        return "<td id='dead-caution'>#{day}</td>"
      elsif day < 0
        return "<td id='dead-end'>期限が切れました</td>"
      else
        return "<td>#{day}</td>"
      end
    end
  end

  def getTask
    # 出力
    #result = "<div class='task form-group add-task'>"
    result = "<tr>"
    result += "<td>"
    #result += text_field_tag '', '', :class => 'data form-control', :id => 'text', :name => 'task', :placeholder => 'ユーザー'
    result += select_tag '',options_from_collection_for_select(Admin.all, :id, :name),:name => 'tasker',:id => 'tasker', :class => 'span3 form-control'
    result += "</td>"
    result += "<td>"
    result += text_field_tag '', '', :class => 'data form-control',:name => 'task_name',:id => 'task_name', :placeholder => 'タスク名'
    result += "</td>"
    result += "<td>"
    result += text_field_tag '', '', :class => 'data form-control',:name => 'task_detail',:id => 'task_detail', :placeholder => '詳細'
    result += "</td>"
    result += "</tr>"
    #result += "</div>"
    return result
  end


end
