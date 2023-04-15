FROM python
WORKDIR /app
RUN pip install --upgrade pip
RUN python -m pip install colorama
COPY FHW.py FHW.py
CMD ["python3", "FHW.py", "run", "--host=0.0.0.0"]