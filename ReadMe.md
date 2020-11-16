# bugout
My first OS

This software is developed for `x86` arch<br>
but my plans involve running on ARM in the future

I'm building this os for the following reasons:
- to learn / broaden my understanding
- to *understand* kernels / OS
- to showcase my capacity to learn, and get a job I actually *want* to perform


## building
### requirements

[fasm](https://flatassembler.net/) the flat assembler

[qemu](https://www.qemu.org) a virtualization emulator

[qemu install issue I had](https://askubuntu.com/questions/138140/how-do-i-install-qemu)
<br>
[direct link to answer](
https://askubuntu.com/a/251595)

---
Compiling:

```bash
./build.sh
```
runs fasm<br>

outputs to `dist/main.img`

---

Running (emulator):

```bash
./run.sh
```

runs qemu on `dist/main.img`

## Resources
[fasm - flat assembler docs](https://flatassembler.net/docs.php)

[cfenollosa's os tutorial on github](https://github.com/cfenollosa/os-tutorial)