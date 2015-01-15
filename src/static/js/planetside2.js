(function(){
    var scene = {
        el: {
            menuItems: $('.pPS2_menu__item'),
            scene: $('.pPS2_scene'),
            hoverLink: $('.pPS2_scene__hover-link')
        },
        data: {
            currentScene: 'scene_1'
        },
        init: function() {
            $(".pPS2_scene").removeClass("pPS2_scene__zeroScene");
            scene.bind();
        },
        bind: function() {
            scene.el.menuItems.on('click', scene.handle.menuItems);
            scene.el.hoverLink.on('mouseover', scene.handle.overLink);
            scene.el.hoverLink.on('mouseout', scene.handle.outLink);
        },
        handle: {
            menuItems: function() {
                var $this = $(this);
                if (!$this.hasClass("pPS2_menu__item_state_active")) {
                    var nextScene = $this.attr("data-scene");
                    document.location.hash = $this.data("hash");
                    $(".pPS2_menu__item").removeClass("pPS2_menu__item_state_active");
                    $this.addClass("pPS2_menu__item_state_active");
                    $(".pPS2_scene").removeClass("pPS2_scene_" + scene.data.currentScene).addClass("pPS2_scene_" + nextScene);
                    scene.data.currentScene = nextScene;
                    $(".pPS2_scene__hover").removeClass("pPS2_scene__hover_state_active");
                    $(".pPS2_scene__hover_" + nextScene).addClass("pPS2_scene__hover_state_active");
                }
            },
            overLink: function() {
                var targetClass = $(this).attr("data-scene-object-target")
                $(".pPS2_scene__hover-stroke." + targetClass).removeClass("pPS2_scene__hover-stroke_state_hidden")
            },
            outLink: function() {
                var targetClass = $(this).attr("data-scene-object-target")
                return $(".pPS2_scene__hover-stroke." + targetClass).addClass("pPS2_scene__hover-stroke_state_hidden")
            }
        }
    };
    $(function(){
        scene.init();
    });
})()