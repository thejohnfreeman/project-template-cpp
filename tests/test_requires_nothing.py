import pytest
import subprocess

def test_08(params, builder, seven):
    builder.test(params, *seven)

def test_09(params, builder, nine):
    builder.test(params, *nine)

def test_10(params, builder, ten):
    builder.test(params, *ten)

def test_assert_special(builder, params):
    with pytest.raises(subprocess.CalledProcessError):
        next(builder.install(params, '10-special', special=False))
