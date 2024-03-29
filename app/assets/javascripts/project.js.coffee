
$ ->

  #
  # タスクの追加アクション
  #
  #
  $('#task-add').click ->
    console.log '押された！'
    $.ajax
      async: true
      type: 'GET'
      url: '/project/getform/task'
      success: (data, status, xhr) ->
        $('tbody').append data.data
        return
      error: (xhr, status, error) ->
        return
      complete: (xhr, status) ->
        return
    return

  #
  # 送信(新規)
  #
  #
  $('.project-add-submit').click ->
    # htmlのデータを取得する
    form = $('.project-add').children()
    formData = upload_data(form)

    # タスクの追加　及び　更新
    $.ajax
      async: true
      type: 'POST'
      dataType: 'JSON'
      processData: false
      contentType: false
      url: '/super/project/add'
      data: formData
      success: (msg, status) ->
        if(msg.success)
          console.log(msg)
          window.location = '/super/project/edit/' + msg.id
          return
      error: (XMLHttpRequest, textStatus, errorThrown) ->
        console.log('挿入に失敗')
        window.location = '/super/project/add'
        return
    return

  #
  # 送信(編集)
  #
  #
  $('#wrapper .project-edit-submit').click ->
    # htmlのデータを取得する
    form = $('.project-edit').children()
    formData = upload_data(form)
    project_id = location.pathname.split('/super/project/edit/')[1]
    # タスクの追加　及び　更新
    $.ajax
      async: true
      type: 'POST'
      dataType: 'JSON'
      processData: false
      contentType: false
      url: '/super/project/edit/' + project_id
      data: formData
      success: (msg, status)->
        console.log('aaaa')
        if(msg.success)
          window.location = '/super/project/edit/' + msg.id
          return
      error: (XMLHttpRequest, textStatus, errorThrown)->
        return
    return



  #
  # アップロード用データ
  #
  #
  #
  upload_data = (form) ->
    # フォームデータ (アップロード用)
    formData = new FormData()
    #値を取得ハッシュ化
    project = {
      sales: $(form).find('#sales').val()
      company: $(form).find('#company').val()
      name: $(form).find('#name').val()
      table_name: $(form).find('#table_name').val()
      url: $(form).find('#url').val()
      title: $(form).find('#title').val()
      description: $(form).find('#description').val()
      ogp_description: $(form).find('#ogp_description').val()
      keyword: $(form).find('#keyword').val()
      thanks_title: $(form).find('#thanks_title').val()
      thanks_text: $(form).find('#thanks_text').val()
      mail_title: $(form).find('#mail_title').val()
      mail_text: $(form).find('#mail_text').val()
      personal_info: $(form).find('#personal_info').val()
      start_at: $(form).find('#start_at').val()
      finish_at: $(form).find('#finish_at').val()
      domain_name: $(form).find('#domain_name').val()
      domain_deadline_at: $(form).find('#domain_deadline_at').val()
      ssl_deadline_at: $(form).find('#ssl_deadline_at').val()
    }
    $.each project, (key, val) ->
      formData.append('project['+key+']', val)
      return

    #タスクデータ
    tasks = $(form).find('.task-data').children()
    for val, i in tasks
      formData.append('tasks['+i+'][user_id]', $(val).find('#tasker').val())
      formData.append('tasks['+i+'][name]', $(val).find('#task_name').val())
      formData.append('tasks['+i+'][detail]', $(val).find('#task_detail').val())
    return formData
