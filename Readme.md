step 1 :
sudo mv sysopctl.sh /usr/local/bin/sysopctl

step 2:

Make the Script Executable
In the terminal, run:
chmod +x sysopctl.sh

Run the Script
Now you can run the script directly from the terminal:
./sysopctl.sh --help

Or, use other commands as specified in the script:
./sysopctl.sh service list
./sysopctl.sh system load
./sysopctl.sh disk usage
./sysopctl.sh process monitor
./sysopctl.sh logs analyze
./sysopctl.sh backup /path/to/backup
