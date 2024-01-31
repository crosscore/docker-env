# Dockerfile

# Specify base image
FROM python:3.10.12

# Set time zone
ENV TZ=Asia/Tokyo
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Set working directory
WORKDIR /usr/src/repos

RUN apt-get update && apt-get install -y \
    build-essential zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev libssl-dev libreadline-dev libffi-dev wget

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

# Install project dependencies
COPY package.json ./
COPY package-lock.json ./
RUN npm ci

# Install zsh and make it the default shell
RUN apt-get install -y zsh && chsh -s $(which zsh)

# Copy the application code to the container
COPY . .

# Copy the entrypoint script to the container
COPY entrypoint.sh /usr/local/bin/

# Make the entrypoint script executable
RUN chmod +x /usr/local/bin/entrypoint.sh

# Expose the port the app runs on
EXPOSE 3000-3009
EXPOSE 5000-5009
EXPOSE 8080-8089

# Set the entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# Default command to open a bash shell
CMD ["/bin/bash"]
