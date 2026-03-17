# <p align="center"> Violet-dots
My goal was to use a single color scheme for the entire system.</p>
---
<p align="center">
  <img src="./assets/screenshot1.png" width="49%">
  <img src="./assets/screenshot2.png" width="49%">
  <img src="./assets/screenshot3.png" width="49%">
  <img src="./assets/screenshot4.png" width="49%">
</p>

---
🛠️ **Tech Stack:**

🪟 **Compositor:** [Niri](https://github.com/YaLTeR/niri),

🐚 **Shell:** [Zsh](https://www.zsh.org/),

📂 **File Manager:** [Yazi](https://github.com/sxyazi/yazi) & [Dolphin](https://apps.kde.org/dolphin/),

🔡 **Font:** [FiraCode](https://github.com/tonsky/FiraCode?tab=readme-ov-file),

💻 **Terminal:** [Kitty](https://sw.kovidgoyal.net/kitty/),

📊 **Bar:** [Waybar](https://github.com/Alexays/Waybar),

🚀 **Application Launcher:** [Rofi](https://github.com/davatorium/rofi).

---
🚀 **Install**

Save your current configs

```bash
sudo cp -r /etc/nixos/ ~/nixos.back
```

Clone this repository

```bash
cd ~/ && git clone https://github.com/LordDioBrande/violet-dots/
```

Install my dots

```bash
sudo rm -rf /etc/nixos/* && sudo cp -r ~/violet-dots/nixos/* /etc/nixos/
```

Apply current settings

```bash
sudo nixos-rebuild switch && nix flake update && sudo nixos-rebuild switch
```

---

Contact me

[![Telegram](https://img.shields.io/badge/Telegram-2CA5E0?style=for-the-badge&logo=telegram&logoColor=white)](https://t.me/bopsifox)   [![Gmail](https://img.shields.io/badge/Gmail-D14836?style=for-the-badge&logo=gmail&logoColor=white)](mailto:kazukiobsidian@gmail.com)
