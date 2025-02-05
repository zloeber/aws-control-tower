#!/usr/bin/env python
# -*- coding: utf-8 -*-

from diagrams import Diagram
from diagrams.aws.management import ControlTower, Organizations, OrganizationsAccount, OrganizationsOrganizationalUnit

with Diagram("Centralized AWS Control Tower", outformat="jpg"):
  tower = ControlTower("Control Tower")
  org = Organizations("AWS Organizations")
  org_accounts = []
  org >> OrganizationsOrganizationalUnit("Sandbox")
  org >> OrganizationsOrganizationalUnit("infrastructure")
  org >> OrganizationsOrganizationalUnit("Security")

  for i in range(5):
      org_acct = OrganizationsAccount(f"Account {i+1}")
      org_accounts.append(org_acct)

  tower >> org
  for acct in org_accounts:
      org >> acct
