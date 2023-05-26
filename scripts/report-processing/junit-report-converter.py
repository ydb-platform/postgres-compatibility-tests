from __future__ import annotations

import logging
from argparse import ArgumentParser
from dataclasses import dataclass, field
import os.path
from os.path import dirname, join
from typing import List, Dict, Callable, Iterable
from xml.etree.ElementTree import Element, ElementTree

from mashumaro.mixins.yaml import DataClassYAMLMixin

logger = logging.Logger("junit-reporter-converter")


@dataclass
class Config(DataClassYAMLMixin):
    tickets: List["Config.TestsByTicket"] = field(default_factory=lambda: [])

    @dataclass
    class TestsByTicket(DataClassYAMLMixin):
        name: str
        tests: List[str]


class JUnitTestSuites:
    test_suites: List["JUnitTestSuites.TestSuite"]

    class TestSuite:
        xml: Element

        def __init__(self, xml: Element):
            self.xml = xml

        @staticmethod
        def parse_xml(et: Element) -> JUnitTestSuites.TestSuite:
            return JUnitTestSuites.TestSuite(et)

    @dataclass
    class SetStatusReason:
        classname: str
        testname: str
        reason: str

        def fullname(self) -> str:
            return "%s/%s" % (self.classname, self.testname)

    def __init__(self):
        self.test_suites = []

    def _foreach_testcase(self, callback: Callable[[Element], None]):
        for suite in self.test_suites:
            for testcase in suite.xml.iter("testcase"):
                callback(testcase)

    @staticmethod
    def _skip_test(el: Element, reason: str):
        if JUnitTestSuites._test_fullname(el) == "":
            return

        classname = el.attrib["classname"]
        testname = el.attrib["name"]
        el.clear()
        el.attrib["classname"] = classname
        el.attrib["name"] = testname

        skipped = Element("skipped", {"message": reason})
        el.append(skipped)

    @staticmethod
    def _test_fullname(el: Element) -> str:
        classname = el.attrib["classname"] if "classname" in el.attrib else ""
        testname = el.attrib["name"] if "name" in el.attrib else ""

        if classname == "" and testname == "":
            return ""

        return "%s/%s" % (classname, testname)
    def merge_from_file(self, filepath: str):
        logger.info("import report from file: %s" % filepath)
        testsuites_xml = ElementTree()
        testsuites_xml.parse(filepath)
        for testsuite_xml in testsuites_xml.iter("testsuite"):
            testsuite = JUnitTestSuites.TestSuite.parse_xml(testsuite_xml)
            self.test_suites.append(testsuite)

    def save_to_file(self, filepath: str):
        root = Element("testsuites")
        for suite in self.test_suites:
            root.append(suite.xml)

        et = ElementTree(root)
        et.write(filepath)

    def skip_tests(self, skiplist: Iterable[JUnitTestSuites.SetStatusReason]):
        """
        :param tests: list of strings in format: "classname/testname"
        :return: None
        """
        skip_dict = {reason.fullname(): reason for reason in skiplist}  # type: Dict[str, JUnitTestSuites.SetStatusReason]

        def process_testcase(el: Element):
            fullname = self._test_fullname(el)
            if fullname in skip_dict:
                self._skip_test(el, skip_dict[fullname].reason)

        self._foreach_testcase(process_testcase)


def load_report(path: str):
    report = JUnitTestSuites()

    if os.path.isdir(path):
        for root, _, files in os.walk("."):
            for file in files:
                report.merge_from_file(join(root, file))
    else:
        report.merge_from_file(path)

    return report


def get_skip_reasons(config: Config) -> List[JUnitTestSuites.SetStatusReason]:
    res = []  # type: List[JUnitTestSuites.SetStatusReason]
    for ticket in config.tickets:
        for test in ticket.tests:
            classname, testname = test.split("/", 1)
            reason = JUnitTestSuites.SetStatusReason(
                classname=classname,
                testname=testname,
                reason=ticket.name,
            )
            res.append(reason)

    return res


def process_report(report: JUnitTestSuites, config: Config):
    reasons = get_skip_reasons(config)
    report.skip_tests(reasons)


def main():
    parser = ArgumentParser()
    parser.add_argument("--config", default=join(dirname(__file__), "config.yaml"))
    parser.add_argument("--input-reports", default="result-example.xml")
    parser.add_argument("--output-report", default="processed-example.xml")
    args = parser.parse_args()

    config = Config()
    if args.config:
        with open(args.config, "rb") as f:
            data = f.read()
        config = Config.from_yaml(data)

    report = load_report(args.input_reports)

    process_report(report, config)

    report.save_to_file(args.output_report)


if __name__ == '__main__':
    main()
