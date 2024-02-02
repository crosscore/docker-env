# Dockerfile

# Specify base image
FROM python:3.10.12

# Set working directory
WORKDIR /root/repos

RUN apt-get update && apt-get install -y \
    build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev wget lsof

# Install Japanese fonts
RUN apt-get install -y fonts-noto-cjk

# Upgrade pip
RUN pip install --upgrade pip

# Install required Python packages
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Install Node.js
RUN apt-get install -y curl \
    && curl -SL https://deb.nodesource.com/setup_current.x | bash - \
    && apt-get install -y nodejs

# Install TypeScript
RUN npm install -g typescript

# Install zsh and make it the default shell
RUN apt-get install -y zsh && chsh -s $(which zsh)

# Copy the entrypoint script to the container
COPY entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to open a bash shell
CMD ["/usr/bin/zsh"]
