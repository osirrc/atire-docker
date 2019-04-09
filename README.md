JASS Docker image for the SIGIR OSIRRC 2019 Open Source Challenge.

For details on how JASS search differs from ATIRE see (and please cite)

J. Lin, A. Trotman (2015), Anytime Ranking for Impact-Ordered Indexes, Proceedings of the 2015 International Conference on The Theory of Information Retrieval (ICTIR 2015), pp. 301-304



#first git clone the jig repo then git clone this repo
# to build trec_eval and to download the topics and assessments:

./init.sh

# to build the Docker image use:

docker build . -t andrewtrotman/osirrc2019

# to use the jig to build ATIRE and index the collection use:

python3 run.py prepare --repo andrewtrotman/osirrc2019 --tag latest --collections robust04=/Users/andrew/programming/JASSv2/docker/osirrc2019/robust04

# to instruct ATIRE to do a run and measure the precison use:

python3 run.py search --repo andrewtrotman/osirrc2019 --collection robust04 --topic topics.robust04.301-450.601-700.txt  --output /Users/andrew/programming/osirrc2019/jass-docker/output --qrels qrels/qrels.robust2004.txt

