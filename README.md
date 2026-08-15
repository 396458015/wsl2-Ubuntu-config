# 安装软件

## 1.neovim  
安装步骤:  
sudo add-apt-repository ppa:neovim-ppa/stable  
sudo apt-get update  
sudo apt-get install neovim  

配置文件路径:  
- '~/.config/nvim/init.lua'  
- 注意:without plugin  

WSL2 中 Neovim 与 Windows 系统互通复制粘贴:  

```
curl -sLo/tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip
unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe
chmod +x /tmp/win32yank.exe
sudo mv /tmp/win32yank.exe /usr/local/bin/
```

在neovim的init.lua加入如下配置  

```lua
vim.o['clipboard'] = 'unnamedplus'
vim.g.clipboard = {
    name = 'win32yank',
    copy = {
        ['+'] = 'win32yank.exe -i --crlf',
        ['*'] = 'win32yank.exe -i --crlf',
    },
    paste = {
        ['+'] = 'win32yank.exe -o --lf',
        ['*'] = 'win32yank.exe -o --lf',
    },
    cache_enabled = 0,
}
```

## 2.starship  
配置文件路径:  
- '~/.config/starship.toml'  
- 在'~/.bashrc'文件中加入 'eval "$(starship init bash)"'  


## 3.lazygit  
配置文件路径:  
- '~/.config/lazygit/config.yml'  


## 4.fastfetch  
安装步骤:  
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch  
sudo apt update  
sudo apt install fastfetch  


## 5.texlive2024  

## 6.yazi  
安装步骤:  
```
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
sudo apt update && sudo apt install yazi
```


# Ubuntu 22.04 自带软件

## 1.tmux  
配置文件路径:  
- '~/.tmux.conf'  




