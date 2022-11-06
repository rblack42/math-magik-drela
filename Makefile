XFOILURL = https://web.mit.edu/drela/Public/web/xfoil
XFOILTAR = xfoil6.99.tgz
QPROPURL = https://web.mit.edu/drela/Public/web/qprop/
QPROPTAR = qprop1.22.tar.gz

# fetch copy of master XFoil and QProp codes from MIT
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


.PHONY: venv
venv:
	echo 'layout python3' > .envrc && \
		direnv allow

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

.PHONY: run
run:
	cd project && \
		uvicorn app.main:app --reload

.PHONY: nb
nb:
	cd book && \
		jupyter notebook
