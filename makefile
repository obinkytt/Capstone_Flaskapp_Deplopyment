setup:
	# Create python virtualenv & source it
	# source ~/.devops/bin/activate
	python3 -m venv ~/.devops

install:
	# This should be run from inside a virtualenv
	pip install --upgrade pip &&\
		pip install -r requirements.txt

test:
	# Additional, optional, tests could go here
	#python -m pytest -vv --cov=myrepolib tests/*.py
	#python -m pytest --nbval notebook.ipynb
    @cd tests; pytest -vv --cov-report term-missing --cov=web test_*.py


lint:
	# See local hadolint install instructions:   https://github.com/hadolint/hadolint
	# This is linter for Dockerfiles
	hadolint Dockerfile
	# This is a linter for Python source code linter: https://www.pylint.org/
	# This should be run from inside a virtualenv
	# pylint --disable=R,C,W1203,W1202 app.py
	pylint --load-plugins pylint_flask --disable=R,C app/*.py

all: install lint test

validate-circleci:
    circleci config process .circleci/config.yml

run-circleci-local:
    circleci local execute

    # List the environment versions
	env:           
	which python3
	python3 --version
	which pytest
	which pylint
	
    # Build the docker image and list available docker images
docker-build:  
	docker build -t maweeks/devops .
	docker image ls

    # Upload the docker image to AWS
docker-upload: 
	$ (aws ecr get-login --no-include-email --region us-east-1)
	docker tag nano-devops-05:latest 119841056280.dkr.ecr.us-east-1.amazonaws.com/nano-devops-05:latest
	docker push 119841056280.dkr.ecr.us-east-1.amazonaws.com/nano-devops-05

  # Run the python application locally
start-api:     
	python web.py
	python app.py

all: install lint test
