FROM guilhermealles/mpich-debian:onbuild

# # ------------------------------------------------------------
# # Build MPI project
# # ------------------------------------------------------------

# Put all build steps and additional package installation here

# Note: the current directory is ${WORKDIR:=/project}, which is
# also the default directory where ${USER:=mpi} will SSH login to

# Copy the content of `project` directory in the host machine to 
# the current working directory in this Docker image
COPY project/ .

COPY ssh/* /home/mpi/.ssh/
COPY ssh/id_rsa.pub /home/mpi/.ssh/authorized_keys
RUN sudo chown mpi:mpi /home/mpi/.ssh
RUN sudo chown mpi:mpi /home/mpi/.ssh/*
RUN sudo apt-get install -y libxml2-dev libxslt1-dev

# Normal build command
USER mpi

RUN git clone https://gitlab.inria.fr/simgrid/platform-calibration.git
RUN cd platform-calibration/src/calibration && make clean && make
RUN cp ./random_sizes ./platform-calibration/
ENV FOLDER /project/platform-calibration
ENV DATAFOLDER ''

# ####################
# For Docker beginner:

# After Docker syntax `RUN`, you can execute any command available in 
# the current shell of the image.

# To switch to root:    USER root
# To switch back to default user: USER ${USER}
