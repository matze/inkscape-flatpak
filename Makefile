include Makefile.config

release: repo org.inkscape.Inkscape.json
	flatpak-builder --force-clean --repo=repo --ccache --gpg-sign=${GPG_KEY} inkscape org.inkscape.Inkscape.json
	flatpak build-update-repo --generate-static-deltas --gpg-sign=${GPG_KEY} repo

bundle:
	flatpak build-bundle repo inkscape.flatpak org.inkscape.Inkscape
	rm -f inkscape.flatpak.sig
	gpg --sign-with ${GPG_KEY} --output inkscape.flatpak.sig --detach-sign inkscape.flatpak

repo:
	ostree init --mode=archive-z2 --repo=repo

inkscape.flatpakref: inkscape.flatpakref.in 
	sed -e 's|@REPO_URL@|${REPO_URL}|g' -e 's|@GPG@|$(shell gpg2 --export ${GPG_KEY} | base64 | tr -d '\n')|' $< > $@
