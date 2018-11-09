FROM python:3.7

RUN apt-get update -y && apt-get install -y nano poppler-utils imagemagick libopenblas-dev ghostscript sqlite3 sudo

RUN mkdir -p /arxiv
WORKDIR /arxiv

COPY requirements.txt /arxiv
RUN pip install --no-cache-dir -r requirements.txt
COPY . /arxiv

RUN mkdir -p /arxiv/data
RUN mkdir -p /arxiv/info
RUN ln -s data/txt data/pdf data/db.p data/db2.p data/tfidf_meta.p data/sim_dict.p data/user_sim.p data/tfidf.p data/search_dict.p data/as.db data/secret_key.txt . && ln -s ../data/thumbs static/

EXPOSE 8080

VOLUME [ "/arxiv/data", "/arxiv/info", "/arxiv/static/thumbs" ]

ENTRYPOINT ["./docker.sh"]
CMD ["python", "serve.py", "--port", "8080"]

