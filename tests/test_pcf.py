import pytest

from tests import helpers

@pytest.fixture(scope='module')
def zero(install_dir):
    yield from helpers.install(install_dir, '00-upstream')

def test_zero(zero):
    helpers.test(zero, '00-upstream')

@pytest.fixture(scope='module')
def one(install_dir, zero):
    yield from helpers.install(install_dir, '01-find-package')

def test_one(one):
    helpers.test(one, '01-find-package')
