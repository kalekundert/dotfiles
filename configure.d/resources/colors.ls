# Configuration file for the color ls utility
# Synchronized with coreutils 8.5 dircolors
# This file goes in the /etc directory, and must be world readable.
# You can copy this file to .dir_colors in your $HOME directory to override
# the system defaults.

# COLOR needs one of these arguments: 'tty' colorizes output to ttys, but not
# pipes. 'all' adds color characters to all output. 'none' shuts colorization
# off.
COLOR tty

# Extra command line options for ls go here.
# Basically these ones are:
#  -F = show '/' for dirs, '*' for executables, etc.
#  -T 0 = don't trust tab spacing when formatting ls output.
OPTIONS -F -T 0

# Below, there should be one TERM entry for each termtype that is colorizable
TERM Eterm
TERM ansi
TERM color-xterm
TERM con132x25
TERM con132x30
TERM con132x43
TERM con132x60
TERM con80x25
TERM con80x28
TERM con80x30
TERM con80x43
TERM con80x50
TERM con80x60
TERM cons25
TERM console
TERM cygwin
TERM dtterm
TERM eterm-color
TERM gnome
TERM gnome-256color
TERM jfbterm
TERM konsole
TERM kterm
TERM linux
TERM linux-c
TERM mach-color
TERM mlterm
TERM putty
TERM rxvt
TERM rxvt-256color
TERM rxvt-cygwin
TERM rxvt-cygwin-native
TERM rxvt-unicode
TERM rxvt-unicode-256color
TERM rxvt-unicode256
TERM screen
TERM screen-256color
TERM screen-256color-bce
TERM screen-bce
TERM screen-w
TERM screen.rxvt
TERM screen.linux
TERM terminator
TERM vt100
TERM xterm
TERM xterm-16color
TERM xterm-256color
TERM xterm-88color
TERM xterm-color
TERM xterm-debian

# EIGHTBIT, followed by '1' for on, '0' for off. (8-bit output)
EIGHTBIT 1

# Below are the color init strings for the basic file types. A color init
# string consists of one or more of the following numeric codes:
#
# Attribute codes:
#   00=none 01=bold 04=underscore 05=blink 07=reverse 08=concealed
# Text color codes:
#   30=black 31=red 32=green 33=yellow 34=blue 35=magenta 36=cyan 37=white
# Background color codes:
#   40=black 41=red 42=green 43=yellow 44=blue 45=magenta 46=cyan 47=white

NORMAL 00       # no color code at all
FILE 00         # normal file, use no color at all
RESET 00        # reset to "normal" color
DIR 00;34       # directory
LINK 00;36      # symbolic link
FIFO 00;35      # pipe
SOCK 00;35      # socket
DOOR 00;35      # door
BLK 00;35       # block device driver
CHR 00;35       # character device driver
ORPHAN 00;31    # symlink to nonexistent file, or non-stat'able file
MISSING 00;31   # ... and the files they point to
SETUID 00;35    # file that is setuid (u+s)
SETGID 00;35    # file that is setgid (g+s)
STICKY 00;35    # dir with the sticky bit set (+t) and not other-writable
CAPABILITY 00;35    # file with capability
MULTIHARDLINK 00;36        # regular file with more than one link
OTHER_WRITABLE 00;34    # dir that is other-writable (o+w) and not sticky
STICKY_OTHER_WRITABLE 00;35 # dir that is sticky and other-writable (+t,o+w)

# This is for files with execute permission:
EXEC 00;32

