define ['packages/jquery'], ($) ->
  return {
    $measurer: null
    currentScene: "scene_1"
    isAnimationGoingOn: 0
    internalScene: ""
    supportsTransition: false
    
    turnOn: (oContainer) ->
      module = this

      # init internal page
      $internalContent = $("#Planetside2Content")
      if $internalContent.length and $internalContent.html() isnt ""
        $insidePage = $internalContent.find(".pPS2_insidePage").eq(0)
        if $insidePage.length
          module.internalScene = $insidePage.attr("data-internal-scene")
          module.currentScene = "scene_" + $insidePage.attr("data-scene")
      
      # event handling
      # menu clicks
      $(".pPS2_menu__item").on "click.ps2scene", (evt) ->
        module._menuClick evt, module, this

      
      # plus/minus controls
      $(".pPS2_menu__plus").on "click.ps2scene", module._menuPlus
      $(".pPS2_menu__minus, .pPS2_scene__info-scale").on "click.ps2scene", module._menuMinus
      
      # scene transition end
      module.$measurer = $("#transition-measurer")

      # check transition support
      transitionProps = ['transition', 'WebkitTransition', 'MozTransition', 'msTransition', 'OTransition']
      for i of transitionProps
        module.supportsTransition = true if module.$measurer[0].style[transitionProps[i]] != undefined

      $(".pPS2_scene").removeClass("pPS2_scene__zeroScene")
      if (module.supportsTransition && module.$measurer.length)
        navigatedByHash = false
        module.$measurer.on "webkitTransitionEnd.ps2scene otransitionend.ps2scene oTransitionEnd.ps2scene transitionend.ps2scene", $.proxy(module._animateHovers, module)
        $(".pPS2_scene").one "webkitTransitionEnd otransitionend oTransitionEnd transitionend", () =>
          if not navigatedByHash
            navigatedByHash = true
            $(".pPS2_menu__item[data-hash=#{document.location.hash.replace /^#/, ''}]").click()
              

      # hovers
      $(".pPS2_scene__hover-link").on "mouseover.ps2scene", (evt) ->
        module._overLink evt, null, module, this
      $(".pPS2_scene__hover-link").on "mouseout.ps2scene", (evt) ->
        module._outLink evt, null, module, this
      

    _maybeInternalPageLoaded: ->
      $internalContent = $("#Planetside2Content")
      module = this
      if $internalContent.length
        if $internalContent.html() is ""
          unless module.internalScene is ""
            
            # нужно показать навигацию и показать элементы сцен, если они были спрятаны
            # убираем класс с айдишником внутренной сцены
            $(".pPS2_scene").removeClass "pPS2_scene_internal_" + module.internalScene
            
            # очищаем прежний айдишник внутренной сцены
            module.internalScene = ""
            
            # показываем ховеры
            module.activateSceneHovers module.currentScene
            
            # скрываем внутренную страницу
            $(".pPS2_internal").removeClass "pPS2_internal_state_visible"

            # показываем меню
            $(".pPS2_menu").removeClass "pPS2_menu_internal_active"
            
        else
          
          # нужно скрыть навигацию и элементы сцен, которые мешают
          # достаем айдишник внутренней сцены
          newScene = "scene_" + $internalContent.find(".pPS2_insidePage").eq(0).attr("data-scene")
          newInternalScene = $internalContent.find(".pPS2_insidePage").eq(0).attr("data-internal-scene")
          
          # если он отличается – используем, если нет - не делаем ничего
          unless module.internalScene is newInternalScene
            unless module.currentScene is newScene
              $(".pPS2_scene").removeClass("pPS2_scene_" + module.currentScene).addClass "pPS2_scene_" + newScene
              module.currentScene = newScene
              
              # апдейтим меню
              $(".pPS2_menu__item").removeClass("pPS2_menu__item_state_active").filter("[data-scene=" + newScene + "]").addClass "pPS2_menu__item_state_active"
            
            # удаляем старый модификатор внутренной сцены (если был)
            $(".pPS2_scene").removeClass "pPS2_scene_internal_" + module.internalScene  unless module.internalScene is ""
            
            # сохраняем новый айдишник внутренной сцены
            module.internalScene = newInternalScene
            
            # выставляем класс с новой внутренной сценой
            $(".pPS2_scene").addClass "pPS2_scene_internal_" + module.internalScene
            
            # убираем ховеры
            module.deactivateSceneHovers()
            
            # убираем меню
            $(".pPS2_menu").addClass "pPS2_menu_internal_active"
            
            # показываем внутренную страницу
            $(".pPS2_internal").addClass "pPS2_internal_state_visible"


    _menuClick: (evt, module, link) ->
      scene = $(link).attr("data-scene")
      unless $(link).hasClass("pPS2_menu__item_state_active")
        document.location.hash = $(link).data('hash') 

        # make menu item active
        $(".pPS2_menu__item").removeClass "pPS2_menu__item_state_active"
        $(link).addClass "pPS2_menu__item_state_active"
        
        # shitch scene objects
        fps.start "Переход между сценами"  if window.fps
        module.deactivateSceneHovers()
        $('.pPS2_')
        $(".pPS2_scene").removeClass("pPS2_scene_" + module.currentScene).addClass "pPS2_scene_" + scene
        $("#transition-measurer").removeClass("pPS2_scene__measurer_" + module.currentScene).addClass "pPS2_scene__measurer_" + scene
        module.currentScene = scene

        # activate scene hovers
        if (!module.supportsTransition)
          module._animateHovers()
          # activate scene hovers
          module.activateSceneHovers scene


    _menuPlus: ->
      $(".pPS2_menu__item_state_active").prev(".pPS2_menu__item").trigger "click"

    _menuMinus: ->
      $(".pPS2_menu__item_state_active").next(".pPS2_menu__item").trigger "click"


    deactivateSceneHovers: ->
      @isAnimationGoingOn = 1

      clearTimeout @hoversTimeout
      # deactivate all hover scenes
      $(".pPS2_scene__hover").removeClass "pPS2_scene__hover_state_active"


    activateSceneHovers: (scene, noAnimation) ->
      @deactivateSceneHovers()
      
      # activate new scene
      unless noAnimation
        # clear current hovers
        $(".pPS2_scene__hover-stroke").addClass "pPS2_scene__hover-stroke_state_hidden"
        @isAnimationGoingOn = 0

      $(".pPS2_scene__hover_#{scene}").addClass "pPS2_scene__hover_state_active"


    _animateHovers: ->
      fps.end "Переход между сценами"  if window.fps
      module = this
      module.activateSceneHovers @currentScene
      
      # get current scene
      measurerClass = module.$measurer[0].className
      $scene = $(".pPS2_scene__hover_" + measurerClass.substr(measurerClass.indexOf("measurer_") + 9))
      
      # turn the lights on in 1 second
      module.hoversTimeout = setTimeout () =>
        $scene.find(".pPS2_scene__hover-stroke").addClass "pPS2_scene__hover-stroke_state_glow"
        module.isAnimationGoingOn = 0
        setTimeout () ->
          $(".pPS2_scene__hover-stroke").removeClass "pPS2_scene__hover-stroke_state_glow"
        , 1550
      , 750


    _overLink: (evt, objectTargetClass, module, area) ->
      if !module.isAnimationGoingOn
        objectTargetClass = $(area).attr("data-scene-object-target")  if not objectTargetClass and area
        $(".pPS2_scene__hover-stroke." + objectTargetClass).removeClass "pPS2_scene__hover-stroke_state_hidden"


    _outLink: (evt, objectTargetClass, module, area) ->
      if !module.isAnimationGoingOn
        objectTargetClass = $(area).attr("data-scene-object-target")  if not objectTargetClass and area
        $(".pPS2_scene__hover-stroke." + objectTargetClass).addClass "pPS2_scene__hover-stroke_state_hidden"


    moduleEvents:
      "pageTransition:success": "_maybeInternalPageLoaded"
  }