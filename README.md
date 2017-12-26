# Quick Start  

## Overview  

### What is Imagebuilder  

Using imagebuilder to build firmware for OpenWrt or LEDE. Unlike OpenWrt
official imagebuilder, it can process proprietary packages, and you can
free to install or remove some packages from firmware.  

### Installation  

$ git clone https://github.com/kysonlok/imagebuilder.git  

### Configuration  

```bash  
$ cp config.ini.example config.ini  
```  

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

**image xxx**  

| key  | description | default |
| :---: | :---: | :---: |
| profiles | specified target to re-make image with proprietary packages | None |  
| install | install specified packages to rootfs | None |  
| uninstall | remove specified packages from rootfs | None |  

**packages common**  

Common property means the definition packages will install proprietary packages 
to rootfs for all target.  

| key  | value | default |
| :---: | :---: | :---: |  
| package name | packages git repo | None |  

**packages xxx**  

'xxx' property means the definition packages for specified board, it can install 
property packages with 'package name = url' format, or install specified package 
with name for xxx board.  

| key  | value | default |
| :---: | :---: | :---: |
| package name | specified target to re-make image with proprietary packages | None |  
| install | install specified packages to rootfs | None |  
| uninstall | remove specified packages from rootfs | None |  

### Building Image  

```bash  
$ ./op_image --release
```  

