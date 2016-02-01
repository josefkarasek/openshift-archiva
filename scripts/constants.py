#!/usr/bin/env python
# -*- coding: utf-8 -*-

REPOSITORY_GROUP="""
    <repositoryGroups>
        <repositoryGroup>
            <id>$ID</id>
            <mergedIndexPath>.indexer</mergedIndexPath>
            <repositories>
                <repository>internal</repository>
                <repository>snapshots</repository>
            </repositories>
        </repositoryGroup>
    </repositoryGroups>
"""

REMOTE_REPOSITORIES="""
        <remoteRepository>
            <url>$URL</url>
            <downloadRemoteIndex>false</downloadRemoteIndex>
            <downloadRemoteIndexOnStartup>false</downloadRemoteIndexOnStartup>
            <id>$REPO_ID</id>
            <name>$REPO_NAME</name>
        </remoteRepository>
"""

PROXY_CONNECTORS="""
        <proxyConnector>
            <order>$ORDER</order>
            <sourceRepoId>internal</sourceRepoId>
            <targetRepoId>$TARGET_REPO_ID</targetRepoId>
            <policies>
                <releases>hourly</releases>
                <propagate-errors>queue error</propagate-errors>
                <checksum>fix</checksum>
                <propagate-errors-on-update>artifact not already present</propagate-errors-on-update>
                <snapshots>hourly</snapshots>
                <cache-failures>no</cache-failures>
            </policies>
            <disabled>false</disabled>
        </proxyConnector>
"""
# export REMOTE1=ahoj123
# export REMOTE2=ahoj123
# export REMOTE3=ahoj123
# export REMOTE4=ahoj123
# export REMOTE5=ahoj123
# export REMOTE6=ahoj123
# export REMOTE7=ahoj123
# export REMOTE8=ahoj123
# export REMOTE9=ahoj123
# export REMOTE10=ahoj123
# export REMOTE11=ahoj123
# export REMOTE12=ahoj123
