FROM nvidia/cuda:12.4.1-runtime-ubuntu22.04

ENV DEBIAN_FRONTEND=noninteractive

# (1) 最小系統工具 + CA 憑證
RUN apt-get update && apt-get install -y --no-install-recommends \
      ca-certificates curl wget git bzip2 && \
    rm -rf /var/lib/apt/lists/*

# (2) 安裝 Miniforge3
RUN curl -L -o /tmp/miniforge.sh \
    https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh && \
    bash /tmp/miniforge.sh -b -p /opt/conda && \
    rm /tmp/miniforge.sh
ENV PATH=/opt/conda/bin:$PATH

# (3) 建立 Conda 環境
COPY environment.yml /tmp/environment.yml
RUN mamba env create -f /tmp/environment.yml && mamba clean -afy
ENV PATH=/opt/conda/envs/ml/bin:$PATH

# (4) 預設進入 JupyterLab
SHELL ["conda", "run", "-n", "ml", "/bin/bash", "-c"]
WORKDIR /workspace
EXPOSE 8888
CMD ["jupyter", "lab", "--ip=0.0.0.0", "--no-browser", "--allow-root"]
