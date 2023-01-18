FROM python:3.10

ENV PYTHONUNBUFFERED=TRUE

COPY . /app
RUN pip --no-cache-dir install pipenv
WORKDIR /app

RUN apt-get update
RUN python -m venv /app/venv
# Enable venv
ENV PATH="/app/venv/bin:$PATH"
RUN . /app/venv/bin/activate

RUN apt install -y libgl1-mesa-glx
RUN apt install -y ffmpeg
RUN pip install --upgrade pip
RUN pip install -r requirements.txt
RUN python -m pip install --upgrade pip
RUN pip install torch==1.12.1+cu116 torchvision==0.13.1+cu116 --extra-index-url "https://download.pytorch.org/whl/cu116"
RUN pip install transformers==4.25.1
RUN pip install diffusers[torch]==0.10.2
RUN pip install pynvml==11.4.1
RUN pip install bitsandbytes==0.35.0
RUN git clone https://github.com/DeXtmL/bitsandbytes-win-prebuilt tmp/bnb_cache
RUN pip install ftfy==6.1.1
RUN pip install aiohttp==3.8.3
RUN pip install tensorboard>=2.11.0
RUN pip install protobuf==3.20.1
RUN pip install wandb==0.13.6
RUN pip install pyre-extensions==0.0.23
RUN pip install -U -I --no-deps https://github.com/C43H66N12O12S2/stable-diffusion-webui/releases/download/f/xformers-0.0.14.dev0-cp310-cp310-win_amd64.whl
RUN pip install "xformers-0.0.15.dev0+affe4da.d20221212-cp38-cp38-win_amd64.whl" --force-reinstall
RUN pip install pytorch-lightning==1.6.5
RUN pip install OmegaConf==2.2.3
RUN pip install numpy==1.23.5
RUN pip install keyboard
RUN pip install Flask==2.2.2
RUN python utils/patch_bnb.py
RUN python utils/get_yamls.py

ENTRYPOINT ["python3","main.py"]
#Done
