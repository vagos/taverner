# taverner

![taverner](taverner.png)

## INTRODUCTION

Taverner is a shell script designed
to generate and maintain a bunch of game launchers (or anything else
really). You can use it together with dmenu and have it 
launch your apps.

## REQUIRES

- bash 4.2+

## INSTALL

* Source

```bash
$ git clone https://github.com/vagos/taverner
$ cd taverner && sudo make DESTDIR="/usr/bin/" install
```

* Arch Linux

taverner is on the aur as [taverner-git](https://aur.archlinux.org/packages/taverner-git)

```bash
# Install using yay
yay -S taverner-git
```

## CONFIG

Configuration is placed in ```XDG_CONFIG_HOME/taverner``` or 
in ```$HOME/.config/taverner``` edit the file ```menu``` to 
set the command for your preferred launch menu. 

We recommend [dmenu](https://github.com/stilvoid/dmenu).

## USAGE

Briefly, a typical session may look like this

```bash
$ taverner -h
Usage: taverner [-h] [mk | ls | ed | rm]
    Each mode has an -h flag which produces a summary of its help section.

    -e      Preferred editor, uses $EDITOR if not set.

Create a new menu entry.  Uses $EDITOR to complete the new entry.

    mk [-c <cover>] -t <template> <entry>
        -t      Select a template to base the new entry on.
        -c      Path or url to a cover image.  (Note: This is destructive)
        entry   The name for the new launcher script.

List entries and templates.
    ls [-t]
        -t      List all available templates.

        If no arguments given this will list all entries.

Edit the selected entry or template.  Only one entry may be edited per
invocation.

    ed [-t <template>] [-c <cover>] [entry]
        -t      Attempts to open the template with $EDITOR.
        -c      Replace the cover for entry, note that the entry is required
                for this operation.
        entry   Attempts to open the entry with $EDITOR.

    Issue: If -c is specified for an entry, it will both update the entries
           cover image but also offer to edit the entry as well.

Remove selected entries and corresponding covers.  If no argument given,
attempt to remove all entires.

    rm [entry [entry]]
        entry   The chosen entry to remove.

Examples:
    # Creates an entry using the psx template called wipeout_3 using emacs
    # as the editor.
    taverner mk -e emacs -t psx wipeout_3

    # Removes both wipeout_3 and crash_bandicoot launchers along with any
    # cover images if found.
    taverner rm wipeout_3 crash_bandicoot

$ taverner ls -t
ppsspp
wine

$ taverner mk wipeout_pulse -t ppsspp -c ~/wipeout_pulse_cover.jpg
‘/home/earnest/wipeout_pure_cover.jpg’ -> ‘/home/earnest/local/data/taverner/covers/wipeout_pure’
‘/home/earnest/local/data/taverner/templates/ppsspp’ -> ‘/home/earnest/local/data/taverner/bin/wipeout_pure’
```

At this point you'll get prompted with your editor to make any changes
to the template such as specifying what to execute, and where the data
files are located. Here is an example template with places left for you
to fill in:

```bash
#!/bin/bash
# Title: Wipeout Pure (PSP 2005)

ppsspp --fullscreen "$LOCALDIR"/data/games/psp/wipeout_pure.iso
```

Here the title is read and passed to dmenu, if "# Title:" isn't present,
taverner will fallback on the file name of the launch script.

After editing the template, run taverner.

Obviously, you can just add whatever files you want in the __taverner/bin__
folder without using any of the __taverner ...__ commands. 

### Automatically load games

Available are also some scripts to automatically add the necessary __taverner/bin__ files
from a specific platform. You can find them in the
[util](https://github.com/vagos/taverner/tree/master/util) folder in this repo.

Platforms Supported:

* Steam
