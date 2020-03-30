pegoat
======

[![Build Status](https://img.shields.io/github/workflow/status/trailofbits/pegoat/CI/master)](https://github.com/trailofbits/pegoat/actions?query=workflow%3ACI)

A collection of Windows binary builds containing different (sometimes ineffective) security
mitigations.

These files are primarily intended to test [winchecksec](https://github.com/trailofbits/winchecksec)
and other security tools that consume PEs.

## Building

pegoat expects to be built on Windows with a compiler that behaves like `cl.exe`
(`clang-cl` is probably fine, but untested).

Both 32-bit (`-A Win32`) and 64-bit (`-A x64`) builds are supported, but not
all targets are built on both (due to differences in available mitigations).

```powershell
> mkdir build
> cd build
> cmake -G "Visual Studio 16 2019" -A x64 ..
> cmake --build . --config Release
```
