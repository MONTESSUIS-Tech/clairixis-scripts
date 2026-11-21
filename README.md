# Clairixis scripts

Ready-made scripts for Clairixis, an
operations console for fleets of Linux servers. They answer the questions
an administrator asks every week: what fills this disk, which service
failed, does this host need a restart, when does this certificate expire.

Each script is plain POSIX shell, written to run on every system Clairixis
supports (Debian, Ubuntu, AlmaLinux and their relatives). A script reads
nothing but its parameters, changes nothing unless its description says
so, and says in its description when it is to be run as root.

## Using them in Clairixis

This repository is one Clairixis reads by itself: its scripts appear in
the library under Automation, Scripts, and follow this repository each
time it is synchronised (Automation, Repositories).

To read a copy of your own instead, fork this repository and add the fork
under Automation, Repositories, with its HTTPS address and the branch to
follow. Scripts read from a repository are changed in that repository,
not in Clairixis: every change is a new version of the script, which
names the commit it came from, and a run keeps the version it was
launched with.

## The scripts

### System

| Script | What it does |
|---|---|
| [Disk space](system/disk_usage.sh) | Shows how full each filesystem is, then the largest directories under a directory. Run it as root to count what the login account cannot read. |
| [Largest files](system/large_files.sh) | Lists the largest files under a directory, without leaving its filesystem. Run it as root to see every file. |
| [Memory and what uses it](system/memory.sh) | Shows memory and swap, then the processes that hold the most memory. |
| [Processor and what uses it](system/processor.sh) | Shows the load, then the processes that use the most processor time now. |
| [Clock and time synchronisation](system/time_sync.sh) | Shows the time of the host, its time zone, and whether its clock is kept in step. |
| [Is a restart needed?](system/reboot_needed.sh) | Says whether the host waits for a restart to finish its updates, and compares the kernel that runs with the newest one installed. |
| [Restart the host](system/reboot.sh) | Restarts the host after a delay, which leaves the run time to finish and people time to be warned. Run it as root. |
| [Empty the package cache](system/clean_package_cache.sh) | Removes the packages the package manager downloaded and keeps, on any supported system, and shows the space before and after. Run it as root. |

### Services

| Script | What it does |
|---|---|
| [Failed services](services/failed_units.sh) | Lists the systemd units that failed. The run fails on a host that has any, so a schedule of it tells which hosts need a look. |
| [State of a service](services/service_status.sh) | Shows whether a systemd unit runs, since when, and its last lines of log. |
| [Restart a service](services/service_restart.sh) | Restarts a systemd unit and shows its state afterwards. The run fails if the unit does not come back. Run it as root. |
| [Errors in the journal](services/journal_errors.sh) | Shows what the system journal recorded as an error over the last hours. Run it as root to read the journal of every service. |
| [Containers](services/containers.sh) | Lists the containers of Docker or Podman, running or not, and the space their images and volumes take. Run it as root where the login account may not ask. |

### Network

| Script | What it does |
|---|---|
| [Listening ports](network/listening_ports.sh) | Lists the ports the host listens on. Run it as root to see which program holds each. |
| [Reach an address from the host](network/check_address.sh) | Asks a web address from the host and shows the answer code and the time it took: what the host itself can reach, not the controller. |
| [When a certificate expires](network/certificate.sh) | Reads the certificate a TLS service presents and says when it expires. The run fails when that is within the number of days given, so a schedule of it warns in time. |
| [Firewall rules](network/firewall.sh) | Shows the rules of the firewall in use: firewalld, ufw, nftables or iptables. Run it as root. |

### Security

| Script | What it does |
|---|---|
| [Recent logins](security/logins.sh) | Shows the last logins and who is logged in now. |
| [Accounts that can log in](security/accounts.sh) | Lists the accounts that have a login shell, and the members of the groups that give administrator rights. |

## Layout

```
clairixis.toml   what this repository offers: one entry per script
LICENSE          GNU General Public License, version 3 or later
system/          disks, memory, processor, clock, restarts, package cache
services/        systemd units, the journal, containers
network/         ports, addresses, certificates, the firewall
security/        logins and accounts
```

A script that is not listed in `clairixis.toml` is not offered, wherever
it is.

## The manifest

`clairixis.toml`, at the root, lists the scripts. One entry:

```toml
[[script]]
name = "When a certificate expires"
path = "network/certificate.sh"
description = "Reads the certificate a TLS service presents and says when it expires."
min_version = "0.1.0"

  [[script.parameter]]
  name = "days"
  description = "Fail when the certificate expires within this many days"
  kind = "number"
  default = "30"
```

| Field | Meaning |
|---|---|
| `name` | What the script is called in the library. Unique. |
| `path` | The file, from the root of the repository. Its extension says what runs it: `.sh` (sh), `.bash` (bash), `.py` (python3), `.yml` or `.yaml` (an Ansible playbook). |
| `interpreter` | Says what runs it when the extension does not: `sh`, `bash`, `python3` or `ansible`. |
| `description` | What it does, for whoever chooses it. Say here when it must run as root, and when it changes something. |
| `min_version` | The first version of Clairixis the script works with. A controller older than that does not offer it. |
| `max_version` | The last version of Clairixis it works with, for a script that relies on something later removed. A controller newer than that does not offer it. |

A parameter is a value asked when the script is launched:

| Field | Meaning |
|---|---|
| `name` | Lower case. The script reads it as an environment variable in upper case: `days` is `$DAYS`. |
| `description` | What it is for. |
| `kind` | `text`, `number`, `boolean` or `choice`. Clairixis checks the value before anything is launched. |
| `choices` | The values accepted, when `kind` is `choice`. |
| `default` | Used when no value is given. |
| `required` | `true` when the script cannot run without it. |
| `secret` | `true` for a password or a token: its value reaches the host and is kept nowhere. |

## Writing a script

- POSIX `sh`, unless the script cannot do without more: then say so with
  its extension, and in its description.
- Every system Clairixis supports, or a clear message on the ones the
  script cannot serve. Find the tool that is there (`apt-get` or `dnf`,
  `ss` or `netstat`) instead of assuming one.
- Parameters come as environment variables and are values, never pieces
  of command: quote them (`"$DIRECTORY"`), and do not `eval` them.
- The exit code is the answer a schedule reads: exit with something other
  than zero when what the script checks is wrong, so that a run kept on a
  schedule tells which hosts need a look.
- Print what a person needs to read, under short headings. The output of
  a run is kept and shown as it is.
- A script that changes something says so in its description, and does
  only that.
- Each file begins with the three lines that name these scripts, their
  copyright and their license (`SPDX-License-Identifier: GPL-3.0-or-later`):
  copy them from any script here.

Add the file under the directory it belongs to, list it in
`clairixis.toml`, and add its line to the table above.

## License

Copyright (C) 2026 Quentin MONTESSUIS (MONTESSUIS Tech).

These scripts are free software: you can redistribute them and modify
them under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or (at
your option) any later version. Whoever passes on a changed copy passes
it on under the same terms.

They are distributed in the hope that they will be useful, but WITHOUT
ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
FITNESS FOR A PARTICULAR PURPOSE. See [LICENSE](LICENSE) for the full
text.

This is the license of the scripts in this repository, not the license
of Clairixis.
