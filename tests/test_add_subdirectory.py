import pytest

from tests import helpers

@pytest.fixture(scope='module')
def two(install_dir):
    yield from helpers.install(install_dir, '02-add-subdirectory')

def test_two(two):
    helpers.test(two, '02-add-subdirectory')

@pytest.fixture(scope='module')
def four(install_dir, two):
    yield from helpers.install(install_dir, '04-as-fp')

def test_four(four):
    helpers.test(four, '04-as-fp')
