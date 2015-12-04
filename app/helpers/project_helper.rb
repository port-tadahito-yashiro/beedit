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
      if day < 10
        return "<td id='dead-danger'>#{day}</td>"
      elsif day < 15
        return "<td id='dead-caution'>#{day}</td>"
      else
        return "<td>#{day}</td>"
      end
    end
  end
end
