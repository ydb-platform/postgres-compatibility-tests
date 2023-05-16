import xmlrunner
import tests
import os

defaultTest = "tests.test_suite"

test_name = os.environ.get("YDB_PG_TESTNAME", "")
if test_name:
    defaultTest = test_name

print("Start tests: ", defaultTest)

tests.unittest.main(
    defaultTest=defaultTest,
    testRunner=xmlrunner.XMLTestRunner(output='/test-result'),
)
