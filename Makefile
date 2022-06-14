# ----------------------------------------------------------------------------
# General Setup
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# Dot Files
# -----------------------------------------------------------------------------

# Transfer config files.
ubuntu:
	cd ./unix/ubuntu-20.04 && make configuration

windows:
	cd ./unix/ubuntu-20.04 && make configuration
	cd ./windows && make configuration

mac:
	cd ./unix/mac && make configuration
