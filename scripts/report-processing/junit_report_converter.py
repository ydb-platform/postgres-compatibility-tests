from __future__ import annotations

import copy
import logging
from argparse import ArgumentParser
from collections import OrderedDict
from dataclasses import dataclass, field
import os.path
from os.path import dirname, join
from typing import List, Dict, Callable, Iterable, Optional, Union
from xml.etree.ElementTree import Element, ElementTree

from mashumaro.mixins.yaml import DataClassYAMLMixin

logger = logging.Logger("junit-reporter-converter")


@dataclass
class Config(DataClassYAMLMixin):
    convert: "Config.Convert" = field(default_factory=lambda: Config.Convert())
    tickets: List["Config.TestsByTicket"] = field(default_factory=lambda: [])

    @dataclass
    class Convert(DataClassYAMLMixin):
        change_error_to_failure: bool = False

    @dataclass
    class TestsByTicket(DataClassYAMLMixin):
        name: str
        tests: Dict[str, List[str]]  # Dict[class, testnames]


class JUnitTestSuites:
    test_suites: List["JUnitTestSuites.TestSuite"]

    @dataclass
    class TestSuite:
        xml: Element

        @staticmethod
        def create():
            el = Element("testsuite")

            return JUnitTestSuites.TestSuite(xml=el)

        def __init__(self, xml: Element):
            self.xml = xml

        @staticmethod
        def parse_xml(et: Element) -> JUnitTestSuites.TestSuite:
            return JUnitTestSuites.TestSuite(et)

        def append_testcase(self, tc: JUnitTestSuites.TestCase):
            tc.suite = self
            self.xml.append(tc.xml)

    @dataclass
    class TestCase:
        OK_STATUS = "OK"

        xml: Element
        suite: JUnitTestSuites.TestSuite

        @staticmethod
        def create(
                classname: str,
                testname: str,
                *,
                suite: Optional[JUnitTestSuites.TestSuite] = None,
                error_tag: Optional[str],
                error_message: Optional[str],
        ) -> JUnitTestSuites.TestCase:
            attrib = OrderedDict()
            attrib["classname"] = classname
            attrib["name"] = testname
            el = Element("testcase", attrib=attrib)
            if error_tag is not None:
                child = Element(error_tag, attrib={"message": error_message})
                el.append(child)

            return JUnitTestSuites.TestCase(xml=el, suite=suite)

        @staticmethod
        def create_from_fullname(
                fullname: str,
                *,
                suite: Optional[JUnitTestSuites.TestSuite] = None,
                error_tag: Optional[str],
                error_message: Optional[str],
        ):
            parts = fullname.split("/", 1)
            if len(parts) == 1:
                parts.append("")

            return JUnitTestSuites.TestCase.create(
                parts[0],
                parts[1],
                suite=suite,
                error_tag=error_tag,
                error_message=error_message,
            )

        @property
        def name(self) -> str:
            return self.xml.attrib.get("name", "")

        @name.setter
        def name(self, name):
            self.xml.attrib["name"] = name

        @property
        def classname(self) -> str:
            return self.xml.attrib.get("classname", "")

        @classname.setter
        def classname(self, classname):
            self.xml.attrib["classname"] = classname

        @property
        def fullname(self) -> str:
            if self.name == "" and self.classname == "":
                return ""

            return "%s/%s" % (self.classname, self.name)

        @property
        def is_passed(self):
            return self.status() == JUnitTestSuites.TestCase.OK_STATUS

        def status(self) -> str:
            children = list(self.xml)
            if len(children) == 0:
                return JUnitTestSuites.TestCase.OK_STATUS

            child = children[0]
            return child.tag.upper()

        def remove_from_suite(self):
            self.suite.xml.remove(self.xml)

        def skip(self, reason: str):
            classname = self.classname
            testname = self.name

            self.xml.clear()

            self.classname = classname
            self.name = testname

            skipped = Element("skipped", {"message": reason})
            self.xml.append(skipped)

    @dataclass
    class SetStatusReason:
        classname: str
        testname: str
        reason: str

        @property
        def fullname(self) -> str:
            return "%s/%s" % (self.classname, self.testname)

    def __init__(self):
        self.test_suites = []

    def foreach_testcase(self, callback: Callable[[JUnitTestSuites.TestCase], None]):
        for suite in self.test_suites:
            for testcase in suite.xml.iter("testcase"):
                callback(JUnitTestSuites.TestCase(xml=testcase, suite=suite))

    def merge_from_file(self, filepath: str):
        logger.info("import report from file: %s" % filepath)
        testsuites_xml = ElementTree()
        testsuites_xml.parse(filepath)
        for testsuite_xml in testsuites_xml.iter("testsuite"):
            testsuite = JUnitTestSuites.TestSuite.parse_xml(testsuite_xml)
            self.test_suites.append(testsuite)

    def save_to_file(self, file_or_filename):
        root = Element("testsuites")
        for suite in self.test_suites:
            root.append(suite.xml)

        et = ElementTree(root)
        et.write(file_or_filename, encoding="utf-8")

    def skip_tests(self, skiplist: Iterable[JUnitTestSuites.SetStatusReason]):
        skip_dict = dict()  # type: Dict[str, JUnitTestSuites.SetStatusReason]
        for reason in skiplist:
            skip_dict[reason.fullname] = reason

        def process_testcase(tc: JUnitTestSuites.TestCase):
            if tc.fullname in skip_dict:
                tc.skip(skip_dict[tc.fullname].reason)

        self.foreach_testcase(process_testcase)


def load_report(path: str):
    logging.info("load junit xml report from: '%s'" % path)
    report = JUnitTestSuites()

    if os.path.isdir(path):
        for root, _, files in os.walk(path):
            for file in files:
                filepath = join(root, file)
                if not file.endswith(".xml"):
                    logging.debug("skip merged report from: '%s'" % filepath)
                    continue

                logging.debug("merge report from: '%s'" % filepath)
                report.merge_from_file(filepath)
    else:
        report.merge_from_file(path)

    return report


def get_test_names(report: JUnitTestSuites, skip_class: bool, only_passed: bool) -> List[str]:
    res = []

    def callback(testcase: JUnitTestSuites.TestCase):
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


def get_skip_reasons(config: Config) -> List[JUnitTestSuites.SetStatusReason]:
    reason_by_test = dict()  # type: Dict[str, JUnitTestSuites.SetStatusReason]
    for ticket in config.tickets:
        for classname, testnames in ticket.tests.items():
            for testname in testnames:
                reason = JUnitTestSuites.SetStatusReason(
                    classname=classname,
                    testname=testname,
                    reason=ticket.name,
                )
                fullname = reason.fullname
                if fullname in reason_by_test:
                    reason_by_test[fullname].reason += "," + ticket.name
                else:
                    reason_by_test[fullname] = reason

    # Sort tickets
    for reason in reason_by_test.values():
        tickets = reason.reason.split(",")
        tickets.sort()
        reason.reason = ",".join(tickets)

    res = []
    for reason in reason_by_test.values():
        res.append(reason)

    def get_key(r: JUnitTestSuites.SetStatusReason):
        return r.fullname
    res.sort(key=get_key)

    return res


def _change_error_to_failure(report: JUnitTestSuites):
    def callback(tc: JUnitTestSuites.TestCase):
        for item in tc.xml.findall("error"):
            item.tag = "failure"

    report.foreach_testcase(callback)


def _remove_tests(report: JUnitTestSuites, tests_to_remove_list: List[str]):
    tests_to_remove = dict()

    for test in tests_to_remove_list:
        tests_to_remove[test] = True

    for_remove = []  # type: List[JUnitTestSuites.TestCase]
    def clear_by_name(tc: JUnitTestSuites.TestCase):
        if tc.fullname in tests_to_remove:
            for_remove.append(tc)
            del tests_to_remove[tc.fullname]

    report.foreach_testcase(clear_by_name)
    for tc in for_remove:
        tc.remove_from_suite()

    assert tests_to_remove == {}


def _append_unexisted_tests(report: JUnitTestSuites, full_test_list: List[str]):
    tests_to_append = set(full_test_list)

    def remove_test(tc: JUnitTestSuites.TestCase):
        tests_to_append.remove(tc.fullname)

    report.foreach_testcase(remove_test)

    tests_to_append_list = list(tests_to_append)
    tests_to_append_list.sort()

    suite = JUnitTestSuites.TestSuite.create()
    suite_is_empty = True
    for test_fullname in tests_to_append_list:
        suite_is_empty = False
        tc = JUnitTestSuites.TestCase.create_from_fullname(
            test_fullname,
            error_tag="failure",
            error_message="the test not started",
        )
        suite.append_testcase(tc)

    if not suite_is_empty:
        report.test_suites.append(suite)


def _read_file_lines(path: str) -> List[str]:
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


def _check_test_list_equals(report: JUnitTestSuites, test_list: List[str]):
    test_list_sorted = copy.copy(test_list)
    test_list_sorted.sort()

    report_tests = get_test_names(report, False, False)
    report_tests.sort()

    assert test_list_sorted == report_tests


def _order_attributes(report: JUnitTestSuites):
    def order(tc: JUnitTestSuites.TestCase):
        attrib = copy.copy(tc.xml.attrib)
        keys = list(attrib.keys())  # type: List[str]
        try:
            keys.remove("classname")
        except ValueError:
            pass

        try:
            keys.remove("name")
        except ValueError:
            pass

        keys.sort()
        new_attrib = OrderedDict()
        if "classname" in attrib:
            new_attrib["classname"] = attrib["classname"]
        if "name" in attrib:
            new_attrib["name"] = attrib["name"]

        for key in keys:
            new_attrib[key] = attrib[key]

        tc.xml.attrib = new_attrib

    report.foreach_testcase(order)


def process_report(
        report: JUnitTestSuites,
        config: Config,
        *,
        unit_tests: Optional[List[str]],
        full_test_list: Optional[List[str]],
):
    if unit_tests is None:
        unit_tests = []

    if full_test_list is None:
        full_test_list = []

    if config.convert.change_error_to_failure:
        _change_error_to_failure(report)

    _append_unexisted_tests(report, full_test_list)

    reasons = get_skip_reasons(config)
    report.skip_tests(reasons)

    _check_test_list_equals(report, full_test_list)

    _remove_tests(report, unit_tests)

    _order_attributes(report)

def main():
    parser = ArgumentParser()
    parser.add_argument("--config", default=join(dirname(__file__), "config.yaml"))
    parser.add_argument("--test-dir", type=str)
    parser.add_argument("--input-reports", default="test-result/raw", help="relative to test-dir")
    parser.add_argument("--output-report", default="test-result/result.xml", help="relative to test-dir")
    parser.add_argument("--full-test-list", default="full-test-list.txt", help="relative to test-dir")
    parser.add_argument("--list-unit-test", default="unit-tests.txt", help="relative to test-dir")
    args = parser.parse_args()

    config = Config()
    if args.config:
        with open(args.config, "rb") as f:
            data = f.read()
        config = Config.from_yaml(data)

    def normalize_path(test_dir: str, path: str) -> str:
        if os.path.isabs(path):
           return path
        return join(test_dir, path)

    report = load_report(normalize_path(args.test_dir, args.input_reports))

    unit_tests = []
    if args.list_unit_test:
        unit_tests = _read_file_lines(normalize_path(args.test_dir, args.list_unit_test))

    full_test_list = []
    if args.full_test_list:
        full_test_list = _read_file_lines(normalize_path(args.test_dir, args.full_test_list))

    process_report(report, config, unit_tests=unit_tests, full_test_list=full_test_list)

    report.save_to_file(normalize_path(args.test_dir, args.output_report))


if __name__ == '__main__':
    main()
