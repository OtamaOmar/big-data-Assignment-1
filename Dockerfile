FROM quay.io/jupyter/scipy-notebook:latest

# extra packages, if we add any, come from requirements.txt
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt

USER root
RUN mkdir -p /home/jovyan/bd-a1/output/figures
COPY data/ /home/jovyan/bd-a1/data/
COPY notebook/ /home/jovyan/bd-a1/notebook/
RUN chown -R ${NB_UID}:${NB_GID} /home/jovyan/bd-a1
USER ${NB_UID}

WORKDIR /home/jovyan/bd-a1

# JupyterLab file browser starts in the project folder
CMD ["start-notebook.py", "--ServerApp.root_dir=/home/jovyan/bd-a1"]
