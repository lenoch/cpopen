VERSION=1.2.3
NAME=cpopen
FULL_NAME=${NAME}-${VERSION}
TAR_FILE=${FULL_NAME}.tar.gz

SOURCESDIR=${HOME}/rpmbuild/SOURCES/

SPECFILE=python-cpopen.spec

DIST=dist

TAR_DIST_LOCATION=${DIST}/${TAR_FILE}
TAR_RPM_LOCATION=${SOURCESDIR}/${TAR_FILE}

all: ${TAR_DIST_LOCATION}

.PHONY: build rpm srpm ${TAR_DIST_LOCATION}

build:
	python setup.py build

$(TAR_DIST_LOCATION):
	mkdir -p dist
	python setup.py sdist

${TAR_RPM_LOCATION}: ${TAR_DIST_LOCATION}
	cp "$<" "$@"

srpm: ${SPECFILE} $(TAR_RPM_LOCATION)
	rpmbuild -bs python-cpopen.spec

rpm: ${SPECFILE} ${TAR_RPM_LOCATION}
	rpmbuild -ba python-cpopen.spec

clean:
	python setup.py clean
	rm -rf $(DIST)
	rm -rf build
