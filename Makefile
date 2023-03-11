.PHONY: init multipass-start multipass-stop
.SILENT:

init:
	python3 -m pip install --upgrade pip setuptools poetry
	poetry install

multipass-start:
	@multipass launch -n cuda-test --cloud-init multipass/cloud-init.yaml --memory 2G --disk 10G --cpus 1
	@echo "\MULTIPASS VM RUNNING\n===============\n\n"
	@multipass list

multipass-stop:
	@multipass delete -p cuda-test