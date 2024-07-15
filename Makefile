.PHONY: aks-warning

ask-warning:
	@echo "This operation will delete the code under development in the current directory. Do you wish to continue? [y/N]" && read ans && [ $${ans:-N} = y ]

init: ask-warning
	docker build --no-cache -t setup_rails . && \
	echo "Running rails new command in docker container..."; \
	docker run -v $(PWD):/myapp setup_rails rails new . --force

up:
	docker build -t myrailsapp .
	docker run -p 3000:3000 -e RAILS_ENV=development --rm myrailsapp ./bin/rails server -b 0.0.0.0

