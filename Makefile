MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))

connect-claude:
	-rm ~/.claude/settings.json
	ln -s $(MKFILE_DIR)claude/settings.json ~/.claude/settings.json
	-rm ~/.claude/CLAUDE.md
	ln -s $(MKFILE_DIR)claude/claude.prompt.root.md ~/.claude/CLAUDE.md
	-rm ~/.claude/hooks
	ln -s $(MKFILE_DIR)claude/hooks ~/.claude/hooks
