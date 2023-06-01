[![Docker Image CI](https://github.com/adeslatt/hisat2_index-docker/actions/workflows/docker-image.yml/badge.svg)](https://github.com/adeslatt/hisat2_index-docker/actions/workflows/docker-image.yml)

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

Authenticate with your *`Personal Authentication Token`*

```bash
gh auth login
? What account do you want to log into? GitHub.com
? What is your preferred protocol for Git operations? HTTPS
? Authenticate Git with your GitHub credentials? Yes
? How would you like to authenticate GitHub CLI?  [Use arrows to move, type to filter]
  Login with a web browser
> Paste an authentication token
```

Now we can from the command line create this repository.

Let's go ahead and tell *`git`* who we are.

```bash
git config --global user.email "adeslat@scitechcon.org"
git config --global user.name "adeslatt"
```

Following [*`GitHub`*'s updated instructions on how to create a new repository from the command line](https://docs.github.com/en/get-started/importing-your-projects-to-github/importing-source-code-to-github/adding-locally-hosted-code-to-github#adding-a-local-repository-to-github-with-github-cli)

We now type

```bash
git init -b main
```

Which will return
```bash
Initialized empty Git repository in /home/adeslat/hisat2_index-docker/.git/
```

And then we type

```bash
git add . && git commit -m "initial commit"
```
which returns something like this.

```bash
[main (root-commit) d1e421f] initial commit
 3 files changed, 33 insertions(+)
 create mode 100644 Dockerfile
 create mode 100644 README.md
 create mode 100644 environment.yml
```
We then use the *`gh repo create`* command to create the reposistory.

```bash
gh repo create
```

Which then prompts us to what we need to do -- important is that what we want to do is *`Push an existing local repository to GitHub`*.   The tool's remainder defaults are acceptable, because we staged ourselves with the name of the directory.

```bash
$ gh repo create
? What would you like to do? Push an existing local repository to GitHub
? Path to local repository .
? Repository name hisat2_index-docker
? Description
? Visibility Public
✓ Created repository adeslatt/fastqc-docker on GitHub
? Add a remote? Yes
? What should the new remote be called? origin
✓ Added remote https://github.com/adeslatt/hisat2_index-docker.git
? Would you like to push commits from the current branch to "origin"? Yes
✓ Pushed commits to https://github.com/adeslatt/hisat2_index-docker.git
```

