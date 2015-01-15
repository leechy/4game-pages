define ['packages/jquery'], ($) ->
  return {
    abilityContainer:      "pPS2_insidePage"
    abilityOnClass:        "pPS2_insidePage__state_on"
    tabTitle:              "pPS2_insidePage__abilityTitleTab"
    tabActiveClass:        "pPS2_insidePage__abilityTitleTab__state_active"
    tabText:               "pPS2_insidePage__abilityTitleTab"
    tabTextActiveClass:    "pPS2_insidePage__abilityTextTab__state_active"


    domEvents:
      "mouseover .pPS2_insidePage__abilitySwitcher": "showAbility"
      "mouseout .pPS2_insidePage__abilitySwitcher": "hideAbility"


    switchEvents:
      "switchPS2Page": "switchHandler"


    init: ->
      @container = $(".pPS2_internal")


    turnOn: ->
      @container.addClass "pPS2_internal_state_visible"
      @tabs = $(".pPS2_insidePage__abilityTitleTab", @element).on "click.ps2_tabs", (event) =>
        @switchTab event


    turnOff: ->
      @tabs.off ".ps2_tabs"


    # Показывает способоность при ховере
    showAbility: ()->
      $(".#{@abilityContainer}").addClass @abilityOnClass
      

    # Убирает изображение способоности
    hideAbility: ()->
      $(".#{@abilityContainer}").removeClass @abilityOnClass


    switchTab: (evt)->
      active = $(evt.currentTarget).addClass(@tabActiveClass)
      active
        .siblings(".#{@tabActiveClass}")
        .removeClass(@tabActiveClass)
        
      $(active.data("content"), @element)
        .addClass(@tabTextActiveClass)
        .siblings(".#{@tabTextActiveClass}")
        .removeClass(@tabTextActiveClass)
        
      $(".#{@abilityContainer}").toggleClass @abilityOnClass


    switchHandler: (callback) ->
      @container.one "webkitTransitionEnd msTransitionEnd oTransitionEnd transitionend", ->
        callback()

      # Делаем небольшую задержку перед выставлением класса который начнет анимацию иначе класс
      # выставиться, а анимация сразу перейдет в финальное состояние.
      setTimeout =>
        @container.removeClass "pPS2_internal_state_visible"
      , 10
  }