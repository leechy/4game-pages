define ['packages/jquery'], ($) ->
  init: ->
    @vkWidgetId = "ps2_subscribe"
    @checkForVKWidget()  if $("#" + @vkWidgetId).length

  checkForVKWidget: ->
    if (typeof VK isnt "undefined" and VK isnt null) and (VK.Widgets?)
      @showNewsVKWidget()
      return true
    $.getScript "//vk.com/js/api/openapi.js?76", $.proxy(@showNewsVKWidget, this)

  showNewsVKWidget: ->
    VK.Widgets.Group @vkWidgetId,
      mode: 1
      width: "282"
      height: "120"
    , 43910974
