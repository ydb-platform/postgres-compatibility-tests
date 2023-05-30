import argparse
import logging

from typing import List

import junit_report_converter as ju


def get_test_names(report: ju.JUnitTestSuites, skip_class: bool, only_passed: bool) -> List[str]:
    res = []

    def callback(testcase: ju.JUnitTestSuites.TestCase):
        if testcase.fullname == "":
            return

        if only_passed and not testcase.is_passed:
            return

        if skip_class:
            res.append(testcase.name)
        else:
            res.append(testcase.fullname)

    report.foreach_testcase(callback)
    return res


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-reports", default="result-example.xml")
    parser.add_argument("--only-passed", default=False, action="store_true")
    parser.add_argument("--no-class", default=False, action="store_true")
    args = parser.parse_args()

    logging.getLogger().setLevel(logging.DEBUG)

    report = ju.load_report(args.input_reports)
    tests = get_test_names(report, args.no_class, args.only_passed)
    for test in tests:
        print(test)


if __name__ == '__main__':
    main()
