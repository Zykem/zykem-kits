
fx_version('cerulean')
games({ 'gta5' })

shared_script('');

server_scripts({

    '@oxmysql/lib/MySQL.lua',
    'config.lua',
    'server.lua'


});

client_scripts({

    'config.lua',
    'client.lua'

});


files({

    'ui/ui_config.js',
    'ui/index.html',
    'ui/style.css',
    'ui/script.js'

})

ui_page('ui/index.html')