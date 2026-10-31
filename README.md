# CSCI461 Assignment 1

Nile University, Fall 2026. The project is the dockerized SMS analysis from the assignment sheet.

Three of us:

- Omar Tarek: the image, how to run it, and this file
- Hamza: section 4, loading and cleaning the data
- Abdelrahman: sections 5 and 6, the text work and both models

We are using dataset 1, the SMS Spam Collection, from the UCI page https://archive.ics.uci.edu/dataset/228/sms+spam+collection. The file UCI ships is tab-separated and has no header. I turned it into `data/dataset.csv` with two columns, `label` and `text`, and left the messages as they are. 5,574 rows: 4,827 ham and 747 spam. Hamza can use those numbers to check he loaded the right file.

`notebook/analysis.ipynb` has the data section, the text section, and both models. It has to run inside the container. A run that only works on the laptop does not count. Kernel, Restart and Run All, and the files in `output/` have to be there afterwards.

## Layout

```text
bd-a1/
├── Dockerfile
├── requirements.txt
├── README.md
├── data/
│   └── dataset.csv
├── notebook/
│   └── analysis.ipynb
├── output/
│   └── figures/
└── screenshots/
```

This repository is that folder. After you clone it, you are already in `bd-a1` even if the clone is still named `big-data-Assignment-1`.

## Image and container

`docker build` makes an image. Ours starts from `quay.io/jupyter/scipy-notebook:latest`, then installs whatever is in `requirements.txt`, then copies the dataset and the notebook into `/home/jovyan/bd-a1`. The image is just those layers stored on disk. Nothing is executing yet.

`docker run` starts a container, which is one running copy of the image. Stopping or deleting the container does not delete the image, so you can start a new container from it. Anything written inside the container is gone when the container is removed, except files written under the `output/` folder, because that folder is mounted from the host.

## `-p 8888:8888`

The order is `HOST_PORT:CONTAINER_PORT`.

The right-hand `8888` is where JupyterLab listens inside the container. The scipy-notebook image uses 8888, so that side stays 8888. The left-hand `8888` is the port on your machine. A browser on `http://127.0.0.1:8888` is forwarded to port 8888 in the container.

If port 8888 is already taken on the laptop, change only the host side, for example `-p 8889:8888`, and open `http://127.0.0.1:8889`. Jupyter inside the container is still on 8888.

## Build

Docker has to be running. From this folder:

```bash
docker build -t bd-a1:latest .
```

The first build pulls the base image, so it is slow. Rebuild after any change to the Dockerfile, `requirements.txt`, the dataset, or the notebook, because those are copied in at build time.

The base image already has numpy, pandas, matplotlib, seaborn and scikit-learn. If the notebook needs another package, add it to `requirements.txt` and build again. Installing it with pip inside a running container does not stick.

## Run, with output kept on the host

```bash
mkdir -p output/figures

docker run --name bd-a1 \
  -p 8888:8888 \
  -v "$(pwd)/output:/home/jovyan/bd-a1/output" \
  bd-a1:latest
```

Leave that terminal open. The log prints a link with a token:

```text
http://127.0.0.1:8888/lab?token=...
```

Open it, then open `notebook/analysis.ipynb`.

The `-v` flag is a bind mount. The part before the colon is the `output/` folder of this project on the host. The part after the colon is the same folder inside the container. Save the results there:

- `output/cleaned_data.csv` when the kernel's working directory is `/home/jovyan/bd-a1`
- `../output/cleaned_data.csv` when the working directory is the `notebook` folder

Figures go in `output/figures/`.

A bind mount is a normal folder you can see next to the Dockerfile. A volume is storage Docker keeps for itself, and it does not show up in the project folder. The assignment wants the csv, the figures and the text files still on the machine after `docker rm`, so this is a bind mount, not a volume.

The notebook user inside the image is `jovyan`, uid 1000. If saving a file fails with a permission error, on the host:

```bash
sudo chown -R 1000:1000 output
```

### The files are still there after the container is gone

With the container running:

```bash
docker exec bd-a1 bash -lc 'echo "still here" > /home/jovyan/bd-a1/output/mount_check.txt'
```

Then:

```bash
docker stop bd-a1
docker rm bd-a1
```

`output/mount_check.txt` should still be in the project folder. Delete it after you have checked. `cleaned_data.csv`, the figures, `model_metrics.txt` and `cluster_summary.txt` stay the same way once the notebook writes them.

## Showing the container is actually there

These were taken on this machine while `bd-a1` was running. They are already in `screenshots/`.

- `docker-build.png`, the build finishing
- `docker-images.png`
- `docker-ps.png`, the container running, port 8888
- `docker-ps-a.png`
- `docker-logs.png`, JupyterLab starting inside the container
- `docker-inspect.png`, the port mapping and the `output/` mount
- `jupyter-notebook.png`, the notebook open in JupyterLab
- `jupyter-word-frequency.png`, `jupyter-group-comparison.png`, `jupyter-classifier.png`, `jupyter-kmeans-choice.png`, and `jupyter-kmeans.png`, the text section and both models

```bash
docker images
docker ps
docker ps -a
docker logs bd-a1
docker inspect bd-a1
```

`docker images` is the built image. `docker ps` is what is running. `docker ps -a` also lists containers that have exited. `docker logs` is the Jupyter link if you missed it. `docker inspect` shows the port mapping and the `output/` mount. In that JSON, `HostConfig.PortBindings` should have `8888/tcp` pointing at host port 8888, and `Mounts` should have the bind of `output`.

## Docker Hub

The image is on Docker Hub.

Repository: `morat22/bd-a1`
Tag: `csci461-a1`

```bash
docker tag bd-a1:latest morat22/bd-a1:csci461-a1
docker login
docker push morat22/bd-a1:csci461-a1
```

That tag is already pushed. Hamza or Abdelrahman pulls it on their own machine and runs it. The person who pushed does not do the pull check.

They clone this repo so they have an `output/` folder to mount, then:

```bash
docker pull morat22/bd-a1:csci461-a1
mkdir -p output/figures
docker run --name bd-a1 \
  -p 8888:8888 \
  -v "$(pwd)/output:/home/jovyan/bd-a1/output" \
  morat22/bd-a1:csci461-a1
```

The dataset and the notebook are already inside the image. The mount is still required, or the results vanish with the container.

## From a clean machine

1. Install Docker and start it.
2. Clone the repo and enter the folder.
3. `docker build -t bd-a1:latest .`
4. `mkdir -p output/figures`
5. Run the `docker run` command from the section above.
6. Copy the token URL out of the log and open it.
7. Open `notebook/analysis.ipynb` and use Kernel, Restart and Run All.

## What the notebook has to leave in `output/`

The build does not create these. The notebook writes them. They are already in `output/` from the run inside the container.

- `output/cleaned_data.csv`
- at least four figures in `output/figures/`: correlation heatmap, word-frequency chart, group comparison, confusion matrix
- `output/model_metrics.txt`
- `output/cluster_summary.txt`

## Zip

When Restart and Run All works inside the container and those files are in `output/`, rename this folder to `bd-a1` if it is not already, and from the parent folder:

```bash
zip -r bd-a1.zip bd-a1 -x 'bd-a1/.git/*'
```

The UCI collection can be shared, so `data/dataset.csv` stays in the zip. Screenshots go in `screenshots/` before you zip.
