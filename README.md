# WSL2 软件安装与升级

> 适用于 WSL2 + Ubuntu。  
> 主要用于记录常用软件的安装、配置和升级命令，方便以后直接复制使用。

---

# 1. WSL2

以下命令在 Windows PowerShell 中运行。

查看 WSL 状态：

```powershell
wsl --status
```

查看版本：

```powershell
wsl --version
```

手动更新 WSL：

```powershell
wsl --update
```

关闭 WSL：

```powershell
wsl --shutdown
```

---

# 2. Git

安装：

```bash
sudo apt update
sudo apt install git -y
```

查看版本：

```bash
git --version
```

升级：

```bash
sudo apt update
sudo apt install --only-upgrade git
```

---

# 3. Neovim

配置文件：

```text
~/.config/nvim/init.lua
```

无插件配置：

```text
~/.config/nvim-withoutPlugin-0.7.2/
```

## 3.1 安装最新版 Neovim

如果以前通过 apt 安装过 Neovim：

```bash
nvim --version
which nvim

sudo apt remove --purge neovim -y
sudo apt autoremove -y
```

下载安装最新版（升级 Neovim 也用下面的命令）：

```bash
cd /tmp

wget https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64

sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -sfn /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

rm -f nvim-linux-x86_64.tar.gz

hash -r

nvim --version
```

检查当前版本和最新版：


```bash
echo "当前版本: $(nvim --version | head -n 1)"
echo "最新版本: v$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "v\K[^"]+')"
```

---

## 3.2 Neovim 基础编译依赖

部分插件需要本地编译环境：

```bash
sudo apt update

sudo apt install build-essential -y
```

安装 Clang 和 libclang：

```bash
sudo apt update

sudo apt install clang -y
sudo apt install libclang-dev -y
```

---

## 3.3 Neovim 与 Windows 剪贴板

安装 `win32yank`：

```bash
curl -sLo /tmp/win32yank.zip https://github.com/equalsraf/win32yank/releases/download/v0.1.1/win32yank-x64.zip

unzip -p /tmp/win32yank.zip win32yank.exe > /tmp/win32yank.exe

chmod +x /tmp/win32yank.exe

sudo mv /tmp/win32yank.exe /usr/local/bin/
```

在 `~/.config/nvim/init.lua` 中加入：

```lua
vim.o.clipboard = 'unnamedplus'

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

检查：

```bash
which win32yank.exe
```

---

## 3.4 LeaderF 等插件依赖

LeaderF 及部分搜索、跳转插件需要 Python 开发环境、ripgrep 和 ctags：

```bash
sudo apt update

sudo apt install python3-dev -y
sudo apt install ripgrep -y
sudo apt install universal-ctags -y
```

---

## 3.5 Neovim Python provider

部分 Neovim Python 插件需要 Python provider：

```bash
sudo apt update

sudo apt install python3-pynvim -y
```

检查：

```vim
:checkhealth provider
```

---

## 3.6 Tree-sitter CLI

部分 Neovim Tree-sitter 功能或插件需要 `tree-sitter-cli`。

先安装 Rust / Cargo，见第 4 节。

安装：

```bash
cargo install tree-sitter-cli
```

检查：

```bash
tree-sitter --version
which tree-sitter
```

升级：

```bash
cargo install tree-sitter-cli --force
```

---

## 3.7 Mason / LSP 的 Node.js 与 npm 依赖

Mason 安装部分基于 Node.js 的 LSP，例如 `pyright`，需要 Node.js 和 npm。

推荐使用 `nvm` 安装和管理 Node.js。

### 3.7.1 安装 nvm


如需安装更新版本，请先查看 nvm 最新 Release。

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

重新加载：

```bash
source ~/.bashrc
```

如果当前终端找不到 `nvm`，将下面代码加入 `~/.bashrc`：

```bash
export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
```

### 3.7.2 安装 Node.js LTS

```bash
nvm install --lts

nvm use --lts

nvm alias default 'lts/*'
```

检查：

```bash
node -v
npm -v
which node
```

### 3.7.3 升级 Node.js

```bash
nvm install --lts

nvm use --lts

nvm alias default 'lts/*'
```

---

## 3.8 Neovim 插件检查

更新 Lazy 管理的插件：

```vim
:Lazy update
```

LSP 管理：

```vim
:Mason
```

检查整体环境：

```vim
:checkhealth
```

---

# 4. Rust / Cargo

## 4.1 安装 Rust

```bash
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
```

在 `~/.bashrc` 中加入：

```bash
# cargo
. "$HOME/.cargo/env"
export PATH="$HOME/.cargo/bin:$PATH"
```

重新加载：

```bash
source ~/.bashrc
```

检查：

```bash
rustc --version
cargo --version
```

## 4.2 升级 Rust

```bash
rustup update
```

---

# 5. Typst

## 5.1 安装

```bash
cargo install --locked typst-cli
```

检查：

```bash
typst --version
which typst
```

## 5.2 升级

```bash
cargo install --locked typst-cli --force
```

---

# 6. Python

安装 pip：

```bash
sudo apt update

sudo apt install python3-pip -y
```

安装虚拟环境支持：

```bash
sudo apt install python3-venv -y
```

Matplotlib 图形弹窗需要：

```bash
sudo apt install python3-tk -y
```

安装常用 Python 库：

```bash
pip3 install numpy

pip3 install matplotlib

pip3 install scipy

pip3 install pandas
```

检查：

```bash
python3 --version
pip3 --version
```

---

# 7. Starship

配置文件：

```text
~/.config/starship.toml
```

## 7.1 安装

```bash
curl -sS https://starship.rs/install.sh | sh
```

在 `~/.bashrc` 中加入：

```bash
eval "$(starship init bash)"
```

重新加载：

```bash
source ~/.bashrc
```

检查：

```bash
starship --version
```

## 7.2 升级

```bash
curl -sS https://starship.rs/install.sh | sh
```

---

# 8. Lazygit

配置文件：

```text
~/.config/lazygit/config.yml
```

## 8.1 安装

```bash
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]+')
```

```bash
curl -Lo /tmp/lazygit.tar.gz \
"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
```

```bash
tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit
```

```bash
sudo install /tmp/lazygit /usr/local/bin/lazygit
```

```bash
rm -f /tmp/lazygit.tar.gz
rm -f /tmp/lazygit
```

检查：

```bash
lazygit --version
which lazygit
```

## 8.2 升级


升级时重新执行安装的全部命令即可。


---

# 9. Yazi

配置目录：

```text
~/.config/yazi/
```

## 9.1 安装

```bash
curl -fsSL https://yazi-rs.github.io/builds/yazi-keyring.gpg | sudo tee /usr/share/keyrings/yazi-keyring.gpg >/dev/null
```

```bash
echo 'deb [signed-by=/usr/share/keyrings/yazi-keyring.gpg] https://yazi-rs.github.io/builds/ stable main' | sudo tee /etc/apt/sources.list.d/yazi.list >/dev/null
```

```bash
sudo apt update

sudo apt install yazi -y
```

检查：

```bash
yazi --version
```

Alt+F 打开 Yazi：

```bash
bind -x '"\ef": y'
```

如果需要永久生效，将上面的命令加入：

```text
~/.bashrc
```

## 9.2 升级

```bash
sudo apt update

sudo apt install --only-upgrade yazi
```

---

# 10. Fastfetch

## 10.1 安装

```bash
sudo add-apt-repository ppa:zhangsongcui3371/fastfetch
```

```bash
sudo apt update

sudo apt install fastfetch -y
```

检查：

```bash
fastfetch --version
```

## 10.2 升级

```bash
sudo apt update

sudo apt install --only-upgrade fastfetch
```

---

# 11. tmux

配置文件：

```text
~/.tmux.conf
```

## 11.1 安装

```bash
sudo apt update

sudo apt install tmux -y
```

检查：

```bash
tmux -V
```

## 11.2 升级

```bash
sudo apt update

sudo apt install --only-upgrade tmux
```

---

# 12. TeX Live

当前使用：

```text
TeX Live 2024
```

检查：

```bash
xelatex --version
```

```bash
latexmk -v
```

---

# 13. 常用配置文件

```text
~/.bashrc

~/.tmux.conf

~/.config/starship.toml

~/.config/lazygit/config.yml

~/.config/yazi/

~/.config/nvim/init.lua
```

---

# 14. 常用升级命令

Ubuntu 软件：

```bash
sudo apt update

sudo apt upgrade
```

Git 升级：

```bash
sudo apt update

sudo apt install --only-upgrade git
```

Neovim 升级：

1 检查 Neovim 版本是否更新：

```bash
echo "当前版本: $(nvim --version | head -n 1)"
echo "最新版本: v$(curl -s https://api.github.com/repos/neovim/neovim/releases/latest | grep -Po '"tag_name": "v\K[^"]+')"

```

2 更新 Neovim 版本（无需卸载）:

```bash
cd /tmp

wget -O nvim-linux-x86_64.tar.gz \
https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz

sudo rm -rf /opt/nvim-linux-x86_64

sudo tar -C /opt -xzf nvim-linux-x86_64.tar.gz

sudo ln -sfn /opt/nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim

rm -f nvim-linux-x86_64.tar.gz

hash -r

nvim --version
```

Lazygit 升级：

```bash
LAZYGIT_VERSION=$(curl -s https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "v\K[^"]+')

curl -Lo /tmp/lazygit.tar.gz \
"https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"

tar -xzf /tmp/lazygit.tar.gz -C /tmp lazygit

sudo install /tmp/lazygit /usr/local/bin/lazygit

rm -f /tmp/lazygit.tar.gz
rm -f /tmp/lazygit

lazygit --version
```

Yazi 升级：

```bash
sudo apt update

sudo apt install --only-upgrade yazi
```

Fastfetch 升级：

```bash
sudo apt update

sudo apt install --only-upgrade fastfetch
```

tmux 升级：

```bash
sudo apt update

sudo apt install --only-upgrade tmux
```

Rust 升级：

```bash
rustup update
```

Tree-sitter 升级：

```bash
cargo install tree-sitter-cli --force
```

Typst 升级：

```bash
cargo install --locked typst-cli --force
```

Node.js 升级：

```bash
nvm install --lts

nvm use --lts

nvm alias default 'lts/*'
```

Starship 升级：

```bash
curl -sS https://starship.rs/install.sh | sh
```


