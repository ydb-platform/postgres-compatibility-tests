import xmlrunner
import tests

tests.unittest.main(
    defaultTest='tests.test_suite',
    testRunner=xmlrunner.XMLTestRunner(output='/test-result'),
)
