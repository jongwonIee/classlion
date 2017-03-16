$(document).ready () ->
  $("select#order").change(-> $(this).closest("form").submit())