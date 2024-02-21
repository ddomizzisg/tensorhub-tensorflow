# Use the official TensorFlow image as the base image
FROM tensorflow/tensorflow:2.7.0

RUN apt-get update && apt-get install nodejs npm -y

RUN python3 -m pip install jupyterhub
RUN npm install -g configurable-http-proxy

# Install JupyterHub and set up some dependencies
RUN pip install jupyterlab notebook

# Set up a non-root user to run JupyterHub
RUN useradd -m jupyter

RUN echo 'jupyter:prueba1234' | chpasswd

# Switch to the non-root user
USER jupyter

# Set the working directory
WORKDIR /home/jupyter

# Expose the JupyterHub port
EXPOSE 8000

# Set the entry point for JupyterHub
CMD ["jupyterhub", "--ip=0.0.0.0", "--port=8000"]
