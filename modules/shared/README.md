## Shared
This will more than likely get changed and moved if i squash this branch into my main nixos branch at some point in the future.
Much of the code running on MacOS or NixOS is actually found here.

This configuration gets imported by both modules. Some configuration examples include `git` and `vim`
## Layout
```
.
├── config             # Config files not written in Nix
├── cachix             # Defines cachix, a global cache for builds
├── default.nix        # Defines how we import overlays 
├── home-manager.nix   # The goods; most all shared config lives here
├── packages.nix       # List of packages to share

```

