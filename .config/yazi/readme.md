## yazi
     配置路径 'C:\Users\ThinkPad\AppData\Roaming\yazi\config'  
     11.1. Download Git from https://git-scm.com/download/win.  
     11.2. Append C:\Program Files\Git\usr\bin to the PATH environment variable, note that depends on your Git installation path.  
     例如将D:\Program Files\Git\usr\bin加入到环境变量，同时加入到'用户变量'和'系统变量'的path  
     11.3. scoop install yazi  
     11.4 for zip/rar preview  
        scoop install unar  
        scoop install ouch  
     11.5 for JSON preview  
        scoop install jq  
     11.6 for pdf preview  
        scoop install poppler  
        注意: Windows仅wezterm支持图片和pdf的预览,pdf预览是通过poppler里面的pdftoppm;  
              系统如果安装texlive会使texlive中的pdftoppm成为系统默认,导致yazi中pdf不能预览;  
              查询pdftoppm路径,在PS中'which pdftoppm';  
              解决办法:在系统变量PATH中,将poppler的路径放置在texlive前面.  
                       即:C:\Users\ThinkPad\scoop\apps\poppler\23.11.0-0\bin  
                          D:\Program Files\texlive\2023\bin\windows  
              修改后'which pdftoppm'结果为'C:\Users\ThinkPad\scoop\apps\poppler\23.11.0-0\bin\pdftoppm.exe', 且不影响texlive的预览.  
     11.7 search file name  
        scoop install fd  
     11.8 search file content  
        scoop install ripgrep  
     11.9 fuzzy search file  
        scoop install fzf  
     - 配置文件路径  
     'C:\Users\ThinkPad\AppData\Roaming\yazi\config'  
     - 自动代码预览，无需安装bat;wezterm自动图片预览  
     - 若要通过mpv播放视频,需要将mpv的安装路径增加到环境变量中的'用户变量'  
       如D:\Program Files\mpv-x86_64-20220424-git-9d133eb加入到'用户变量'  
     - 主题颜色配置  
       Yazi根据终端颜色判断使用dark配色或light配色  

# 注意
  1. yazi预览代码的高亮渲染配置  
     1.1 yazi预览代码是通过bat工具完成的，通过flavor.toml中的syntect_theme设置。  
-        'syntect_theme = "C:/Users/ThinkPad/AppData/Roaming/yazi/config/bat-themes/Catppuccin Frappe.tmTheme"'  
     上面这样设置，只有在theme.toml中设置后生效，而通过flavor.toml设置syntect_theme则不生效.  
     1.2 但如果将bat高亮主题文件*.tmTheme修改为tmTheme.xml，将tmTheme.xml文件放到\yazi\config\flavors\catppuccin-frappe.yazi\文件夹中，此时不用设置flavor.toml中的syntect_theme也会生效。这样设置bat高亮主题更加优雅了，bat高亮主题和yazi主题放到一起，只修改theme.toml中的'[flavor] use即可'。  
bat的catppuccin主题链接'https://github.com/catppuccin/bat'  


## 快捷键

- a XX    创建XX文件  
- a XX/   创建XX文件夹  

---
- y    copy  
- d    cut  
- x    delete to 回收站  
- X    永久删除  
- r    rename  
       可以通过多选后，r重命名，批量化修改名字  

---
- g XX         移动到已存dir  
- g <space>    目录跳转  

---
- cd       copy parent directory  
- <C-b>    预览上移动  
- <C-f>    预览下移动  

---
- S  rg搜索文件内容  
- s  fd搜索文件名  
- Z  fzf模糊搜索  

---
- o        打开  
- Enter    打开  
- O        选择打开方式  

---
- ca         压缩文件  
- O选择选项  解压文件  


