
$(function() {

    function display(bool) {
        if (bool == true) {
            
            $("#body").show();
            $("#container").show();
            
            
        } else {
            
            $("#body").hide();
            $("#container").hide();     

        }
    }
    display(false);
    zykem_InitElements();

    $("#claim-1").click(function() {

        $.post('https://zykem-kits/exit', JSON.stringify({}));
        $.post('https://zykem-kits/basickit')

    })
    $("#claim-2").click(function() {

        $.post('https://zykem-kits/exit', JSON.stringify({}));
        $.post('https://zykem-kits/ironkit')

    })
    $("#claim-3").click(function() {

        $.post('https://zykem-kits/exit', JSON.stringify({}));
        $.post('https://zykem-kits/goldkit')

    })
    $("#claim-4").click(function() {

        $.post('https://zykem-kits/exit', JSON.stringify({}));
        $.post('https://zykem-kits/diamondkit')

    })

         // if the person uses the escape key, it will exit the resource
         document.onkeyup = function (data) {
            if (data.which == 27) {
                $.post('https://zykem-kits/exit', JSON.stringify({}));
                return
            }
        };


    function zykem_InitElements() {

        $("#serverlogo").attr('src', cfg.serverLogo)
        $("#basicTitle").text(cfg.basicTitle)
        $("#ironTitle").text(cfg.ironTitle)
        $("#goldTitle").text(cfg.goldTitle)
        $("#diamondTitle").text(cfg.diamondTitle)
        $("#basicDesc").text(cfg.basicDesc)
        $("#ironDesc").text(cfg.ironDesc)
        $("#goldDesc").text(cfg.goldDesc)
        $("#diamondDesc").text(cfg.diamondDesc)
        $("#basicImg").attr('src', cfg.basicImg)
        $("#ironImg").attr('src', cfg.ironImg)
        $("#goldImg").attr('src', cfg.goldImg)
        $("#diamondImg").attr('src', cfg.diamondImg)
        console.log('Attached elements!')


    }
    window.addEventListener('message', function(e) {

        var data = e.data;
        if(data.type == "ui") {

            if(data.status == true) {

                display(true)

            } else {
    
                display(false)
    
            }
    
        }


    })
})