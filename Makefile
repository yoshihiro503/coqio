subdirs := src samples

.PHONY: all clean $(subdirs)

all: src

$(subdirs):
	$(MAKE) -C $@

clean:
	@for dir in $(subdirs) ; do \
		(cd $$dir && $(MAKE) clean) ;\
	done