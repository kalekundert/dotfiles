if [ -e /etc/fedora-release -a $EUID -ne 0 ]; then
    sudo dnf install -y                                     \
        http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm          \
        http://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm    \
        "@Development Tools"                                \
        "@RPM Development Tools"                            \
        "@C Development Tools and Libraries"                \
        ack                                                 \
        acpi                                                \
        htop                                                \
        python3-devel                                       \
        python3-scipy                                       \
        python3-matplotlib                                  \
        python3-numpy                                       \
        python3-pandas                                      \
        python3-virtualenv                                  \
        qiv                                                 \
        sakura                                              \
        scrot                                               \
        vim-enhanced                                        \
        vim-X11                                             \
        xbacklight                                          \
        zsh                                                 \

fi
