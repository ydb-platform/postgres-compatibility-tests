import argparse
import logging

from typing import List

import junit_report_converter as ju

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-reports", default="result-example.xml")
    parser.add_argument("--only-passed", default=False, action="store_true")
    parser.add_argument("--no-class", default=False, action="store_true")
    args = parser.parse_args()

    logging.getLogger().setLevel(logging.DEBUG)

    report = ju.load_report(args.input_reports)
    tests = ju.get_test_names(report, args.no_class, args.only_passed)
    for test in tests:
        print(test)


if __name__ == '__main__':
    main()
