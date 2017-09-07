Build image:

    docker build -t desktop_container .

Create and run container:

    docker run -d -P --name NAME desktop_container
    docker port NAME 22