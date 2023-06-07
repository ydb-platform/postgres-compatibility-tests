import argparse
import logging
import sys

import junit_report_converter as ju


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--input-reports", default="result-example.xml")
    args = parser.parse_args()

    logging.getLogger().setLevel(logging.DEBUG)
    report = ju.load_report(args.input_reports)
    report.save_to_file(sys.stdout.buffer)


if __name__ == '__main__':
    main()
