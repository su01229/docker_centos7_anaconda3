# We will use Centos7 for our image
FROM centos:7

# Updating packages
RUN yum -y update

# Adding wget and bzip2
RUN yum install -y wget bzip2

# Anaconda installing
RUN wget https://repo.anaconda.com/archive/Anaconda3-2020.07-Linux-x86_64.sh
RUN bash Anaconda3-2020.07-Linux-x86_64.sh -b -p /opt/anaconda3
RUN rm Anaconda3-2020.07-Linux-x86_64.sh

# Set path to conda
ENV PATH /opt/anaconda3/bin:$PATH

# Updating Anaconda packages
RUN conda update conda
RUN conda update anaconda
RUN conda update --all

# Configuring access to Jupyter
RUN mkdir /opt/notebooks
RUN jupyter notebook --generate-config --allow-root
RUN echo "c.NotebookApp.password = u'sha1:6a3f528eec40:6e896b6e4828f525a6e20e5411cd1c8075d68619'" >> /root/.jupyter/jupyter_notebook_config.py

# Jupyter listens port: 8888
EXPOSE 8888

# Run Jupyter notebook as Docker main process
CMD ["jupyter", "notebook", "--allow-root", "--notebook-dir=/opt/notebooks", "--ip='*'", "--port=8888", "--no-browser"]
