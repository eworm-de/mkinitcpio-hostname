# Makefile for mkinitcpio-hostname

VERSION=0.2.2

all:
	@echo "Just run make install..."

.PHONY: install
install:
	install -D -m0644 hook/hostname $(DESTDIR)/usr/lib/initcpio/hooks/hostname
	install -D -m0644 install/hostname $(DESTDIR)/usr/lib/initcpio/install/hostname

release:
	git archive --format=tar.xz --prefix=mkinitcpio-hostname-$(VERSION)/ $(VERSION) > mkinitcpio-hostname-$(VERSION).tar.xz
	gpg --armor --detach-sign --comment mkinitcpio-hostname-$(VERSION).tar.xz mkinitcpio-hostname-$(VERSION).tar.xz
	git notes --ref=refs/notes/signatures/tar add -C $$(git archive --format=tar --prefix=mkinitcpio-hostname-$(VERSION)/ $(VERSION) | gpg --armor --detach-sign --comment mkinitcpio-hostname-$(VERSION).tar | git hash-object -w --stdin) $(VERSION)
