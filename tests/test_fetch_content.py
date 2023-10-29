import pytest

from tests import helpers

@pytest.fixture(scope='module')
def five(install_dir):
    yield from helpers.install(install_dir, '05-fetch-content')

def test_five(five):
    helpers.test(five, '05-fetch-content')
