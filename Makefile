SOURCEDIR = $(PWD)
VEDLIBDIR = $(PWD)/ext/velib_python
INSTALL_CMD = install
LIBDIR = $(bindir)/ext/velib_python

FILES = $(SOURCEDIR)/dbus-bornay-windplus.py

VEDLIB_FILES = \
	$(VEDLIBDIR)/logger.py \
	$(VEDLIBDIR)/ve_utils.py \
	$(VEDLIBDIR)/vedbus.py \
	$(VEDLIBDIR)/settingsdevice.py \
	$(VEDLIBDIR)/dbusmonitor.py

help:
	@echo "The following make targets are available"
	@echo " help - print this message"
	@echo " install - install everything"
	@echo " clean - remove temporary files"

install_app : $(FILES)
	@if [ "$^" != "" ]; then \
		$(INSTALL_CMD) -d $(DESTDIR)$(bindir); \
		$(INSTALL_CMD) -t $(DESTDIR)$(bindir) $^; \
		echo installed $(DESTDIR)$(bindir)/$(notdir $^); \
	fi

install_velib_python: $(VEDLIB_FILES)
	@if [ "$^" != "" ]; then \
		$(INSTALL_CMD) -d $(DESTDIR)$(LIBDIR); \
		$(INSTALL_CMD) -t $(DESTDIR)$(LIBDIR) $^; \
		echo installed $(DESTDIR)$(LIBDIR)/$(notdir $^); \
	fi

install: install_velib_python install_app
clean distclean: ;

testinstall: testinstall
	$(eval TMP := $(shell mktemp -d))
	$(MAKE) DESTDIR=$(TMP) install
	(cd $(TMP) && ./dbus-bornay-windplus.py --help > /dev/null)
	-rm -rf $(TMP)

.PHONY: help install_app install_velib_python install testinstall clean distclean

