# configure file
head_config = configure_file(
    format: 'cmake@',
    input: 'config.h.in',
    output: 'config.h',
    configuration: project_config
)

# add sources
srcs += files(
    'c2f.c', 'cart2sph.c', 'cint1e.c', 'cint2e.c', 'cint_bas.c',
    'fblas.c', 'g1e.c', 'g2e.c', 'misc.c', 'optimizer.c',
    'fmt.c', 'rys_wheeler.c', 'eigh.c', 'rys_roots.c', 'find_roots.c',
    'cint2c2e.c', 'g2c2e.c', 'cint3c2e.c', 'g3c2e.c',
    'cint3c1e.c', 'g3c1e.c',  'breit.c',
    'cint1e_a.c', 'cint3c1e_a.c',
    'cint1e_grids.c', 'g1e_grids.c',
    'autocode/breit1.c', 'autocode/dkb.c', 'autocode/gaunt1.c',
    'autocode/grad1.c', 'autocode/grad2.c', 'autocode/hess.c',
    'autocode/int3c1e.c', 'autocode/int3c2e.c', 'autocode/intor1.c',
    'autocode/intor2.c', 'autocode/intor3.c', 'autocode/intor4.c',
    'autocode/deriv3.c', 'autocode/int1e_grids1.c',
    'autocode/deriv4.c', 'autocode/lresc.c'
)