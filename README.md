# hisat2-docker

Build a Container for bioconda hisat2
For using this module with the rmats-nf workflow -- we also need to install Samtools 

Steps to build this docker container.
1. Look up on [anaconda](https://anaconda.org/) the tool you wish to install
2. create an `environment.yml` file either manually or automatically
3. Use the template `Dockerfile` modifying if necessary (in our case we have no custom files for the `src` directory so we do not use that)
4. Build the Docker Image
5. Set up GitHub Actions

## Installing Samtools
Latest version now is samtools 1.17
We will add Samtools now to this container.


To build your image from the command line:
* Can do this on [Google shell](https://shell.cloud.google.com) - docker is installed and available

```bash
docker build -t hisat2 .
```

To test this tool from the command line 

Set up an environment variable capturing your current command line:
```bash
PWD=$(pwd)
```

Then mount and use your current directory and call the tool now encapsulated within the environment.
```bash
docker run -it -v $PWD:$PWD -w $PWD hisat2 hisat2 -h
```

Also since we have now built `samtools v1.17` in this package we can test that this tool is now available and accessible in the image

```bash
docker run -it -v $PWD:$PWD -w $PWD hisat2 samtools view -h
```

should return the help information for the `samtools view` tool.

## Final word: Adding this code to your `GitHub` Repository

This repository was built in place and then uploaded to the repository on `GitHub`.   

To do so in the `https://shell.google.com` environment we need to get install the interactive set of tools for `GitHub` obtainable from `https://anaconda.org` and with:

```bash
conda install -c conda-forge gh -y
```

Now we need to authenticate

```bash
gh auth login
```
