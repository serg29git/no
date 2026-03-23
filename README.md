No — a tiny Unix command that prints "n" indefinitely.

Short description A minimalist command-line utility named "no" that outputs a continuous stream of the letter "n" (one per line). Useful for quick stress tests, terminal demos, or scripting experiments.

Long description No is a single-file executable that repeatedly prints "n" in an infinite loop. It’s kinda silly, inspired by the yes command. — perfect for automating option choosing in scripts, and goofin around.

Features

Single-file Bash script with no external dependencies
Prints "n" followed by new line continuously until interrupted
Includes simple installer script to place/remove the command (uses sudo when needed)

Quick install (example)

Save the installer script and run: bash install-no.sh
Run the command: no
Stop with Ctrl-C.

Contributing Bug reports, installation improvements, or alternative implementations (C, Go, Rust) welcome — keep it small and focused

this project exists to exist.

use with caution (it produces infinite output).
