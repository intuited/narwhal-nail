# I've made absolutely no attempt to make this work under
#   operating systems other than linux.
# If you are well acquainted with such environments,
#   please send in a patch/pull request or fork the repository.
# Probably it would be best to rewrite it in a more portable language.

# Similarly, this makefile has only been tested with GNU make.

SHELL = /bin/bash


# These variables can be set in the environment
JARS_DIR ?= jars;
LIB_DIR ?= lib;
BIN_DIR ?= bin;
# These two will determine the names of targets.
NAILGUN_CLIENT ?= $(BIN_DIR)/ng;
NAILGUN_JAR ?= $(JARS_DIR)/nailgun.jar;

NAILGUN_SVN_REPO_URL ?= https://nailgun.svn.sourceforge.net/svnroot/nailgun
NAILGUN_SVN_BRANCH ?= branches/NailGun_0_7_1/
NAILGUN_INSTALL_DIR ?= nailgun
NAILGUN_INSTALL_JAR_PATH ?= dist

NAILGUN_INSTALL_JAR = $(NAILGUN_INSTALL_DIR)/$(NAILGUN_INSTALL_JAR_PATH)/*.jar;

# NARWHAL_PROTOTYPE_ENGINE_HOME must be set in the environment
ifndef NARWHAL_PROTOTYPE_ENGINE_HOME

PROTOTYPE_JARS_DIR = $(NARWHAL_PROTOTYPE_ENGINE_HOME)/jars
PROTOTYPE_LIB_DIR = $(NARWHAL_PROTOTYPE_ENGINE_HOME)/lib



##??  all: $(NAILGUN_JAR) $(NAILGUN_CLIENT) $(DIRS)

.PHONY: clean pristine


$(NAILGUN_INSTALL_DIR):
	svn co $(NAILGUN_SVN_REPO_URL)/$(NAILGUN_SVN_BRANCH) $(NAILGUN_INSTALL_DIR)


$(LIB_DIR):
	mkdir -p $(LIB_DIR)
	ln -s $(PROTOTYPE_LIB_DIR)/* $(LIB_DIR)/

$(JARS_DIR):
	mkdir -p $(JARS_DIR)
	ln -s $(PROTOTYPE_JARS_DIR)/* $(JARS_DIR)/

$(BIN_DIR):
	mkdir -p $(BIN_DIR)

$(NAILGUN_JAR): $(JARS_DIR) $(NAILGUN_INSTALL_DIR)
	cd $(NAILGUN_INSTALL_DIR) && ant;
	ln -s $(NAILGUN_INSTALL_JAR) $(NAILGUN_JAR);

$(NAILGUN_CLIENT): $(BIN_DIR) $(NAILGUN_INSTALL_DIR)
	$(MAKE) -C $(NAILGUN_INSTALL_DIR) ng;
	ln -s $(NAILGUN_INSTALL_DIR)/ng $(NAILGUN_CLIENT);


clean:
	for dir in $(LIB_DIR) $(JARS_DIR) $(BIN_DIR); do \
	    rm "$$dir"/*; \
	    rmdir "$$dir"; \
	done;
	$(MAKE) -C "$(NAILGUN_INSTALL_DIR)" clean

pristine: clean
	rm -rf "$(NAILGUN_INSTALL_DIR)/"
