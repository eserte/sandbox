# README

BBBike - a route-finder for cyclists in Berlin and Brandenburg

# PREBUILT PACKAGES

You can check on [http://sourceforge.bbbike.de/downloads.en.html](http://sourceforge.bbbike.de/downloads.en.html) for prebuilt BBBike
packages (Windows, some Linux distributions, MacOSX, FreeBSD).

The following installation steps are necessary only for installing
BBBike from source.

# INSTALLATION FROM SOURCE

## All systems except Windows

### Download

You can find the newest source distribution file of BBBike in the directory
[http://sourceforge.net/projects/bbbike/files/BBBike/](http://sourceforge.net/projects/bbbike/files/BBBike/) . The current source version is
[http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18.tar.gz/download](http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18.tar.gz/download) .

### FreeBSD

For FreeBSD there is a _port_ for BBBike in the
category **german**. For older versions of FreeBSD, you can find the
_port_ at [http://www.freebsd.org/cgi/ports.cgi?query=bbbike&stype=all](http://www.freebsd.org/cgi/ports.cgi?query=bbbike&stype=all).
To install the application via the ports system type:

        cd /usr/ports/german/BBBike
        make all install

If you don't have the BBBike _port_, you can install BBBike like [in other
UNIX's](#linux-solaris-other-unix-operating-systems).

### Linux, Solaris, other UNIX operating systems

First, you have to install perl. Most operating systems have perl
already bundled. You can check with

        perl -v

whether and which version of perl is installed. Otherwise you can find
perl at [http://www.perl.org/get.html](http://www.perl.org/get.html). All perl versions starting from
5.8.9 are supported, maybe it works even with older perls (down to
5.005).

Next step is to extract the BBBike distribution:

        zcat BBBike-3.18.tar.gz | tar xfv -

If perl/Tk (the recommended version is the latest one, currently 804.034) is not installed:
type as super user:

        cd BBBike-3.18
        perl -I`pwd` -MCPAN -e shell
        force install Bundle::BBBike_small
        quit

Perl/Tk will be fetched over the internet, get compiled
and installed. "force" is needed because some modules (especially Tk)
have expected test failures and therefore would not be installed. If
you have problems, especially with the internet 
connection, then you should follow the instructions in

        perldoc perlmodinstall

on how to install a perl module manually (in this case: the Tk
module).

After that, you can start the program with

        perl bbbike

To compile some XS modules (this is optional and needs a C compiler)
and install the panel entry for KDE/GNOME, type:

        perl install.pl

or

        ./install.sh

You can also use Bundle::BBBike instead of Bundle::BBBike\_small. This
will install more Perl modules, some of them only useable for the
development, but some of them enabling more features of BBBike.

If you choose to not use "perl install.pl", but you want to compile
and install the XS modules for better performance, then you have to
execute

        make ext

This requires the perl module [Inline::C](https://metacpan.org/pod/Inline%3A%3AC).

### Mac OS X

Mac OS X comes already with perl 5.8.x. Now you just need XDarwin and Perl/Tk
to get BBBike running. For instructions how to setup Perl/Tk on Mac OS X
refer to the comp.lang.perl.tk newsgroup (see
[http://groups.google.com](http://groups.google.com)).

The following instructions are from Wolfram Kroll:

Get [http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18.tar.gz/download](http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18.tar.gz/download) and (from
[http://www.cpan.org](http://www.cpan.org)) perl-5.8.4-stable.tar.gz, Tk-804.027.tar.gz

- 1.
Perl configured to use dynamic libraries:

        # sh Configure -des -Duseshrplib
        # make
        # make test
        # sudo make install

    \--> /usr/local/ is the default (the original Perl is preserved)

- 2.
Tk: that is not a Aqua-Tk, but rather is for X11, but...

        # make

    in an X11 window: # make test

        sudo make install

- 3.
bbbike under X11

    runs!

To compile bbbike under X11 the "Xcode" development tools are needed.
These can be found either on a CD-ROM of the same name (for older Macs)
or in the Applications folder under `Installers/Xcode Tools/Developer.mpkg`
(for newer Macs).

An X11 environment or Darwin environment is also required (package X11SDK).

Mac OS Classic is not supported.

## Windows 95/98/2000/NT/XP/Vista/7/8

### Normal installation

BBBike and Perl need approx. 32 MB hard disk space.

Download the file
[http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18-Windows.exe/download](http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18-Windows.exe/download) and just start it for the installation
program.

### Alternative Windows Installation (1)

As an alternative, you can install BBBike just with the sources. Steps
for Windows 95/98/2000/NT/XP users:

- Download the perl distribution from the ActiveState webpage:

    [http://www.activestate.com/activeperl/downloads](http://www.activestate.com/activeperl/downloads)

    or alternatively use Strawberry Perl:

    [http://strawberryperl.com/](http://strawberryperl.com/)

    The Tk module needs to be installed using the following commands in
    cmd.exe:

        perl -MCPAN -eshell
        force notest install Tk
        quit

- Download
[BBBike-3.18.tar.gz](http://sourceforge.net/projects/bbbike/files/BBBike/3.18/BBBike-3.18-Windows.exe/download)
and extract this file. The unpacked directory may be moved to another
position in the filesystem.
- Open the explorer, change to the BBBike-3.18 directory and call

            install.pl.

    The installation program creates entries in the start
    menu and a desktop icon.

### Alternative Windows Installation (2)

If you have Cygwin ([http://www.cygwin.org/](http://www.cygwin.org/)) installed, you can start
a cygwin shell and follow the
[UNIX instructions](#linux-solaris-other-unix-operating-systems).

### Alternative Windows Installation (3)

For very old systems (Windows95, 98) you can download an older distribution with Tk
included:

[http://www.perl.com/CPAN/ports/win32/Standard/x86/perl5.00402-bindist04-bc.tar.gz](http://www.perl.com/CPAN/ports/win32/Standard/x86/perl5.00402-bindist04-bc.tar.gz)

You have to extract this file with WinZip or gunzip+tar. In the
extracted directory, there will be the installation program
`install.bat`. Call this program in the MSDOS prompt and follow the
instructions.

If you're using this old version of perl (5.004\_02), you also need an
old version of BBBike, at least older than version 3.00.

### Windows 3.1

Windows 3.1 is not supported anymore. Older BBBike versions (for
example 2.x) have instructions on how to use BBBike under Windows 3.1.

# EXECUTION

## Perl/Tk version

To execute BBBike on Unix, change to the bbbike directory and type

        perl bbbike

in the shell. With a full KDE/GNOME installation, there is an icon in the
application menu item
of the start menu. On Windows, there is a start menu entry for
BBBike.

To switch the English language support, please set the LC\_ALL,
LC\_MESSAGES, or LANG environment variables to "en" or something
similar (for FreeBSD and Linux, this is "en\_US.UTF-8"). For Unix,
this can be done with

        env LC_ALL=en_US.UTF-8 perl bbbike

Some versions of BBBike are tested with: Linux (Debian jessie, Debian wheezy, Debian squeeze, Debian etch, Ubuntu 12.04, CentOS, Suse 7.0 und 6.4, Red Hat 8.0), FreeBSD (Version 10.0, 9.2, 9.1, 9.0, 8.0, 6.1, 4.9, 4.6, 3.5), Windows (Windows 8, Windows 7, Vista, XP, 2000, NT 4.0, 98, 95), MacOSX (10.4, 10.5 ...), Solaris (Version 8 und 2.5). The
development machines run with Debian/jessie and FreeBSD.

## WWW version

There is a simple cgi version at

[http://www.bbbike.de](http://www.bbbike.de)

More information for the CGI version at:

[http://bbbike.de/cgi-bin/bbbike.cgi/info=1](http://bbbike.de/cgi-bin/bbbike.cgi/info=1)

# DEVELOPMENT

## git

The current BBBike development may be tracked via git.

To fetch the git repository type the following in the command line:

    git clone git://github.com/eserte/bbbike.git

to update the next time

    cd bbbike
    git pull

The [git repository](http://github.com/eserte/bbbike) is frequently updated and also contains the current
data.

## 
Application update

It is also possible to download a current snapshot using the URL
[http://www.bbbike.de/cgi-bin/bbbike-snapshot.cgi](http://www.bbbike.de/cgi-bin/bbbike-snapshot.cgi).

## 
Data update

To update only the data part of BBBike, just download the current data
as a ZIP file from [http://www.bbbike.de/cgi-bin/bbbike-data.cgi](http://www.bbbike.de/cgi-bin/bbbike-data.cgi). The ZIP file has to be
extracted in the BBBike program directory (Windows: in
`C:\Programme\BBBike\bbbike`).

The data may also be updated within the Perl/Tk application, using the
menu item Settings > Data update over internet.

# DOCUMENTATION

The [documentation](https://metacpan.org/pod/bbbike) can be accessed in pod format (`bbbike.pod`) or in
html format (`bbbike.html`). You can read the pod version with tkpod,
perldoc or from bbbike (if **Tk::Pod** is installed).

# LICENSE

The most important parts of the application (`bbbike`, `cgi/bbbike.cgi`,
`Strassen.pm` and `Strassen/Inline.pm`) and the data in the
subdirectory `data` are released unter the
[GPL](http://www.opensource.org/licenses/gpl-license.html).
The other files can be redristibuted either under the [Artistic
License](http://www.opensource.org/licenses/artistic-license.html) or
the GPL. Please refer to the source files.

Some module und files from other authors are included in this
distribution: `lib/your.pm` by Michael G Schwern,
`lib/Text/ScriptTemplate.pm` by Taisuke Yamada, `lib/enum.pm` by
Zenin, `ext/Strassen-Inline/heap.[ch]` by Internet Software
Consortium, `ext/BBBikeXS/sqrt.c` by Eyal Lebedinsky.

`BBBike-3.18-Windows.zip` contains a partial
`Strawberry Perl` distribution, see
[http://strawberryperl.com/](http://strawberryperl.com/)

# AUTHOR

Slaven Rezic, E-Mail: [slaven@rezic.de](mailto:slaven@rezic.de)
