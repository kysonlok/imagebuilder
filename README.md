# Quick Start  

## Overview  

### What is Imagebuilder  

Using imagebuilder to build firmware for OpenWrt or LEDE. Unlike OpenWrt
official imagebuilder, it can process proprietary packages, and you can
free to install or remove some packages from firmware.  

### Installation  

$ git clone https://github.com/kysonlok/imagebuilder.git  

### Configuration  

$ cp config.ini.example config.ini  

You can modify configuration file for your requirement.  

**general**  

| key  | description | default |
| :---: | :---: | :---: |
| dl | packages download path | ~/dl |
| sourcedir | OpenWrt/LEDE buildroot source path | ./source |
| target | target to build | ar71xx_generic |
| version | firmware version | 2.27 |  

**repo**  

| key  | description | default |
| :---: | :---: | :---: |
| url | buildroot git repo | https://github.com/gl-inet/lede-17.01 |
| branch | buildroot git repo branch | lede-17.01 |  


