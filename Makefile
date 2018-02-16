build:
	@docker build . -t mis-dies

test:
	@docker run --rm -it \
	 --entrypoint '' \
	 --env-file ./.env \
	 -v `pwd`:/app \
	 mis-dies bundle exec rspec
