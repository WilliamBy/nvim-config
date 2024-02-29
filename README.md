# 依赖环境
- `ripgrep` & `fd` for **Telescope** and its related plugins
- `python3` & `pip`
- `cmake` 及其对应os的构建工具链：Linux下是Make、gcc，Windows 下是 Microsoft C++ Build Tools
# lsp、formatter 等工具安装
- 默认情况下没有安装任何lsp、formatter，如果进入文件提示缺失某个lsp或者formatter缺失，去Mason界面主动安装即可
```
:Mason
```
# 插件更新与维护
- 插件版本锁在了 **json-lock.json** 文件中，无特殊需求不用更新插件
- 如果使用lazy对插件进行Update，需要注意配置有所更改，具体情况去要更新的插件官方仓库查明情况。
# 备注
- 如果使用过程中有插件报错，使用`:checkhealth <plugin>`检查对应插件的健康状况，按照输出结果安装缺失的依赖
