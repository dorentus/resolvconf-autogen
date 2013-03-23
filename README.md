正确<del>打开</del>使用方式
============

1. 构建 `gw-monitor`，安装到 `/usr/local/bin/gw-monitor`
2. 创建文件 `$HOME/Library/LaunchAgents/rox.dorentus.update_by_gw.plist`，内容如下：

    ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>rox.dorentus.update_by_gw</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/local/bin/gw-monitor</string>
          <string>/usr/local/etc/resolv.conf</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
    ```

3. 执行命令 `launchctl load $HOME/Library/LaunchAgents/rox.dorentus.update_by_gw.plist`，这样每次系统启动时都会运行 `/usr/local/bin/gw-monitor /usr/local/etc/resolv.conf`

4. 安装 dnsmasq（推荐使用 [homebrew](http://mxcl.github.com/homebrew/) 安装），配置 `resolv-file=/usr/local/etc/resolv.conf`

   > 这里有个完整的配置文件包：https://dl.dropbox.com/u/7231772/conf-dnsmasq.tar.bz2

5. 更改系统 DNS 为 `127.0.0.1`
