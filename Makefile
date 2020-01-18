help:
	@echo 'Usage:                                                                    '
	@echo '   make rebuild                       rebuild images for spark            '
	@echo '       																	 '

rebuild:
	docker build -f Dockerfile -t spark-base .
	docker build -f Dockerfile.master -t spark-master .
	docker build -f Dockerfile.worker -t spark-worker .