jQuery ->
  $('#user_major_name').autocomplete
    source: $('#user_major_name').data('autocomplete-source')

  $('#user_university_name').autocomplete
    source: $('#user_university_name').data('autocomplete-source')