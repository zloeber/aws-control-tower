#!/usr/bin/env python
# -*- coding: utf-8 -*-

from diagrams import Diagram
from diagrams.aws.management import ControlTower, Organizations, OrganizationsAccount

with Diagram("Decentralized AWS Subscriptions - Current", outformat="jpg"):
  org = Organizations("AWS Organizations")
  for i in range(5):
      org >> OrganizationsAccount(f"Account {i+1}")
