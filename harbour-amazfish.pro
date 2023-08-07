TEMPLATE = subdirs
CONFIG += ordered

SUBDIRS = lib daemon ui

CONFIG(click) {
    SUBDIRS += click
}

DISTFILES += \
    rpm/harbour-amazfish.changes.in \
    rpm/harbour-amazfish.changes.run.in \
    rpm/harbour-amazfish.spec \
    README.md \
    LICENSE \
    documentation/build-instructions.md


