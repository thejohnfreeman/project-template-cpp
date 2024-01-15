import os
import pathlib
import pytest
import subprocess
import tempfile

root = pathlib.Path(__file__).parents[1]

try:
    os.symlink(
        root / '00-upstream',
        root / '02-add-subdirectory/external/00-upstream',
    )
except FileExistsError:
    pass

GENERATOR = [
    x.strip() for x in
    os.getenv('GENERATOR', 'Unix Makefiles,Ninja').split(',')
]

SHARED = [
    x.strip() == 'ON' for x in
    os.getenv('SHARED', 'ON,OFF').split(',')
]

FLAVOR = [
    x.strip() for x in
    os.getenv('FLAVOR', 'release,debug').split(',')
]

@pytest.fixture(scope='session', autouse=True)
def before_all(request):
    subprocess.run([
        'conan', 'info', 'cupcake/alpha@github/thejohnfreeman'
    ], check=True)

@pytest.fixture(scope='session', params=GENERATOR)
def generator(request):
    return request.param

@pytest.fixture(scope='session', params=SHARED)
def shared(request):
    return request.param

@pytest.fixture(scope='session', params=FLAVOR)
def flavor(request):
    return request.param

@pytest.fixture(scope='module')
def install_dir():
    with tempfile.TemporaryDirectory() as install_dir:
        print(f'installing to {install_dir}')
        yield install_dir

@pytest.fixture(scope='module')
def params(generator, flavor, shared, install_dir):
    names = ('generator', 'flavor', 'shared', 'install_dir')
    values = locals()
    return { k: values[k] for k in names }

class Cupcake:
    def install(self, params, source_dir):
        with tempfile.TemporaryDirectory() as build_dir:
            print(f'building zero in {build_dir}')
            subprocess.run([
                'cupcake', 'install',
                '--source-dir', root / source_dir,
                '--build-dir', build_dir,
                '--generator', params['generator'],
                '--flavor', params['flavor'],
                '--shared' if params['shared'] else '--static',
                '--prefix', params['install_dir'],
            ], check=True)
            yield build_dir

    def test(self, build_dir, source_dir):
        subprocess.run([
            'cupcake', 'test',
            '--source-dir', root / source_dir,
            '--build-dir', build_dir,
        ], check=True)

@pytest.fixture(scope='module')
def builder():
    return Cupcake()

@pytest.fixture(scope='module')
def zero(builder, params):
    yield from builder.install(params, '00-upstream')

@pytest.fixture(scope='module')
def one(builder, params, zero):
    yield from builder.install(params, '01-find-package')

@pytest.fixture(scope='module')
def two(builder, params):
    yield from builder.install(params, '02-add-subdirectory')

@pytest.fixture(scope='module')
def three(builder, params, one):
    yield from builder.install(params, '03-fp-fp')

@pytest.fixture(scope='module')
def four(builder, params, two):
    yield from builder.install(params, '04-as-fp')

@pytest.fixture(scope='module')
def five(builder, params):
    yield from builder.install(params, '05-fetch-content')

@pytest.fixture(scope='module')
def six(builder, params, zero):
    yield from builder.install(params, '06-fp-fc')

@pytest.fixture(scope='module')
def seven(builder, params):
    yield from builder.install(params, '07-as-fc')

@pytest.fixture(scope='module')
def eight(builder, params, zero):
    yield from builder.install(params, '08-find-module')

@pytest.fixture(scope='module')
def nine(builder, params):
    yield from builder.install(params, '09-external-project')

@pytest.fixture(scope='module')
def ten(builder, params):
    subprocess.run(
        ['conan', 'export', '.'],
        cwd=root / '00-upstream',
        check=True,
    )
    yield from builder.install(params, '10-conan')

@pytest.fixture(scope='module')
def eleven(builder, params, zero):
    yield from builder.install(params, '11-no-cupcake')
