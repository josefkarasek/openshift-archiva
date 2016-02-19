# Openshift-archiva
Speed-up your Openshift 3 Java builds with local Maven artifact repository

# Motivation
Builds in Openshift 3 often take long time to complete. This is mostly caused by pulling in dependencies every time a build is triggered. Espetially large Java projects with exhaustive dependecy tree being pulled in from multiple repositories. Proposed solution to this problem is to install dependency cache, that can store Maven artifacts and make them available across the Openshift 3 environment. Cache implementation in this repository is [Apache Archiva](https://archiva.apache.org), open-soure artifact repository.

# Installation
Preconfigured Docker image is available on [Docker hub](https://hub.docker.com/r/jkarasek/archiva/) and futher configuration can be done through Archiva's web UI. This repository contains Openshift 3 templates to easy deployment. Prefered installation method is via the Openshfit 3 web UI, alternatively the `oc` command can be used (in that case reffer to corresponding template file on what enviromental variables you need to initialize).

Note that templates require `archiva-2.2.0` [image stream](https://github.com/josefkarasek/openshift-archiva/blob/master/archiva-2.2.0-image-stream.json) in IMAGE\_STREAM\_NAMESPACE.

## Enviromental variables
| ENV VAR  |  meaning |
|:-:|---|
| APPLICATION_NAME  | The name. Used as [label selector](https://github.com/kubernetes/kubernetes/blob/master/docs/user-guide/labels.md#label-selectors), don't change  |
| ADMIN_PASSWORD  | Default admin's password. Can be changed ind Archiva's web UI  |
| ADMIN_EMAIL  |  Default admin's email. |
| REMOTEx  |  Remote artifact repository URL |
| EXTRA_REMOTES  |  Additional space for remote repository URLs |
| IMAGE\_STREAM\_NAMESPACE  | Namespace where the archiva image stream is defined  |
