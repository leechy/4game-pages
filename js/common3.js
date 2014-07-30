$( document ).ready(function() {

    /* --------------- [ Start ]  ---------- */


    $(window).on('load', function(){
        $('.bPlanets').delay(400).fadeIn(300).addClass('start');
    });


    // preloader imgs
    $.preload_imgs = function(urls, callback){
        var need = urls.length;
        function ff(){
            need--;
            if (!need && _.isFunction(callback))
                callback(urls)
        }
        _(urls).each(function(url){
            $.preload_img(url, ff)
        });
    };


    $('.ePlanet').on('mouseenter', function(){
        if( $('.bPlanets').hasClass('opened') == false ){
            $('.bPlanets').addClass('pause');
            if( $(this).hasClass('eClasses') ){
                $('.bPersonages').addClass('ehoverEffect');
            }else if( $(this).hasClass('eAlchemy') ){
                $('.bAlchemy__Hover').addClass('start');
            }else if( $(this).hasClass('eVideo') ){
                $('.ePersonage1').addClass('ehoverEffect');
            }else if( $(this).hasClass('eLocation') ){
                $('#main-content').addClass('ehoverEffect');
            }
        }
    });
    $('.ePlanet').on('mouseleave', function(){
       $('.bPlanets').removeClass('pause');
        $('#main-content').removeClass('ehoverEffect');
        $('.bPersonages').removeClass('ehoverEffect');
        $('.ePersonage1').removeClass('ehoverEffect');
        $('.bAlchemy__Hover').removeClass('start');
    });



    /* --------------- [ Modal Window ]  ---------- */

    // --- Main Setup

    // close
    $('.eCloseModalDialog').on('click', function(){
        $('.bOverlay').fadeOut(400);
        $('.bPlanets').removeClass('opened').appendTo('#main-content').css({ position : '', top : '', left : '' });
        $('.bModalDialog__Container').hide(0);
        $('.bGlow__eRayCrop').hide(0);
        $('.bModalDialog .bContentField > div').hide(0);
        $('.bPlanets a').removeClass('active');
        $('.bModalDialog .eVideo .bTabField img.active').removeClass('active');
        $('body').removeClass('overflow-hidden');
    });
    // open
    $('.bPlanets a').on('click', function(){
        var activePlanet__Index = $(this).index();
        if( $('.bPlanets').hasClass('opened') ){
            if( $(this).hasClass('active') === false ){
                $(this).addClass('active');
                $(this).addClass('active').siblings().removeClass('active');
                $('.bModalDialog .bContentField > div').stop(true, true).hide(0).eq( activePlanet__Index).fadeIn(500);
                if( $(this).hasClass('eVideo') ){
                    $('.bModalDialog .eVideo .bTabField img:eq(0)').click();
                }else{
                    $('.bModalDialog .eVideo .bTabField img.active').removeClass('active');
                }
            }
        }else{
            $('.bOverlay').show(0, function(){
                $('.bModalDialog__Container').delay(1300).fadeIn(400, function(){
                    $('.bModalDialog .bContentField > div').eq( activePlanet__Index).fadeIn(300);
                });
                $('.bGlow__eRayCrop').delay(1600).fadeIn(400);
            });

        }
        $(this).addClass('active');
    });

    // --- Inner

    // Location
    $('.bModalDialog .eLocation .bTabField img').on('click', function(){
        if( $(this).hasClass('active') == false ){
            var srcBigPick = $(this).attr('data-bigPick');
            $('.bBigContainerPick img').attr({ src : srcBigPick });
            $(this).addClass('active').siblings().removeClass('active');
        }else{

        }
    });
    // Video
    $('.bModalDialog .eVideo .bTabField img').on('click', function(){
        if( $(this).hasClass('active') == false ){
            var srcBigVideo = $(this).attr('data-bigVideo');
            $('.bBigContainerVideo iframe').attr({ src : srcBigVideo });
            $(this).addClass('active').siblings().removeClass('active');
        }else{

        }
    });



    $('.bPlanets')
        .on('mouseover', function() {
            $(this).find('.ePlanet').each(function() {
                var transformPlanet = $(this).css('transform');
                $(this).css('transform', transformPlanet);
            })
        .on('mouseout',function(){
                //$('.ePlanet').css({ animation: 'orbit 20s linear infinite' })
            });
    });
    $('.ePlanet').on('click', function(){
        $('.ePlanet').css('animation', 'none');
        setTimeout(function(){
            if( $('.bPlanets').hasClass('opened') == false ){
                $('.bPlanets').addClass('opened');
            }
        }, 100);
        setTimeout(function(){
            $('.bPlanets').addClass('bg-active-show');
        }, 1500);
    });

    $('.eCloseModalDialog').on('click', function(){
        $('.ePlanet').css({ animation: 'orbit 20s linear infinite' });
        $('.bPlanets').removeClass('bg-active-show');
    });



});