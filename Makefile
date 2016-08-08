DOCKER_IMAGE = 'kbai/docr-cnc'
CP = cp -rf
RM = rm -rf
MKDIR = mkdir -p

.PHONY: build-docker
build-docker:
	$(RM) "$@"
	$(MKDIR) "$@"
	$(CP) Dockerfile node_modules src package.json "$@"
	$(RM) $@/node_modules/docr-common
	$(CP) ../docr-common $@/node_modules
	$(RM) $@/node_modules/docr-common/.git
	cd $@ && docker build -t $(DOCKER_IMAGE) .
