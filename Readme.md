# GPU for Synthseg

## Freesurfer 7.4.1
- python version: 3.8.13
- tensorflow: 2.12.0
- CUDA version needed: 11.8 [1]

## Docker
Nvidia CUDA image docker hub: https://hub.docker.com/r/nvidia/cuda

`devel` image selected. Built from `runtime` which contains CUDA runtime (cudard), CUDA math libraries, NCCL, cuDNN and possibly TensorRT. `devel` also adds headers, development tools for building CUDA images.

- Link to the 11.8 devel image: [hub.docker.com](https://hub.docker.com/layers/nvidia/cuda/11.8.0-cudnn8-devel-ubuntu22.04/images/sha256-bd746eb3b9953805ebe644847a227e218b5da775f47007c69930569a75c9ad7d)
  - nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04
  - sha256:8f9dd0d09d3ad3900357a1cf7f887888b5b74056636cd6ef03c160c3cd4b1d95
  
## Prerequisite
The Nvidia container toolkit need to be installed. Installation guide is here:  [docs.nvidia.com](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html)

## How to run
Freesurfer is not provided in this image (due to its size). Instead, it is addded as a volume from the host machine. Docker or docker-compose can be used to run the container.

The container will be run interactively with a bash session opened. Freesurfer binaries will be added to the path, so synthseg can be run directly with `mri_synthseg`. 

The container can be modified to run Synthseg automatically on a list of images given as argument (future improvement if helpful).

### docker-compose
#### Configuration
- If the `$FREESURFER_HOME` env variable is not set on the host machine, replace the value to the actual path to the freesurfer installation folder on the host. (line 14, in volumes)
- Optionally, uncomment line 15 and add a volume to share data with the container. If you don't, you won't have data to run synthseg on.
#### Build
- Within the directory, run 
  - `docker-compose build`
#### Run
- `docker-compose run freesurfer_cuda_1`

### Docker
#### Build
- Within the directory, run 
  - `docker build . -f Dockerfile -t freesurfer_cuda_1 --build-arg FREESURFER_BIN=/freesurfer/bin`
#### Run
- Edit the `/path/to/data` in the command below before running it
- `docker run --gpus all -it -v $FREESURFER_HOME:/freesurfer -v {/path/to/data}:/data freesurfer_cuda_1`

## Ref
[1] https://www.tensorflow.org/install/source#gpu
