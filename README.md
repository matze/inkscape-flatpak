## User installation

As a user install the flatpak with

    $ flatpak install --bundle inkscape.flatpak


## Flatpak packaging

Create a `Makefile.config` containing

    GPG_KEY=<your GPG key id>
    REPO_URL=<your final repo location url>

and call

    $ make release

to create the repository and

    $ make bundle

to create a single-file bundle.
