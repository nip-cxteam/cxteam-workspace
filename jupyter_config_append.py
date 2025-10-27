c.ServerProxy.servers = {
    'code': {
        'command': ['/usr/bin/code-server', '--auth', 'none', '--disable-telemetry', '--bind-addr', '0.0.0.0:{port}'],
        'timeout': 20,
        'launcher_entry': {'title': 'VS Code', 'icon_path': '/usr/local/share/assets/vscode.svg'}
    },
    # 'vscode': {
    #     'command': ['/usr/local/bin/code', 'serve-web', '--without-connection-token', '--accept-server-license-terms',
    #                 '--port={port}', '--host=0.0.0.0', '--server-base-path=/vscode/{base_url}'],
    #     'timeout': 20, "absolute_url": True,
    #     'launcher_entry': {'title': 'MS VSCode', 'icon_path': '/usr/local/share/assets/vscode.svg'}
    # },
    # 'rstudio': {
    #     'command': ['/usr/bin/rserver', '--auth-none', '1', '--www-address', '127.0.0.1', '--www-port', '{port}'],
    #     'timeout': 20, 'environment': {'USER':'jovyan'},
    #     'launcher_entry': {'title': 'RStudio', 'icon_path': '/usr/local/share/assets/Antu_rstudio.svg'}
    # },
    'gotty': {
        'command': ['/usr/local/bin/gotty', '-w', '--port', '{port}', 'byobu'],
        'environment': {'USER':'jovyan', 'TERM': 'xterm-256color'},
        'timeout': 20,
        'launcher_entry': {'title': 'GoTTY', 'icon_path': '/usr/local/share/assets/Byobu.svg'}
    }
}

# marimo edit --headless --no-token --host 0.0.0.0 --port 8080