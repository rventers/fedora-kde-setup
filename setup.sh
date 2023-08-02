#!/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin
HEIGHT=20
WIDTH=80
CHOICE_HEIGHT=4
BACKTITLE="Fedora Setup Util - By Osiris - https://lsass.co.uk"
TITLE="Please Make a selection"
MENU="Please Choose one of the following options:"

#Other variables
OHMZ_URL="https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh"
P10K_URL="https://github.com/romkatv/powerlevel10k.git"

#Check to see if Dialog is installed, if not install it - Thanks Kinkz_nl
if [ $(rpm -q dialog 2>/dev/null | grep -c "is not installed") -eq 1 ]; then
    sudo dnf install -y dialog
fi

OPTIONS=(
    1 "Speed up DNF - This enables fastestmirror, max downloads and deltarpms"
    2 "Remove Software - Removes packages that are not needed or used"
    3 "Update System - Checks for and installs available package updates"
    4 "Install Software - Installs a bunch of my most used software"
    5 "Install Flathub - Enables the Flathub Flatpak repo and installs packages"
    6 "Install Oh-My-ZSH"
    7 "Install powerlevel10k (requires ZSH)"
    8 "Quit"
)

while [ "$CHOICE -ne 4" ]; do
    CHOICE=$(dialog --clear \
        --backtitle "$BACKTITLE" \
        --title "$TITLE" \
        --nocancel \
        --menu "$MENU" \
        $HEIGHT $WIDTH $CHOICE_HEIGHT \
        "${OPTIONS[@]}" \
        2>&1 >/dev/tty)

    clear
    case $CHOICE in
        1)  echo "Speeding Up DNF"
            echo 'fastestmirror=1' | sudo tee -a /etc/dnf/dnf.conf
            echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
            echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
            kdialog --passivepopup "Your DNF config has been amended" 5
            ;;
        2)  echo "Removing Software"
            sudo dnf erase -y $(cat dnf-erase.txt)
            kdialog --passivepopup "Software has been removed" 5
            ;;
        3)  echo "Updating System"
            sudo dnf upgrade --refresh -y
            kdialog --passivepopup "System packages have been updated" 5
            ;;
        4)  echo "Installing Software"
            sudo dnf install -y $(cat dnf-install.txt)
            kdialog --passivepopup "System has been updated" 5
            ;;
        5)  echo "Installing Flathub"
            flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
            flatpak update
            flatpak install -y $(cat flatpak-install.txt)
            kdialog --passivepopup "Flatpak has now been enabled" 5
            ;;
        6)  echo "Installing Oh-My-Zsh"
            sudo dnf -y install zsh util-linux-user
            sh -c "$(curl -fsSL $OHMZ_URL)"
            kdialog --passivepopup "Oh-My-Zsh has been installed" 5
            ;;
        7)  echo "Installing powerlevel10k"
            git clone --depth=1 $P10K_URL ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
            sed -i 's@^ZSH_THEME=.*@ZSH_THEME="powerlevel10k/powerlevel10k"@g' ~/.zshrc
            kdialog --passivepopup "powerlevel10k has been installed" 5
            ;;
        8)  exit 0
            ;;
    esac
done
