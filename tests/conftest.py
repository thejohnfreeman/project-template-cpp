import os
import pytest
import subprocess
import tempfile

from tests import helpers

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
    return [
        '--generator', generator,
        '--flavor', flavor,
        '--shared' if shared else '--static',
        '--prefix', install_dir,
    ]

@pytest.fixture(scope='module')
def zero(params):
    yield from helpers.install(params, '00-upstream')

@pytest.fixture(scope='module')
def one(params, zero):
    yield from helpers.install(params, '01-find-package')

@pytest.fixture(scope='module')
def two(params):
    yield from helpers.install(params, '02-add-subdirectory')

@pytest.fixture(scope='module')
def three(params, one):
    yield from helpers.install(params, '03-fp-fp')

@pytest.fixture(scope='module')
def four(params, two):
    yield from helpers.install(params, '04-as-fp')

@pytest.fixture(scope='module')
def five(params):
    yield from helpers.install(params, '05-fetch-content')

@pytest.fixture(scope='module')
def six(params, zero):
    yield from helpers.install(params, '06-fp-fc')

@pytest.fixture(scope='module')
def seven(params):
    yield from helpers.install(params, '07-as-fc')

@pytest.fixture(scope='module')
def eight(params, zero):
    yield from helpers.install(params, '08-find-module')

@pytest.fixture(scope='module')
def nine(params):
    yield from helpers.install(params, '09-external-project')

@pytest.fixture(scope='module')
def ten(params):
    subprocess.run(
        ['conan', 'export', '.'],
        cwd=helpers.root / '00-upstream',
        check=True,
    )
    yield from helpers.install(params, '10-conan')

@pytest.fixture(scope='module')
def eleven(params, zero):
    yield from helpers.install(params, '11-no-cupcake')
