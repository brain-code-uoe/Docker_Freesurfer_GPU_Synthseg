FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04@sha256:8f9dd0d09d3ad3900357a1cf7f887888b5b74056636cd6ef03c160c3cd4b1d95
#FROM nvidia/cuda:12.2.2-cudnn8-devel-ubuntu22.04

ARG FREESURFER_BIN
ENV PATH=$PATH:$FREESURFER_BIN

CMD ["/bin/bash"]
