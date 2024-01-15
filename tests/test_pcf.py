def test_zero(builder, zero):
    builder.test(zero, '00-upstream')

def test_one(builder, one):
    builder.test(one, '01-find-package')

def test_three(builder, three):
    builder.test(three, '03-fp-fp')
