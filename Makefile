wildc_recursive=$(foreach d,$(wildcard $1*),$(call wildc_recursive,$d/,$2) $(filter $(subst *,%,$2),$d))

VERSION = 0.1

HTML_FILES       = $(call wildc_recursive, src/, *.html)
JS_FILES         = $(call wildc_recursive, src/, *.js)
IMAGE_FILES      = $(wildcard src/gui/images/*)
GUI_ELM_FILES    = $(wildcard src/gui/*.elm)
BG_ELM_FILES     = $(wildcard src/background/*.elm)
DIRS             = $(sort $(dir $(call wildc_recursive, src/, *)))

all      : elm dirs manifest html js images

# Install elm dependencies
install: elm-package.json
	elm-package install -y

dirs     : $(patsubst src%, build%/.dirstamp, $(DIRS))
elm      : dirs build/background/elm-background.js build/gui/elm-gui.js
html     : dirs $(patsubst src/%, build/%, $(HTML_FILES))
js       : dirs $(patsubst src/%, build/%, $(JS_FILES))
images   : dirs $(patsubst src/%, build/%, $(IMAGE_FILES))
manifest : dirs build/manifest.json

build/manifest.json: src/manifest.json
	sed 's/@version/"$(VERSION)"/' src/manifest.json > build/manifest.json

# Create directories when needed
%/.dirstamp:
	mkdir $*
	@touch $@

build/gui/elm-gui.js: $(GUI_ELM_FILES)
	elm-make $(GUI_ELM_FILES) --output $@

build/background/elm-background.js: $(BG_ELM_FILES)
	elm-make $(BG_ELM_FILES) --output $@

# Copy files if no other build method is specified
build/%: src/%
	cp $< $@

clean:
	rm -rf build

cleanelm:
	rm -rf elm-stuff

watch:
	@while true; do make | grep -v 'make\[1\]:'; sleep 1; done

.PHONY: all install dirs elm html js manifest clean cleanelm watch
