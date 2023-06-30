FROM python:3.8-slim

# create working folder nd install -r requirements.txt
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# copy app content 
COPY service/ ./service/

# create non-root user
RUN useradd --uid 1000 theia && chown -R theia /app
USER theia

# run the service
EXPOSE 8080
CMD ["gunicorn", "--bind=0.0.0.0:8080", "--log-level=info", "service:app"]