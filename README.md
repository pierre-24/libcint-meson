# libcint (Meson wrap files)

Create ready-to-go archives and corresponding [wrap files](https://mesonbuild.com/Wrap-dependency-system-manual.html) of [libcint](https://github.com/sunqm/libcint) for Meson builds.

The different wrap files are available [here](https://github.com/pierre-24/libcint-meson/releases/tag/v0.0.2) (bleeding edge version are available [here](https://github.com/pierre-24/libcint-meson/releases/tag/latest)).

Note that extra integrals are enabled in order to be used in some projects ([`stdlite`](https://github.com/pierre-24/stdlite) and [`stda`](https://github.com/grimme-lab/stda)), but this should not prevent you for using it.

## Usage

Just grab the wrap file corresponding to the version you want to use ...

```bash
# in your super project root folder

# create a `subprojects` folder if it does not exists yet
mkdir subprojects

# download wrap file, here for v6.1.2:
cd subprojects
wget https://github.com/pierre-24/libcint-meson/releases/download/v0.0.2/libcint_v6.1.2.wrap -O libcint.wrap
```

... and add something like this in your `meson.build`:

```Meson
libcint_dep = cc.find_library('libcint', required: false)
if not libcint_dep.found()
  libcint_proj = subproject('libcint', default_options: [])
  libcint_dep = libcint_proj.get_variable('libcint_dep')
endif
project_dep += libcint_dep
```
