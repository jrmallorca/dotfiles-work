# ----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
ubuntu:
	cd ./unix/ubuntu-20.04 && make configuration

mac:
	cd ./unix/mac && make configuration

wsl-ubuntu:
	cd ./windows && make configuration
	cd ./unix/ubuntu-20.04 && make configuration
