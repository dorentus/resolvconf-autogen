正确<del>打开</del>使用方式
============

方法一：
-----

1. 构建 `resolvconf-autogen`，安装到 `/usr/local/bin/resolvconf-autogen`
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
          <string>/usr/local/bin/resolvconf-autogen</string>
          <string>/usr/local/etc/resolv.conf</string>
        </array>
        <key>RunAtLoad</key>
        <true/>
        <key>KeepAlive</key>
        <dict>
          <key>SuccessfulExit</key>
          <false/>
        </dict>
      </dict>
    </plist>
    ```

3. 执行命令 `launchctl load $HOME/Library/LaunchAgents/rox.dorentus.update_by_gw.plist`，这样每次系统启动时都会运行 `/usr/local/bin/resolvconf-autogen /usr/local/etc/resolv.conf`
4. 安装 dnsmasq（推荐使用 [homebrew](http://mxcl.github.com/homebrew/) 安装），配置 `resolv-file=/usr/local/etc/resolv.conf`
   > 这里有个完整的配置文件包：https://dl.dropbox.com/u/7231772/conf-dnsmasq.tar.bz2
5. 更改系统 DNS 为 `127.0.0.1`

方法二（需要 homebrew）
------
1. `brew tap dorentus/tap`
2. `brew install --HEAD dorentus/tap/resolvconf-autogen`
3. 按照 homebrew 输出的操作提示，将 plist 文件放到合适的位置，并使用 launchctl 加载它
4. 执行方案一的第四和第五步
