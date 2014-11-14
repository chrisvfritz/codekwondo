$ ->
  $('.sortable').sortable
    axis: 'y',
    update: ->
      $.post( $(@).data('update-url'), $(@).sortable('serialize') ).done ->
        $('tbody.sortable').find('.ui-sortable-handle').each (index) ->
          $(@).children('td').first().text index+1