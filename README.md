# libcint (Meson wraps)

This project create ready-to-go archives and corresponding [wrap files](https://mesonbuild.com/Wrap-dependency-system-manual.html) of [`libcint`](https://github.com/sunqm/libcint) for your Meson builds.

The different wraps are available with corresponding archives [here](https://github.com/pierre-24/libcint-meson/releases/tag/v0.2.0) (pre-releases versions are available [here](https://github.com/pierre-24/libcint-meson/releases/tag/latest), but their hash changes without notice).

Note that [extra integrals are enabled](generate.patch) in order for the code to be used in some projects ([`stdlite`](https://github.com/pierre-24/stdlite) and [`stda`](https://github.com/grimme-lab/stda)), but this should not prevent you from using it.

## Usage

Just grab the wrap file corresponding to the version you want to use ...

```bash
# in your super project root folder

# create a `subprojects` folder if it does not exists yet
mkdir subprojects

# download wrap file, here for libcint v6.1.2:
wget https://github.com/pierre-24/libcint-meson/releases/download/v0.2.0/libcint_v6.1.2.wrap -O subprojects/libcint.wrap
```

... and add something like this in your `meson.build`:

```Meson
cc = meson.get_compiler('c')

libcint_dep = cc.find_library('libcint', required: false)
if not libcint_dep.found()
  libcint_proj = subproject('libcint', default_options: [])
  libcint_dep = libcint_proj.get_variable('libcint_dep')
endif
project_dep += libcint_dep
```

You can check out the options in [`meson_options.txt`](./for-meson/meson_options.txt)

## Development

To use the different scripts, you need `clisp`, `meson`, `ninja` and `cmake`.
They are most probably available in your favorite package manager.

[`generate.sh`](generate.sh) is the script used to generate the archive and wrap file. 
In practice, it:

1. downloads `libcint`, 
2. applies  [the patch](generate.patch), 
3. re-generates the integrals with [`scripts/auto_intor.cl`](https://github.com/sunqm/libcint/blob/master/scripts/auto_intor.cl),
4. adds [the Meson files](for-meson/), and 
5. generates both the archive and wrap file.

You can run that script locally to explore the modifications.

[`tests.sh`](test.sh) is the script used to run a test suite.
In practice, each folder in [`for-tests`](for-tests) that starts with `test_meson` is:

1. copied in a testing folder, then
2. a `subproject/libcint` folder is filled with the previously created archive,  then
3. `meson setup` and `meson compile` ensue, and then
4. the output of the resulting program (by convention, `test_libcint`) is compared with `EXPECTED` (it should match).
