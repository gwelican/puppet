########################################
#                                      #
#        Puppet configuration          #
#          upgrade packages            #
#                                      #
########################################

# Upgrade bundles {{{1
class upgrade::base {
  include upgrade::ssh
  include upgrade::cron
  include upgrade::cron
  include upgrade::screen
  include upgrade::tar
  include upgrade::gzip
  include upgrade::readline
  include upgrade::logrotate
  include upgrade::findutils
  include upgrade::nano
  include upgrade::facter
  include upgrade::syslog-ng
  include upgrade::hdparm
  include upgrade::bind
  include upgrade::python
  include upgrade::ruby
  include upgrade::vim
  include upgrade::eix
  include upgrade::portage
  include upgrade::gentoo-sources
  include upgrade::rrdtool
  include upgrade::rsync
  include upgrade::openssl
  include upgrade::shorewall
  include upgrade::iptables
  include upgrade::zsh
  include upgrade::weechat
  include upgrade::gentoolkit
  include upgrade::bzip2
  include upgrade::man
  include upgrade::man-pages
  include upgrade::lsof
  include upgrade::wget
  include upgrade::genkernel
  include upgrade::pam
  include upgrade::udev
  include upgrade::baselayout
  include upgrade::perl
  include upgrade::bitlbee
}
class upgrade::base::additionals {
  include upgrade::elinks
  include upgrade::nmap
  include upgrade::genlop
  include upgrade::lftp
  include upgrade::iperf
  include upgrade::unrar
  include upgrade::wireshark
}
# Profiles {{{1
class upgrade::selinux inherits upgrade::base {
  gentoo_unmask{"selinux-bind":
    context => "service_selinux_bind",
    package => "sec-policy/selinux-bind",
    tag => "package",
  }
  gentoo_unmask{"selinux-logrotate":
    context => "service_selinux_logrotate",
    package => "sec-policy/selinux-logrotate",
    tag => "package",
  }
}
class upgrade::profile::x inherits upgrade::base {
  include upgrade::xorg::server
#  include upgrade::xterm
}
class upgrade::profile::web inherits upgrade::base {
  include upgrade::lighttpd
}
class upgrade::profile::nginx inherits upgrade::base {
  include upgrade::nginx
}
class upgrade::profile::php  inherits upgrade::base {
  include upgrade::php
}
class upgrade::profile::rtorrent inherits upgrade::base {
  include upgrade::rtorrent
}
class upgrade::profile::utorrent inherits upgrade::base {
  include upgrade::wine
}
class upgrade::profile::backup::server inherits upgrade::base {
  include upgrade::bacula::server
}
class upgrade::profile::backup::client inherits upgrade::base {
  include upgrade::bacula::client
}
class upgrade::profile::ftp inherits upgrade::base {
  include upgrade::pureftpd
}
class upgrade::profile::media inherits upgrade::base {
  include upgrade::ffmpeg
  include upgrade::vlc
  include upgrade::mplayer
  include upgrade::imagemagick
}
class upgrade::profile::svn inherits upgrade::base {
  include upgrade::subversion
}
class upgrade::profile::git inherits upgrade::base {
  include upgrade::git
}
# Upgrades {{{1
class upgrade::xterm {
  upgrade::package {
    [xterm]:         category => 'x11-terms',      use => 'truetype unicode ';
  }
}
class upgrade::ffmpeg {
  upgrade::package {
    [ffmpeg]:         category => 'media-video',      use => 'theora x264 xvid ogg network mmx encode threads aac truetype';
  }
}
class upgrade::ssh {
  upgrade::package {
    [openssh]:        category => 'net-misc',         use => '-X';
  }
}
class upgrade::baselayout {
  upgrade::package {
    [baselayout]:     category => 'sys-apps',      use => ''
  }
}
class upgrade::udev {
  upgrade::package {
    [udev]:     category => 'sys-fs',      use => '';
  }
}
class upgrade::pam {
  upgrade::package {
    [pam]:     category => 'sys-libs',      use => 'berkdb cracklib nls';
  }
}
class upgrade::cron {
  upgrade::package {
    [vixie-cron]:     category => 'sys-process',      use => 'pam';
  }
}
class upgrade::vim {
  upgrade::package {
    [vim]:            category => 'app-editors',      use => 'ruby bash-completion gpm';
  }
}
class upgrade::screen {
  upgrade::package {
    [screen]:         category => 'app-misc',         use => 'multiuser';
  }
}
class upgrade::rtorrent {
  upgrade::package {
    [rtorrent]:       category => 'net-p2p',          use => 'xmlrpc';
  }
}
class upgrade::bacula::client {
  upgrade::package {
    [bacula]:         category => 'app-backup',       use => 'python readline ssl tcpd -sqlite3 bacula-clientonly bacula-nodir bacula-nosd';
  }
}
class upgrade::bacula::server {
  upgrade::package {
    [bacula]:         category => 'app-backup',       use => 'python readline ssl tcpd -sqlite3';
  }
}
class upgrade::wine {
  upgrade::package {
    [wine]:           category => 'app-emulation',    use => 'X opengl';
  }
}
class upgrade::pureftpd {
  upgrade::package {
    [pure-ftpd]:      category => 'net-ftp',          use => 'mysql';
  }
}
class upgrade::vlc {
  upgrade::package {
    [vlc]:            category => 'media-video',      use => 'httpd matroska mp3 mpeg ogg png shout stream theora truetype win32codecs x264 xml -qt4';
  }
}
class upgrade::lighttpd {
  upgrade::package {
    [lighttpd]:       category => 'www-servers',      use => 'bzip2 php ssl fastcgi doc memcache';
  }
}
class upgrade::profile::nagios::server inherits upgrade::profile::nagios::client {
  upgrade::package {
    [nagios-core]:    category => 'net-analyzer',     use => 'lighttpd vim-syntax debug';
  }
}
class upgrade::profile::nagios::client inherits upgrade::base {
  upgrade::package {
    [nagios-plugins]: category => 'net-analyzer',     use => 'ssl mysql nagios-dns nagios-ntp nagios-ping nagios-ssh';
  }
}
class upgrade::nmap {
  upgrade::package {
    [nmap]:           category => 'net-analyzer',     use => '-gtk2';
  }
}
class upgrade::elinks {
  upgrade::package {
    [elinks]:         category => 'www-client',       use => 'javascript ruby bzip2 bittorent ftp perl';
  }
}
class upgrade::genlop {
  upgrade::package {
    [genlop]:         category => 'app-portage',      use => 'bash-completion';
  }
}
class upgrade::dovecot {
  upgrade::package {
    [dovecot]:        category => 'net-mail',         use => 'mysql pop3d';
  }
}
class upgrade::rrdtool {
  upgrade::package {
    [rrdtool]:        category => 'net-analyzer',     use => 'python rrdcgi perl';
  }
}
class upgrade::pango {
  upgrade::package {
    [pango]:          category => 'x11-libs',         use => 'X';
  }
}
class upgrade::ruby {
  upgrade::package {
    [ruby]:           category => 'dev-lang',         use => 'ipv6 doc ssl';
  }
}
class upgrade::vnc {
  upgrade::package {
    [vnc]:            category => 'net-misc', use=>'server';
  }
}
class upgrade::nano {
  upgrade::package {
    [nano]:           category => 'app-editors';
  }
}
class upgrade::tar {
  upgrade::package {
    [tar]: category =>  'app-arch';
  }
}
class upgrade::findutils {
  upgrade::package {
    [findutils]: category =>  'sys-apps';
  }
}
class upgrade::gzip {
  upgrade::package {
    [gzip]: category =>  'app-arch';
  }
}
class upgrade::bash {
  upgrade::package {
    [bash]: category =>  'app-shells';
  }
}
class upgrade::readline {
  upgrade::package {
    [readline]: category =>  'sys-libs';
  }
}
class upgrade::logrotate {
  upgrade::package {
    [logrotate]: category =>  'app-admin';
  }
}
class upgrade::automake {
  upgrade::package {
    [automake]: category =>  'sys-devel';
  }
}
class upgrade::facter {
  upgrade::package {
    [facter]: category =>  'dev-ruby';
  }
}
class upgrade::syslog-ng {
  upgrade::package {
    [syslog-ng]: category =>  'app-admin', use => 'sql pcre ipv6 ssl spoof-source';
  }
}

class upgrade::lftp {
  upgrade::package {
    [lftp]: category =>  'net-ftp';
  }
}
class upgrade::iperf {
  upgrade::package {
    [iperf]: category =>  'net-misc';
  }
}
class upgrade::wgetpaste {
  upgrade::package {
    [wgetpaste]: category =>  'app-text';
  }
}
class upgrade::unrar {
  upgrade::package {
    [unrar]: category =>  'app-arch';
  }
}
class upgrade::hdparm {
  upgrade::package {
    [hdparm]: category =>  'sys-apps';
  }
}
class upgrade::bind {
  upgrade::package {
    [bind]: category =>  'net-dns';
  }
}
class upgrade::bzflag {
  upgrade::package {
    [bzflag]: category =>  'games-action', use => 'dedicated';
  }
}
class upgrade::python {
  upgrade::package {
    [python]: category =>  'dev-lang', use => 'sqlite';
  }
}
class upgrade::puppet {
  upgrade::package {
    [puppet]: category => 'app-admin', use => 'vim-syntax -ldap -augeas'
  }
}
class upgrade::mplayer {
  upgrade::package {
    [mplayer]: category => 'media-video', use => 'X a52 alsa dvd iconv ipv6 mad mmx mp3 theora truetype unicode vorbis xscreensaver xv aac encode x264 rar radio xvid png jpeg'
  }
}
class upgrade::nginx {
  upgrade::package {
    [nginx]: category => 'www-servers', use => 'nginx_modules_http_gzip_static vim-syntax'
  }
}
class upgrade::wireshark {
  upgrade::package {
    [wireshark]: category =>  'net-analyzer';
  }
}
class upgrade::subversion {
  upgrade::package {
    [subversion]: category =>  'dev-vcs';
  }
}
class upgrade::git {
  upgrade::package {
    [git]: category =>  'dev-vcs';
  }
}

class upgrade::tcptraceroute {
  upgrade::package {
    [tcptraceroute]: category =>  'net-analyzer';
  }
}
class upgrade::phpmyadmin {
  upgrade::package {
    [phpmyadmin]: category =>  'dev-db';
  }
}
class upgrade::rsync {
  upgrade::package {
    [rsync]: category =>  'net-misc';
  }
}
class upgrade::openssl {
  upgrade::package {
    [openssl]: category =>  'dev-libs';
  }
}
class upgrade::shorewall {
  upgrade::package {
    [shorewall]: category =>  'net-firewall', ensure => latest;
  }
}
class upgrade::iptables {
  upgrade::package {
    [iptables]: category =>  'net-firewall';
  }
}
class upgrade::smartmontools {
  upgrade::package {
    [smartmontools]: category =>  'sys-apps';
  }
}
class upgrade::rcs {
  upgrade::package {
    [rcs]: category =>  'app-text';
  }
}
class upgrade::portage {
  upgrade::package {
    [portage]: category =>  'sys-apps';
  }
}
class upgrade::expat {
  upgrade::package {
    [expat]: category =>  'dev-libs';
  }
}
class upgrade::hddtemp {
  upgrade::package {
    [hddtemp]: category =>  'app-admin';
  }
}
class upgrade::ethtool {
  upgrade::package {
    [ethtool]: category =>  'sys-apps';
  }
}
class upgrade::lm_sensors {
  upgrade::package {
    [lm_sensors]: category =>  'sys-apps';
  }
}
class upgrade::ntp {
  upgrade::package {
    [ntp]: category =>  'net-misc';
  }
}
class upgrade::zsh {
  upgrade::package {
    [zsh]: category =>  'app-shells';
  }
}
class upgrade::weechat {
  upgrade::package {
    [weechat]: category =>  'net-irc', use => 'charset fifo irc logger lua ncurses nls perl python relay ruby scripts spell ssl';
  }
}
class upgrade::imagemagick {
  upgrade::package {
    [imagemagick]: category =>  'media-gfx', use => 'png';
  }
}
class upgrade::zsh-completion {
  upgrade::package {
    [zsh-completion]: category =>  'app-shells';
  }
}
class upgrade::gentoolkit {
  upgrade::package {
    [gentoolkit]: category =>  'app-portage';
  }
}
class upgrade::eix {
  upgrade::package {
    [eix]: category =>  'app-portage';
  }
}
class upgrade::man-pages {
  upgrade::package {
    [man-pages]: category =>  'sys-apps';
  }
}
class upgrade::man {
  upgrade::package {
    [man]: category =>  'sys-apps';
  }
}
class upgrade::bzip2 {
  upgrade::package {
    [bzip2]: category =>  'app-arch';
  }
}
class upgrade::pciutils {
  upgrade::package {
    [pciutils]: category =>  'sys-apps';
  }
}
class upgrade::profile::nagios::nrpe {
  upgrade::package {
    [nagios-nrpe]: category =>  'net-analyzer';
  }
}
class upgrade::nagios {
  upgrade::package {
    [nagios]: category =>  'net-analyzer';
  }
}
class upgrade::dbd-sqlite {
  upgrade::package {
    [DBD-SQLite]: category =>  'dev-perl';
  }
}
class upgrade::dbd-sqlite2 {
  upgrade::package {
    [DBD-SQLite2]: category =>  'dev-perl';
  }
}
class upgrade::dbd-mysql {
  upgrade::package {
    [DBD-mysql]: category =>  'dev-perl';
  }
}
class upgrade::dbi {
  upgrade::package {
    [DBI]: category =>  'dev-perl';
  }
}
class upgrade::dstat {
  upgrade::package {
    [dstat]: category =>  'sys-apps';
  }
}
class upgrade::poppler {
  upgrade::package {
    [poppler]: category =>  'app-text';
  }
}
class upgrade::colordiff {
  upgrade::package {
    [colordiff]: category =>  'app-misc';
  }
}
class upgrade::digest-md5 {
  upgrade::package {
    [Digest-MD5]: category =>  'perl-core';
  }
}
class upgrade::bind-tools {
  upgrade::package {
    [bind-tools]: category =>  'net-dns';
  }
}
class upgrade::lsof {
  upgrade::package {
    [lsof]: category =>  'sys-process';
  }
}
class upgrade::wget {
  upgrade::package {
    [wget]: category =>  'net-misc';
  }
}
class upgrade::strace {
  upgrade::package {
    [strace]: category =>  'dev-util';
  }
}
class upgrade::mit-krb5 {
  upgrade::package {
    [mit-krb5]: category =>  'app-crypt', ensure => absent;
  }
}
class upgrade::quota {
  upgrade::package {
    [quota]: category =>  'sys-fs';
  }
}
class upgrade::net-tools {
  upgrade::package {
    [net-tools]: category =>  'sys-apps';
  }
}
class upgrade::genkernel {
  upgrade::package {
    [genkernel]: category =>  'sys-kernel';
  }
}
class upgrade::xorg-server {
  upgrade::package {
    [xorg-server]: category =>  'x11-base';
  }
}
class upgrade::xwininfo {
  upgrade::package {
    [xwininfo]: category =>  'x11-apps';
  }
}
class upgrade::xautomation {
  upgrade::package {
    [xautomation]: category =>  'x11-misc';
  }
}
class upgrade::postfix {
  upgrade::package {
    [postfix]: category =>  'mail-mta', use => 'mysql ssl sasl vda maildir -mbox libwww imap -ipv6';
  }
}
class upgrade::postfixadmin {
  upgrade::package {
    [postfixadmin]: category =>  'www-apps', use => 'mysql';
  }
}
class upgrade::gentoo-sources {
  upgrade::package {
    [gentoo-sources]: category =>  'sys-kernel', use => 'symlink';
  }
}
class upgrade::mozilla-firefox {
  upgrade::package {
    [mozilla-firefox]: category =>  'www-client';
  }
}
class upgrade::php {
  upgrade::package {
    [php]:            category => 'dev-lang', use => '-apache -berkdb -ipv6 -apache2 bzip2 calendar hash json threads mhash xml truetype xmlreader xmlrpc xmlwriter xsl ftp gd sockets simplexml tidy curl fastbuild posix bcmath sqlite ctype pcre cgi postgres session pdo fpm zip -recode -cli -exif -esoob -phar -wddx -sysvipc -sybase-ct -suhosin -oci8 -oci8-instant-client -odbc -pcntl -qdbm -sapdb -mssql -snmp -soap -gdbm -ldap -sharedext cli mysql';
  }
}
class upgrade::bitlbee {
  upgrade::package {
    [bitlbee]:  category => 'net-im', use => 'gnutls msn plugins purple twitter jabber -oscar otr';
  }
}
class upgrade::perl {
  upgrade::package {
    [perl]:  category => 'dev-lang', use => 'berkdb gdbm';
  }
}
# USE flags {{{1
class upgrade::portageflags {
  gentoo_use_flags {"gmime":
    context => "service_gmime",
    package => "dev-libs/gmime",
    use => "mono",
    tag => "package",
  }
  gentoo_use_flags {"mpd":
    context => "service_mpd",
    package => "media-sound/mpd",
    use => "aac icecast mp3 ogg vorbis unicode iconv",
    tag => "package",
  }
  gentoo_use_flags {"virtualbox-bin":
    context => "service_virtualbox-bin",
    package => "app-emulation/virtualbox-bin",
    use => "headless additions",
    tag => "package",
  }
  gentoo_use_flags {"cairo":
    context => "service_cairo",
    package => "x11-libs/cairo",
    use => "X svg",
    tag => "package",
  }
  gentoo_use_flags {"xmlrpc-c":
    context => "service_xmlrpc-c",
    package => "dev-libs/xmlrpc-c",
    use => "libwww curl",
    tag => "package",
  }
  gentoo_use_flags {"GD":
    context => "service_GD",
    package => "dev-perl/GD",
    use => "jpeg png",
    tag => "package",
  }
  gentoo_use_flags {"gd":
    context => "service_gd",
    package => "media-libs/gd",
    use => "jpeg png truetype",
    tag => "package",
  }
  gentoo_use_flags {"cyrus-sasl":
    context => "service_cyrus-sasl",
    package => "dev-libs/cyrus-sasl",
    use => "crypt autademond -berkdb ssl mysql sample",
    tag => "package",
  }
  gentoo_use_flags {"spamassassin":
    context => "service_spamassassin",
    package => "mail-filter/spamassassin",
    use => "mysql",
    tag => "package",
  }
  gentoo_use_flags {"amavisd-new":
    context => "service_amavisd-new",
    package => "mail-filter/amavisd-new",
    use => "mysql",
    tag => "package",
  }
  gentoo_use_flags {"clamav":
    context => "service_clamav",
    package => "app-antivirus/clamav",
    use => "bzip2",
    tag => "package",
  }
  gentoo_use_flags {"mc":
    context => "service_mc",
    package => "app-misc/mc",
    use => "-unicode",
    tag => "package",
  }
}
# upgrade::Desktop {{{1
#class upgrade::desktop {
#  upgrade::package {
#    [nmap]:            category => 'net-analyzer';
#    [unrar]:           category => 'app-arch';
#    [hdparm]:          category => 'sys-apps';
#    [python]:          category => 'dev-lang';
#    [wireshark]:       category => 'net-analyzer';
#    [genlop]:          category => 'app-portage';
#    [logrotate]:       category => 'app-admin';
#    [vim]:             category => 'app-editors';
#    [nano]:            category => 'app-editors';
#    [subversion]:      category => 'dev-util';
#    [git]:             category => 'dev-util';
#    [iptraf]:          category => 'net-analyzer',ensure => absent;
#    [tcptraceroute]:   category => 'net-analyzer';
#    [rsync]:           category => 'net-misc';
#    [openssl]:         category => 'dev-libs';
#    [ruby]:            category => 'dev-lang';
#    [automake]:        category => 'sys-devel';
#    [shorewall]:       category => 'net-firewall', ensure => absent;
#    [iptables]:        category => 'net-firewall';
#    [smartmontools]:   category => 'sys-apps';
#    [rcs]:             category => 'app-text';
#    [portage]:         category => 'sys-apps';
#    [facter]:          category => 'dev-ruby';
#    [vixie-cron]:      category => 'sys-process';
#    [expat]:           category => 'dev-libs';
#    [syslog-ng]:       category => 'app-admin';
#    [hddtemp]:         category => 'app-admin';
#    [ethtool]:         category => 'sys-apps';
#    [elinks]:          category => 'www-client';
#    [lftp]:            category => 'net-ftp';
#    [lm_sensors]:      category => 'sys-apps';
#    [iperf]:           category => 'net-misc';
#    [ntp]:             category => 'net-misc';
#    [bacula]:          category => 'app-backup';
#    [zsh]:             category => 'app-shells';
#    [zsh-completion]:  category => 'app-shells';
#    [gentoolkit]:      category => 'app-portage';
#    [screen]:          category => 'app-misc';
#    [eix]:             category => 'app-portage';
#    [openssh]:         category => 'net-misc';
#    [man-pages]:       category => 'sys-apps';
#    [man]:             category => 'sys-apps';
#    [bzip2]:           category => 'app-arch';
#    [pciutils]:        category => 'sys-apps';
#    [DBD-SQLite]:      category => 'dev-perl';
#    [DBD-SQLite2]:     category => 'dev-perl';
#    [DBD-mysql]:       category => 'dev-perl';
#    [DBI]:             category => 'dev-perl';
#    [dstat]:           category => 'sys-apps';
#    [poppler]:         category => 'app-text';
#    [colordiff]:       category => 'app-misc';
#    [Digest-MD5]:      category => 'perl-core';
#    [bind-tools]:      category => 'net-dns';
#    [lsof]:            category => 'sys-process';
#    [wget]:            category => 'net-misc';
#    [strace]:          category => 'dev-util';
#    [mit-krb5]:        category => 'app-crypt', ensure => absent;
#    [tar]:             category => 'app-arch';
#    [findutils]:       category => 'sys-apps';
#    [gzip]:            category => 'app-arch';
#    [bash]:            category => 'app-shells';
#    [quota]:           category => 'sys-fs';
#    [net-tools]:       category => 'sys-apps';
#    [genkernel]:       category => 'sys-kernel';
#    [readline]:        category => 'sys-libs';
#  }
  
#}

# Base {{{1
#class upgrade::base {
#  include upgrade::system
#  upgrade::package {
#    [ssldump]:        category => 'net-analyzer';
#    [xmpppy]:         category => 'dev-python';
#  }
#}
# Define {{{1
define upgrade::package ($ensure = "latest", $category, $use = "") {
  case $ensure {   
    "latest": { 
      debug ( "install: $category - $name" ) 
        gentoo_use_flags {$name:
          context => "service_$name",
          package => "$category/$name",
          use => $use,
          tag => "package",
        }
        package{$name: 
          category => $category, 
          ensure => latest, 
          provider => 'portage',
          require => Gentoo_use_flags["$name"],
          tag => "package",
        }  
    }  
    default: {  
    }
  }
}

# ViM modeline {{{1
# vim:foldmethod=marker:foldenable:foldlevel=0

