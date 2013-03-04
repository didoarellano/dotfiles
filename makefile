FILES=$(shell find ${PWD} -name "*.link")

link:
	@for file in $(FILES);\
		do echo "";\
		link=${HOME}/.`basename $$file .link`;\
		echo "FILE: $$file";\
		echo "LINK: $$link";\
		ln -sf $$file $$link;\
		file $$link;\
	done;
	@echo ""
