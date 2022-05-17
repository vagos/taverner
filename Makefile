PREFIX ?= /usr/local

install: taverner
	install -Dm755 taverner $(DESTDIR)$(PREFIX)/bin/taverner

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/taverner

.PHONY: install uninstall
