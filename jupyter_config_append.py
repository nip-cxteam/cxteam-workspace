c.ServerProxy.servers = {
    'code': {
        'command': ['/usr/local/code-server/bin/code-server', '--auth', 'none', '--disable-telemetry', '--bind-addr', '0.0.0.0:{port}'],
        'timeout': 20,
        'launcher_entry': {'title': 'VS Code', 'icon_path': '/usr/local/share/assets/vscode.svg'}
    },
    'rstudio': {
        'command': ['/usr/lib/rstudio-server/bin/rserver', '--auth-none', '1', '--www-address', '127.0.0.1', '--www-port', '{port}'],
        'timeout': 20, 'environment': {'USER':'jovyan'},
        'launcher_entry': {'title': 'RStudio', 'icon_path': '/usr/local/share/assets/Antu_rstudio.svg'}
    },
    'gotty': {
        'command': ['/usr/local/bin/gotty', '-w', '--port', '{port}', 'tmux new-session -A -s main'],
        'environment': {'USER':'jovyan', 'TERM': 'xterm'},
        'timeout': 20,
        'launcher_entry': {'title': '', 'icon_path': '/usr/local/share/assets/Byobu.svg'}
    }
}