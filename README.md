Labstat
=======

Tools for getting information about computers on the Curtin network.

mac.sh
------

Usage: `./mac.sh`

Use this tool to get the hostname, MAC address, IPv4 address and IPv6 scope of
the local computer. An ISO 8601 (lexically sortable!) timestamp is included as
the second field, so you can keep track of just how stale your information is.

Note that hostname and timestamp must remain the respective first two fields.
Changing this will require updating cleanup.sh to reflect any such changes.

mac.ps1
-------

Usage: `.\mac.ps1`

The Windows counterpart to `mac.sh` which writes to `mac.ps1.out.txt` in the
same directory, then ejects the containing drive of the script, then logs out.

remote.sh
---------

Usage: `./remote.sh [hostname-or-ip] ...`

Use this tool to get the information provided by mac.sh from a remote computer.
This tool uses ssh. The most convenient and intended way to use this is from a
server or lab machine, with public key authentication set up so you don't need
a password. Note that using ssh from one Curtin host to another means you need
a complete private/public keypair in ~/.ssh, and the public key also listed in
~/.ssh/authorized_hosts.

lab.sh
------

Usage: `./lab.sh [lab#] [max_hosts]`

Use this tool to get information about an entire lab room worth of machines. For
example, running the tool with `219 18` will probe every computer from lab219-01
to lab219-18.

cleanup.sh
----------

Usage: `./cleanup.sh [file-name]`

Use this tool to clean a dump from the other tools. This tool takes in a file,
and does a number of things:

* Sorts the output by hostname ascending, then by timestamp descending
* Prunes all entries for a particular hostname except the most recent

If you redirect the output to a file, don't use the same file name as the input
because reading from and writing to the same file simultaneously is obviously a
bad idea™.
