FROM python:3.8
WORKDIR /project

RUN pip install "xmlrunner < 4"
CMD ["python", "-c", "import tests; import xmlrunner; tests.unittest.main(defaultTest='tests.test_suite', testRunner=xmlrunner.XMLTestRunner(output='test-reports')"]
