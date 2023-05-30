#!/usr/bin/python3

import argparse
import xml.etree.ElementTree as ET
from typing import List


def read_unit_tests(path: str) -> List[str]:
    if not path:
        return []

    with open(path, "tr") as f:
        lines = f.readlines()

    res = []  # type: List[str]
    for line in lines:
        line = line.strip()
        if line:
            res.append(line)

    return res


def read_report(file_path: str) -> ET.ElementTree:
    return ET.parse(file_path)


def write_report(report: ET.ElementTree, file_path: str):
    report.write(file_path)


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--report-file-path", required=True)
    parser.add_argument("--unit-test-file-path", required=False)

    args = parser.parse_args()
    unit_tests = read_unit_tests(args.unit_test_file_path)
    report = read_report(args.report_file_path)
    remove_tests(report, unit_tests)
    write_report(report, args.report_file_path)


if __name__ == '__main__':
    main()
