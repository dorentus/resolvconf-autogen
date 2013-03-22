正确使用方式
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

3. 执行命令 `launchctl load $HOME/Library/LaunchAgents/rox.dorentus.update_by_gw.plist`，这样每次用户登录时都会运行 `/usr/local/bin/gw-monitor /usr/local/etc/resolv.conf`

4. 构建 `dnsmasq-reloader`，安装到 `/usr/local/sbin/dnsmasq-reloader`

5. 创建文件 `/Library/LaunchDaemons/rox.dorentus.dnsmasq-reloader.plist`，内容如下：

   ```xml
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
    <plist version="1.0">
      <dict>
        <key>Label</key>
        <string>rox.dorentus.dnsmasq-reloader</string>
        <key>ProgramArguments</key>
        <array>
          <string>/usr/local/sbin/dnsmasq-reloader</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
      </dict>
    </plist>
   ```

6. 执行命令，`sudo launchctl load /Library/LaunchDaemons/rox.dorentus.dnsmasq-reloader.plist`，这样每次系统启动时都会以 root 权限运行 `/usr/local/sbin/dnsmasq-reloader`

7. 安装 dnsmasq（推荐使用 [homebrew](http://mxcl.github.com/homebrew/) 安装），配置 `resolv-file=/usr/local/etc/resolv.conf`

   > 这里有个完整的配置文件包：https://dl.dropbox.com/u/7231772/conf-dnsmasq.tar.bz2

8. 更改系统 DNS 为 `127.0.0.1`
