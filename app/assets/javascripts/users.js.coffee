jQuery ->
  $('#user_major_name').autocomplete
    source: $('#user_major_name').data('autocomplete-source')

  $('#user_university_name').autocomplete
    source: $('#user_university_name').data('autocomplete-source')


  $('#user_major_id').parent().hide()
  majors = $('#user_major_id').html()
  $('#user_university_id').change ->
    university = $('#user_university_id :selected').text()
    options = $(majors).filter("optgroup[label='#{university}']").html()

    if options
      $('#user_major_id').html(options)
      $('#user_major_id').parent().show()
    else
      $('#user_major_id').empty()
      $('#user_major_id').parent().hide()


