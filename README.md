

<h1 align="center">
  <br>
  <a href="#"><img src="https://upload.wikimedia.org/wikipedia/commons/5/5f/Vmware_logo.png" width="200"></a>
  <br>
  Custom ESXi ISO Builder
  <br>
</h1>

<h4 align="center">
PowerShell tool for building a custom ESXi installation ISO from offline depot bundles and integrating additional drivers or VIB packages.
</h4>

<p align="center">
  <a href="#">
    <img src="https://img.shields.io/badge/version-1.0-blue.svg">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/status-active-brightgreen.svg">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/platform-ESXi-orange.svg">
  </a>
  <a href="#">
    <img src="https://img.shields.io/badge/script-PowerShell-blue.svg">
  </a>
</p>

<p align="center">
  <a href="#key-features">Features</a> •
  <a href="#requirements">Requirements</a> •
  <a href="#project-structure">Project Structure</a> •
  <a href="#how-to-use">How To Use</a>
</p>

---

## Key Features

* Build **custom ESXi ISO images**
* Works with **offline depot bundles**
* Supports **custom driver integration**
* Automatically detects **available packages**
* Generates ready-to-install **ESXi ISO**
* Simple **PowerShell automation**
* Uses **VMware PowerCLI**

---

# Requirements

Before running the script make sure the following software is installed.

---

## Python

Install **Python 3.11**

Download:

https://www.python.org/downloads/

---

## VMware PowerCLI

Install the PowerCLI module:

```powershell
Install-Module VMware.PowerCLI -Scope CurrentUser
