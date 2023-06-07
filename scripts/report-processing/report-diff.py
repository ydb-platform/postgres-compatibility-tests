#!/usr/bin/python3
import argparse
import collections
import sys
from dataclasses import dataclass
from typing import Dict, List

import colorama

import junit_report_converter as ju


def _tests_result(report: ju.JUnitTestSuites) -> Dict[str, str]:
    tests = dict()

    def callback(testcase: ju.JUnitTestSuites.TestCase):
        tests[testcase.fullname] = testcase.status()

    report.foreach_testcase(callback)

    return tests


@dataclass
class _DiffItem:
    name: str
    old_state: str
    new_state: str

    @property
    def is_fixed(self) -> bool:
        return self.new_state != self.old_state and self.new_state == ju.JUnitTestSuites.TestCase.OK_STATUS

    @property
    def is_broken(self) -> bool:
        return self.new_state != self.old_state and self.old_state == ju.JUnitTestSuites.TestCase.OK_STATUS


def _diff(old_report: ju.JUnitTestSuites, new_report: ju.JUnitTestSuites):
    no_run_state = "NO_RUN"
    old_tests = _tests_result(old_report)
    new_tests = _tests_result(new_report)

    res = []
    for name in new_tests:
        old_state = old_tests[name] if name in old_tests else no_run_state
        new_state = new_tests[name]
        if old_state != new_state:
            res.append(_DiffItem(name=name, old_state=old_state, new_state=new_state))

    for name in old_tests:
        if name in new_tests:
            continue
        res.append(_DiffItem(name=name, old_state=old_tests[name], new_state=no_run_state))

    return res


def _show_diff(diff: List[_DiffItem]):
    diff.sort(key=lambda item: item.name)

    fixed = []
    broken = []

    for test in diff:
        if test.new_state == ju.JUnitTestSuites.TestCase.OK_STATUS:
            fixed.append(test)
        elif test.old_state == ju.JUnitTestSuites.TestCase.OK_STATUS:
            broken.append(test)
        else:
            pass

    def print_state(item: _DiffItem):
        if sys.stdout.isatty():
            if item.is_fixed:
                print(colorama.Fore.GREEN, "+ ", colorama.Fore.RESET, sep='', end='')
            elif item.is_broken:
                print(colorama.Fore.RED, "- ", colorama.Fore.RESET, sep='', end='')
            else:
                print(colorama.Fore.WHITE, "0 ", colorama.Fore.RESET, sep='', end='')
        else:
            if item.is_fixed:
                print("+ ", sep='', end='')
            elif item.is_broken:
                print("- ", sep='', end='')
            else:
                print("0 ", sep='', end='')

        print(item.new_state, item.name)

    for test in fixed:
        print_state(test)
    for test in broken:
        print_state(test)

    if sys.stdout.isatty():
        print(colorama.Fore.GREEN, "fixed: ", len(fixed), colorama.Fore.RESET, sep='')
        print(colorama.Fore.RED, "broken: ", len(broken), colorama.Fore.RESET, sep='')
    else:
        print("fixed: ", len(fixed), sep='')
        print("broken: ", len(broken), sep='', end='')

    print(colorama.Fore.RESET)


def _has_broken(diff: List[_DiffItem]) -> bool:
    for item in diff:
        if item.is_broken:
            return True
    return False


def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--old-report", default="./tmp/alltest-result/trunk.xml")
    parser.add_argument("--new-report", default="./tmp/alltest-result/last.xml")
    args = parser.parse_args()

    old_report = ju.load_report(args.old_report)
    new_report = ju.load_report(args.new_report)

    diff = _diff(old_report, new_report)
    _show_diff(diff)

    if _has_broken(diff):
        exit(1)


if __name__ == '__main__':
    main()
