#= require active_admin/base

$(document).ready ->
  ## Remote deletion of the Static File
  $(".delete-static-file").on 'ajax:success', (data, status, xhr) ->
    $(this).closest('tr').remove()
