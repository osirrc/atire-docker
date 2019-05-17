docker build . -t atire/osirrc2019r04
python3 run.py prepare --repo atire/osirrc2019r04 --collections robust04=/Users/andrew/programming/JASSv2/docker/osirrc2019/robust04=trectext
python3 run.py search  --repo atire/osirrc2019r04 --collection robust04 --topic topics.robust04.301-450.601-700.txt --top_k 100 --output /Users/andrew/programming/osirrc2019/jass-docker/output --qrels qrels/qrels.robust2004.txt

