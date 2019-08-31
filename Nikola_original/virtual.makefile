VIRTUAL_ENV := nikola

default: help

$(VIRTUAL_ENV):
	@echo "source activate $(VIRTUAL_ENV)"

help:
	@echo "# Enter nikola virtual env:"
	@echo "make $(VIRTUAL_ENV)"
	@echo "Initialize the current directory"
	@echo "make init"

post:
	nikola new_post -e -f orgmode

post_formats:
	nikola new_post -F

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
