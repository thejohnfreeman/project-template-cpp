import pytest
import tempfile

@pytest.fixture(scope='module')
def install_dir():
    with tempfile.TemporaryDirectory() as install_dir:
        print(f'installing to {install_dir}')
        yield install_dir
