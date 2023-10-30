from tests import helpers

def test_zero(zero):
    helpers.test(zero, '00-upstream')

def test_one(one):
    helpers.test(one, '01-find-package')

def test_three(three):
    helpers.test(three, '03-fp-fp')
