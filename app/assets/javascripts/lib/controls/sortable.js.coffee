$ ->
  $('.sortable').sortable
    axis: 'y',
    update: ->
      $sortables = $('tbody.sortable').find('.ui-sortable-handle')
      $sortables.each ->
        $(@).children('td').first().html('<span class="glyphicon glyphicon-loading"></span>')
      $.post( $(@).data('update-url'), $(@).sortable('serialize') ).done ->
        $sortables.each (index) ->
          $(@).children('td').first().html index+1