#!/usr/bin/env python3

import zlib
import hashlib
from sys import argv


def ref_path(ref):
    dir, rest = ref[:2], ref[2:]
    return dir + '/' + rest


def hash(content):
    return hashlib.sha1(content).hexdigest()


def decompress(path):
    with open(path, 'rb') as compressed:
        return zlib.decompress(compressed.read())

if __name__ == "__main__":
    ref = argv[1]
    path = ".git/objects/" + ref_path(ref)
    content = decompress(path)
    print(content)
    assert ref == hash(content)
