# EPICS LXI IOC

## Build

```sh
cd epics-lxi-ioc

EPICS_BASE=/path/to/epics_base
ASYN=/path/to/AsynDriver
STREAM=/path/to/StreamDevice

./preconf.sh

make
```

## Run

```sh
cd epics-lxi-ioc/iocBoot/iocLXI/
./st.cmd
```

## How to setup Supervisord

### Epics setup

+ Install **epics base**, **asyn driver** and **stream device** in `/opt/epics`
+ Make in this directory symlinks to them named `base`, `asyn` and `stream` accordingly
+ Make `/opt/epics` readable by all (at least, by `v4-cs-worker`)

### Supervisor setup

+ Install `supervisord` from CentOS repo (via yum)
+ Copy `/usr/lib/systemd/system/supervisord.service` to `/etc/systemd/system/supervisord-ioc.service`
  + Replace in `ExecStart=...` path `/etc/supervisord.conf` by `/epics/supervisord-ioc.conf`
  + Add line `User={ioc_runner}`
+ Create `/epics` directory
  + Set owner:group to `v4-cs-worker:v4-cs-admins`
  + Set *setgid* bit
  + Set *ACL* recursive default rules `u::rwx` and `g::rwx`
+ Copy `/etc/supervisord.conf` to `/epics/supervisord-ioc.conf`
  + Change owner:group to `v4-cs-worker:v4-cs-admins`
  + Change rights to `-rw-rw----`
  + Edit this file:
    + In `[unix_http_server]` section:
      + Edit `file=/epics/supervisor-ioc.sock`
      + Edit `chmod=0770`
    + In `[supervisord]` section:
      + Edit `logfile=/var/log/supervisor-ioc/supervisord-ioc.log`
      + Comment out `pidfile=...` (with ; symbol)
      + Edit `childlogdir=/var/log/supervisor-ioc/children`
      + Edit `umask=0002`
    + In `[supervisorctl]` section edit `serverurl=unix:///epics/supervisor-ioc.sock`
    + In `[include]` section (at the bottom of the file) edit `files=supervisord-ioc.d/*.ini`
+ Create directory `supervisor-ioc` in `/var/log` with owner:group `v4-cs-worker:v4-cs-admins` and `drwxrwx---` rights
  + Create subdirectory children with the same owners and rights 
+ In `/epics` create directory `supervisord-ioc.d` with owner:group `v4-cs-worker:v4-cs-admins`. IOC-specific config `*.ini` files should be placed in this directory.
+ Enable `supervisord-ioc` service and start it

### Subprocess management

+ To add a new supervising process:
  + Copy example section `[program:theprogramname]` from `/epics/supervisord-ioc.conf` into new `<progname>.ini` file inside `/epics/supervisord-ioc.d` folder
  + Change section name to `[program:<progname>]`
  + Edit `command=<cmd> [args...]` to run your program
  + If you need this, edit `directory=<dir-to-cwd>`
  + Edit `std(out/err)_logfile=/var/log/supervisor-ioc/children/<progname>_std(out/err).log`.
    *Be careful, if this field points to invalid location (or without write access) then supervisord-ioc will crash without any message about that*
+ To control subprocesses use:
  + `supervisorctl -s unix:///epics/supervisor-ioc.sock`.
    This will open simple pseudo-shell
  + To list all subprocesses enter `avail` or `status` commands
  + To apply modifications from `/epics/supervisord-ioc.d` folder (including creation of a new file) enter: `reread; update`
Supervisorctl allows you to be attached to supervising process shell, just enter: `fg <progname>`
