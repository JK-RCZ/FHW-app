FROM python:3.8-slim-buster
WORKDIR /app
RUN pip3 install -r time
RUN pip3 install -r colorama
COPY FHW.py FHW.py
CMD ["python3", "-m" , "FHW.py", "run", "--host=0.0.0.0"]