# LogDNA module for Puppet [![Build Status](https://travis-ci.org/stevenrombauts/puppet-logdna.svg?branch=master)](https://travis-ci.org/stevenrombauts/puppet-logdna) [![Puppet Forge](https://img.shields.io/puppetforge/v/stevenrombauts/logdna.svg?maxAge=2592000?style=flat-square)](https://forge.puppet.com/stevenrombauts/logdna)

## DEPRECATED

This module is no longer maintained because LogDNA has now released an official Puppet module: [logdna/logdna](https://github.com/logdna/puppet-logdna).

## Module description

This module manages and installs the [LogDNA](https://logdna.com) agent.  

## Operating System

This module has been tested on the following operating systems:

* CentOS 6
* CentOS 7
* Debian 7 (wheezy)
* Debian 8 (jessie)
* Ubuntu 14.04 (trusty)
* Ubuntu 16.04 (xenial)

It may work on most derivatives and different versions of the above listed systems.

## Usage

To install the LogDNA agent, declare the `::logdna::agent` class with your API key:

```Puppet
class { '::logdna::agent':
    key => 'your API key'
}
```
     
To change the default `logdir` configuration, you can pass an array of directories, files and glob patterns to the class:

```Puppet
class { '::logdna::agent':
    key    => 'your API key',
    logdir => ['/var/log', '/home/deploy/revisions.log']
}
```

## Usage from Hiera

To configure using Hiera, include the class in your manifest:

```Puppet
include ::logdna::agent
```
    
and add the configuration to Hiera:

```yaml
logdna::agent::key: 'your API key'
logdna::agent::logdir:
  - '/var/log'
  - '/home/deploy/revisions.log'
```
