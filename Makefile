build:
	@stack build
	@BINARY_PATH=${BINARY_PATH_RELATIVE} docker-compose build
