# This file contains help strings for the various commands/topics in port(1)
#
# Many of these strings are place-holders right now.  Replace with genuinely
# helpful text and then delete this message.
#
# port-help.tcl
# $Id: port-help.tcl 47783 2009-03-06 03:13:55Z blb@macports.org $


set porthelp(activate) {
Activate the given ports
}

set porthelp(archive) {
Archive the given ports
}

set porthelp(build) {
Build the given ports
}

set porthelp(cat) {
Writes the Portfiles of the given ports to stdout
}

set porthelp(cd) {
Changes to the directory of the given port

Only in interactive mode.
}

set porthelp(checksum) {
Compares the checksums for the downloaded files of the given ports
}

set porthelp(clean) {
Removes file associates with given ports

--archives    Removes created archives
--dist        Removes downloaded distfiles
--work        Removes work directory
--all         Removes everything from above
}

set porthelp(compact) {
Compact the given ports
}

set porthelp(configure) {
Configure the given ports
}

set porthelp(contents) {
Returns a list of files installed by given ports
}

set porthelp(deactivate) {
Deactivates the given ports
}

set porthelp(dependents) {
Returns a list of installed dependents for each of the given ports

Note: Don't get fooled by the language!
Dependents are those ports which depend on the given port, not vice-versa!
}

set porthelp(deps) {
Returns a list of dependencies for each of the given ports
}

set porthelp(destroot) {
Destroot the given ports
}

set porthelp(dir) {
Returns the directories of the given ports

This can be quite handy to be used in your shell:
cd $(port dir <portname>)
}

set porthelp(distcheck) {
Checks if the given ports can be fetched from all of its master_sites
}

set porthelp(distfiles) {
Returns a list of distfiles for the given port
}

set porthelp(dmg) {
Creates a dmg for each of the given ports
}

set porthelp(dpkg) {
Creates a dpkg for each of the given ports
}

set porthelp(echo) {
Returns the list of ports the argument expands to

This can be useful to what a pseudo-port expands.
}

set porthelp(edit) {
Edit given ports
}

set porthelp(ed) $porthelp(edit)

set porthelp(exit) {
Exit port

Only in interactive mode.
}

set porthelp(extract) {
Extract the downloaded files of the given ports
}

set porthelp(fetch) {
Downloaded distfiles for the given ports
}

set porthelp(file) {
Returns the path to the Portfile for each of the given ports
}

set porthelp(gohome) {
Opens the homepages of the given ports in your browser
}

set porthelp(help) {
Displays short help texts for the given ports
}

set porthelp(info) {
Returns informations about the given ports
}

set porthelp(install) {
Installs the given ports
}

set porthelp(installed) {
List installed versions of the given port
}

set porthelp(lint) {
Checks if the Portfile is lint-free for each of the given ports
}

set porthelp(list) {
List the available version for each of the given ports
}

set porthelp(livecheck) {
Checks if a new version of the software is available
}

set porthelp(load) {
Interface to launchctl(1) for ports providing startup items
}

set porthelp(location) {
Returns the install location for each of the given ports
}

set porthelp(mdmg) {
Creates a dmg for each of the given ports
}

set porthelp(mirror) {
Fetches distfiles for the given ports
}

set porthelp(mpkg) {
Creates a mpkg for each of the given ports
}

set porthelp(outdated) {
Returns a list of outdated ports
}

set porthelp(patch) {
Applies patches on each of the given port
}

set porthelp(pkg) {
Creates a pkg for each of the given ports
}

set porthelp(platform) {
Returns the current platform you are on
}

set porthelp(provides) {
Return which port (or ports) provide the file (or files) given
}

set porthelp(quit) $porthelp(exit)

set porthelp(rpm) {
Creates a rpm for each of the given ports
}

set porthelp(search) {
Search for a port

This looks in name, desription and long_description of each port for the given search string.
}

set porthelp(selfupdate) {
Upgrade MacPorts itself
}

set porthelp(srpm) {
Creates a srpm for each of the given ports
}

set porthelp(submit) {
Submit a port to the MacPorts Web Application
}

set porthelp(sync) {
Synchronize the set of Portfiles
}

set porthelp(test) {
Run tests on each of the given ports
}

set porthelp(trace) {
Trace a port
}

set porthelp(unarchive) {
Unarchive a port
}

set porthelp(uncompact) {
Uncompact a port
}

set porthelp(uninstall) {
Uninstall the given ports
}

set porthelp(unload) $porthelp(load)

set porthelp(upgrade) {
Upgrades the given ports to the latest version
}

set porthelp(url) {
Returns the URL for each of the given ports
}

set porthelp(usage) {
Returns basic usage of the port command
}

set porthelp(variants) {
Returns a list of variants with descriptions available for the given ports
}

set porthelp(version) {
Returns the version of MacPorts
}
