import pathlib
import pytest
import subprocess
import tempfile

root = pathlib.Path(__file__).parents[1]

def install(install_dir, source_dir):
    with tempfile.TemporaryDirectory() as build_dir:
        print(f'building zero in {build_dir}')
        subprocess.run([
            'cupcake', 'install',
            '--source-dir', root / source_dir,
            '--build-dir', build_dir,
            '--prefix', install_dir,
        ], check=True)
        yield build_dir

def _test(build_dir, source_dir):
    subprocess.run([
        'cupcake', 'test',
        '--source-dir', root / source_dir,
        '--build-dir', build_dir,
    ], check=True)

@pytest.fixture(scope='module')
def install_dir():
    with tempfile.TemporaryDirectory() as install_dir:
        print(f'installing to {install_dir}')
        yield install_dir

@pytest.fixture(scope='module')
def zero(install_dir):
    yield from install(install_dir, '00-upstream')

def test_zero(zero):
    _test(zero, '00-upstream')

@pytest.fixture(scope='module')
def one(install_dir, zero):
    yield from install(install_dir, '01-find-package')

def test_one(one):
    _test(one, '01-find-package')
