VIRTUAL_ENV := nikola

default: help

$(VIRTUAL_ENV):
	source activate $(VIRTUAL_ENV)

help:
	@echo "Enter nikola virtual env:"
	@echo "make $(VIRTUAL_ENV)"
	@echo "Initialize the current directory"
	@echo "make init"

init:
	nikola init test
	mv test/* .
	rmdir test
	nikola plugin -i orgmode
	make -i init2

# Modifying conf.py

# Multiline variable
define orgmode_extra
# Add the orgmode compiler to your COMPILERS dict.
COMPILERS["orgmode"] = ('.org',)

# Add org files to your POSTS, PAGES
POSTS = POSTS + (("posts/*.org", "posts", "post.tmpl"),)
PAGES = PAGES + (("stories/*.org", "stories", "story.tmpl"),)
endef

# Pass it to the shell
export orgmode_extra

init2:
	@echo "$$orgmode_extra" >> conf.py
