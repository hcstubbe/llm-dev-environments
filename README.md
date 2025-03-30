# Docker development environment

## Important notes:
* The data within each container and the database container does not persist, when the stack is removed! **For development save changes using a version control system and export data and results!**
* Alternatively, you can mount persistent folders of the hosts computers file system into the containers by modifying the YAML-files like [this](https://docs.docker.com/storage/bind-mounts/#use-a-bind-mount-with-compose).
* Set the path to environmental variable like this (Linux/WSL) `export DOCKER_DATA_PATH="/path/to/your/data/"`

