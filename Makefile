help:
	@echo 'Usage:                                                                    '
	@echo '   make rebuild                       rebuild images for spark            '
	@echo '       																	 '

rebuild:
	docker build -f dockers/Dockerfile -t spark-base .
	docker build -f dockers/Dockerfile.master -t spark-master .
	docker build -f dockers/Dockerfile.worker -t spark-worker .
