XFOILURL = https://web.mit.edu/drela/Public/web/xfoil
XFOILTAR = xfoil6.99.tgz
QPROPURL = https://web.mit.edu/drela/Public/web/qprop/
QPROPTAR = qprop1.22.tar.gz

# fetch copy of master XFoil and QProp codes from MIT ==========
.PHONY: fetch
fetch: master/$(QPROPTAR) master/$(XFOILTAR)

master/$(QPROPTAR):
	curl $(QPROPURL)/$(QPROPTAR) -o $@
	echo "installed Qprop"

master/$(XFOILTAR):
	curl $(XFOILURL)/$(XFOILTAR) -o $@
	echo "installed XFoil"

.PHONY:	unpack
unpack:	 master/$(QPROPTAR) master/$(XFOILTAR)
	cd master && \
		tar zxvf $(QPROPTAR) && \
		tar zxvf $(XFOILTAR)

# Virtual environment with direnv ========================
.PHONY: venv
venv:
	python3 -m venv

.PHONY: init
init:
	pip install -U pip
	pip install pip-tools

.PHONY: reqs
reqs:
	pip-compile
	pip install -r requirements.txt
	jupyter contrib nbextensions install
	cp ~/_sys/tikzmagic.py .direnv/python-3.10.8/lib/python3.10/site-packages

# jupyter book management ===================================================

.PHONY: book
book:
	jb build book

.PHONY: nb
nb:
	cd book && \
		jupyter notebook

# FastAPI/Docker management =================================================
.PHONY: run
run:
	cd project && \
		uvicorn app.main:app --reload

.PHONY: docker_up
docker_up:
	docker-compose up -d --build

.PHONY: docker_stop
docker_stop:
	docker-compose down

.PHONY: docker_clean
docker_clean:
	docker system prune -a

.PHONY: shell_db
shell_db:
	docker-compose exec web-db psql -U postgres

.PHONY: shell_web
shell_web:
	docker-compose  exec -it web /bin/bash	
	
.PHONY: db_logs
db_logs:
	docker-compose logs web-db

.PHONY: test
test:
	docker-compose exec web python -m pytest -v

.PHONY: web_log
web_log:
	docker-compose logs web
