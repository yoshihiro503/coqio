subdirs := hello

.PHONY: all clean $(subdirs)

all: $(subdirs)

$(subdirs):
	$(MAKE) -C $@

clean:
	@for dir in $(subdirs) ; do \
		(cd $$dir && $(MAKE) clean) ;\
	done