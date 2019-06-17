<!--
./init.sh
docker build . -t atire/osirrc2019
python3 run.py prepare --repo atire/osirrc2019 --collections robust04=/Users/andrew/programming/JASSv2/docker/osirrc2019/robust04=trectext
python3 run.py search  --repo atire/osirrc2019 --collection robust04 --topic topics.robust04.301-450.601-700.txt --top_k 100 --output /Users/andrew/programming/osirrc2019/jass-docker/output --qrels qrels/qrels.robust2004.txt
-->

# OSIRRC Docker Image for ATIRE
[![Generic badge](https://img.shields.io/badge/DockerHub-go%21-yellow.svg)](https://hub.docker.com/r/osirrc2019/atire)
[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.3247156.svg)](https://doi.org/10.5281/zenodo.3247156)

[**Andrew Trotman**](https://github.com/andrewtrotman)

This is the docker image for [ATIRE](http://atire.org) conforming to the [OSIRRC jig](https://github.com/osirrc/jig/) for the [Open-Source IR Replicability Challenge (OSIRRC) at SIGIR 2019](https://osirrc.github.io/osirrc2019/).
This image is available on [Docker Hub](https://hub.docker.com/r/osirrc2019/atire).
The [OSIRRC 2019 image library](https://github.com/osirrc/osirrc2019-library) contains a log of successful executions of this image.

+ Supported test collections: `robust04`, and `core17`.
+ Supported hooks: `init`, `index`, `search`

## Quick Start

The following `jig` command can be used to index TREC disks 4/5 for `robust04`:

```
python3 run.py prepare \
  --repo osirrc2019/atire \
  --tag 0.1.0 \
  --collections robust04=/path/to/disk45=trectext
```
e.g. ```python3 run.py prepare --repo osirrc2019/atire --collections robust04=/Users/andrew/programming/JASSv2/docker/osirrc2019/robust04=trectext```


The following `jig` command can be used to perform a retrieval run on the collection with the `robust04` test collection.

```
python3 run.py search \
  --repo osirrc2019/atire \
  --tag 0.1.0 \
  --output out/atire \
  --qrels qrels/qrels.robust04.txt \
  --topic topics/topics.robust04.txt \
  --collection robust04 \ 
  --top_k 100"
```

For example:

```
python3 run.py search --repo osirrc2019/atire --collection robust04 \
 --topic topics/topics.robust04.txt --top_k 100 \
 --output /Users/andrew/programming/osirrc2019/jass-docker/output --qrels qrels/qrels.robust04.txt
 ```

## Retrieval Methods
BM25, BM25+ with s-stemming an Rocchio relevance feedback.  Currently hard coded to the collection.

## Expected Results

The following numbers should be able to be re-produced using the scripts provided by the jig.

### robust04
[TREC 2004 Robust Track Topics](http://trec.nist.gov/data/robust/04.testset.gz).
+ **BM25+**: k1=2.0, b=0.5, d=0.2 with Rocchio relevance feedback with d=2, t=81, then BM25+  k1=1.1, b=0.6, d=0.6.  All with s-stemming

|Metric | Score |
|----|----|
| MAP | 0.2184 |
| P@30 | 0.3199 |

### core17
[TREC 2017 Common Core Track Topics](https://trec.nist.gov/data/core/core_nist.txt).
+ **BM25**: k1=0.9, b=0.4 (Robertson et al., 1995) 

|Metric | Score |
|----|----|
| MAP | 0.1436 |
| P@30 | 0.4087 |

## Implementation

The following is a quick breakdown of what happens in each of the scripts in this repo.

### Dockerfile

The `Dockerfile` installs dependencies (`python3`, etc.), copies scripts to the root dir, and sets the working dir to `/work`.

### init

The `init` [script](init) is straightforward - it's simply a shell script (via the `#!/usr/bin/env sh` she-bang) that downloads and builds ATIRE.

### index

The `index` Python [script](index) (via the `#!/usr/bin/python3` she-bang) reads a JSON string (see [here](https://github.com/osirrc/jig#index)) containing at least one collection to index (including the name, path, and format).
The collection is indexed and placed in the current working directory (i.e., `/work`).
At this point, `jig` takes a snapshot and the indexed collections are persisted for the `search` hook.

### search

The `search` [script](search) reads a JSON string (see [here](https://github.com/osirrc/jig#search)) containing the collection name (to map back to the index directory from the `index` hook) and topic path, among other options.
The retrieval run is performed and output is placed in `/output` for the `jig` to evaluate using `trec_eval`.

## References

+ S. E. Robertson, S. Walker, M. Hancock-Beaulieu, M. Gatford, and A. Payne. (1995) Okapi at TREC-4. _TREC_
+ A. Trotman, X.-F Jia, M. Crane (2012), Towards an Efficient and Effective Search Engine, Proceedings of the SIGIR 2012 Workshop on Open Source Information Retrieval, pp. 40-47
+ Y. Lv, CX. Zhai (2011) Lower-Bounding Term Frequency Normalization, Proceedings of CIKM'11, pp. 7-16

## Reviews

+ Documentation reviewed at commit [`480b2f7`](https://github.com/osirrc/atire-docker/commit/2a83e39c3900be9b88907b901e2d1d211480b2f7) (2019-06-16) by [r-clancy](https://github.com/r-clancy/).
