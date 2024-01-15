# Dockerfile

# Specify base image
FROM python:3.11.6

# Set time zone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set HISTSIZE and HISTFILESIZE
RUN echo "export HISTSIZE=10000" >> /root/.bashrc \
 && echo "export HISTFILESIZE=10000" >> /root/.bashrc

# Set working directory
WORKDIR /usr/src/repos

RUN apt-get update && apt-get install -y git

# Install Japanese fonts
RUN apt-get install -y fonts-noto-cjk

# Upgrade pip
RUN pip install --upgrade pip

# Install required Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Copy the application code to the container
COPY . .

# Copy the entrypoint script to the container
COPY entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the port the app runs on
EXPOSE 5000

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to open a bash shell
CMD ["/bin/bash"]
