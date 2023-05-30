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
        tests: Dict[str, List[str]]  # Dict[class, testnames]


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
    class TestCase:
        xml: Element

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
            return len(self.xml.getchildren()) == 0

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
                callback(JUnitTestSuites.TestCase(xml=testcase))

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
        skip_dict = dict()  # type: Dict[str, JUnitTestSuites.SetStatusReason]
        for reason in skiplist:
            skiplist[reason.fullname] = reason

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
