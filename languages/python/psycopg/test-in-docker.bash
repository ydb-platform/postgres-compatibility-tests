#!/bin/bash

set -eu

cd /project
python -c "import tests; import xmlrunner; tests.unittest.main(defaultTest='tests.test_suite', testRunner=xmlrunner.XMLTestRunner(output='test-reports'))"
