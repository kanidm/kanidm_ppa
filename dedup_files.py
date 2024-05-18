#!/usr/bin/env python3


from dataclasses import dataclass
from datetime import datetime
import os
import re

matcher = re.compile(
    "".join(
        [
            r"^(?P<package>[a-z0-9-]+)_",
            r"(?P<distro>[\w\d]+_[\w\d\.]+)_",
            r"(?P<version>[\d\.\w]+)\.",
            r"(?P<datestamp>\d{12})",
            r"%2B",
            r"(?P<commit>[a-f0-9]{7})_",
            r"(?P<arch>[\w\d_]+)\.deb$",
        ]
    )
)


@dataclass
class MetaData:
    package: str
    distro: str
    version: str
    datestamp: str | datetime
    commit: str
    arch: str
    filename: str


for basedir in ["ubuntu", "debian"]:
    packages = []
    arches = []
    metas = []
    for filename in sorted(os.listdir(basedir)):
        if not filename.endswith(".deb"):
            continue
        meta = MetaData(**matcher.match(filename).groupdict(), filename=filename)
        meta.datestamp = datetime.strptime(meta.datestamp, "%Y%m%d%H%M")

        if meta.package not in packages:
            packages.append(meta.package)

        if meta.arch not in arches:
            arches.append(meta.arch)

        metas.append(meta)

    start_list_len = len(metas)

    # for each seen package and arch combination
    for arch in arches:
        for package in packages:
            # get the list of metas for this package and arch
            package_metas = [
                meta for meta in metas if meta.package == package and meta.arch == arch
            ]
            # sort the list by datestamp
            package_metas.sort(key=lambda x: x.datestamp)
            # remove all but the last ten
            package_metas = package_metas[-10:]
            # only leave the files to be removed
            for meta in package_metas:
                metas.remove(meta)

    print(
        "removing {} from {} files in {}".format(
            start_list_len - len(metas), start_list_len, basedir
        )
    )
    for meta in metas:
        os.remove(os.path.join(basedir, meta.filename))
        print("Removed {}".format(os.path.join(basedir, meta.filename)))
