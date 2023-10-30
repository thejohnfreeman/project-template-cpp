import pytest
import subprocess
import tempfile

from tests import helpers

@pytest.fixture(scope='module')
def install_dir():
    with tempfile.TemporaryDirectory() as install_dir:
        print(f'installing to {install_dir}')
        yield install_dir

@pytest.fixture(scope='module')
def zero(install_dir):
    yield from helpers.install(install_dir, '00-upstream')

@pytest.fixture(scope='module')
def one(install_dir, zero):
    yield from helpers.install(install_dir, '01-find-package')

@pytest.fixture(scope='module')
def two(install_dir):
    yield from helpers.install(install_dir, '02-add-subdirectory')

@pytest.fixture(scope='module')
def three(install_dir, one):
    yield from helpers.install(install_dir, '03-fp-fp')

@pytest.fixture(scope='module')
def four(install_dir, two):
    yield from helpers.install(install_dir, '04-as-fp')

@pytest.fixture(scope='module')
def five(install_dir):
    yield from helpers.install(install_dir, '05-fetch-content')

@pytest.fixture(scope='module')
def six(install_dir, zero):
    yield from helpers.install(install_dir, '06-fp-fc')

@pytest.fixture(scope='module')
def seven(install_dir):
    yield from helpers.install(install_dir, '07-as-fc')

@pytest.fixture(scope='module')
def eight(install_dir, zero):
    yield from helpers.install(install_dir, '08-find-module')

@pytest.fixture(scope='module')
def nine(install_dir):
    yield from helpers.install(install_dir, '09-external-project')

@pytest.fixture(scope='module')
def ten(install_dir):
    subprocess.run(
        ['conan', 'export', '.'],
        cwd=helpers.root / '00-upstream',
        check=True,
    )
    yield from helpers.install(install_dir, '10-conan')

@pytest.fixture(scope='module')
def eleven(install_dir, zero):
    yield from helpers.install(install_dir, '11-no-cupcake')
