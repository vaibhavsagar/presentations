Git Internals
=============

This is a 5-minute (hopefully) talk on `git` internals.

# Steps
1. Show contents of `display_object.py`. Leave open in `tmux`.
1. `alias show="~/Documents/git-internals/display_object.py"`
1. Navigate to the root of a git repository.
1. `ls .git/objects`
1. `cat .git/HEAD`
1. Explain that this used to be a symlink but was changed to run on other
   platforms.
1. `cat .git/refs/heads/master`
1. Explain that this is a SHA1 hash/object reference/ref. Copy ref.
1. `git cat-file -p <ref>`
1. `git cat-file -p HEAD`
1. Explain `git cat-file -p` for pretty-printing an object.
1. Explain tree, parent(s), author/committer, message.
1. `show <ref>`
1. Explain how each object has its type and length in the header.
1. Change script to decode bytestring.
1. Copy tree ref. Explain that this is the root of the repository.
1. `git cat-file -p <tree-ref>`
1. Explain about trees and blobs.
1. Try `show <tree-ref>`
1. Explain about byte/hex representation.
1. Remove ".decode()" from script.
1. Copy a blob ref from `git cat-file -p <tree-ref>`
1. `git cat-file -p <blob-ref>`
1. `show <blob-ref>`
1. `git show-ref --tags`
1. Copy tag ref.
1. `git cat-file -p <tag-ref>`
1. `show <tag-ref>`
1. Conclude by mentioning commit/tree/blob/tag objects, refs, and
   HEAD/(refs/heads/master)
1. If time remains, talk about `git` storing every version of every
   file/directory until the repo gets too big and everything is further
   compressed into a packfile.
