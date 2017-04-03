PREFIX=$(HOME)/scripts
HOST=$(shell hostname -s)

TDIR=$(PREFIX)/maildir_archive
install: archive-mails cleanup-maildir.py
	install -D -m 750 -t $(TDIR) archive-mails cleanup-maildir.py
.PHONY: install
