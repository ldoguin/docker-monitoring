#!/usr/bin/env python

import os
import sys

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "settings")

from django.contrib.auth.models import User

if len(sys.argv) == 3:
    username = sys.argv[1]
    password = sys.argv[2]
else:
    username = "admin"
    password = "graphite"

print("Creating/Updating admin account: {0}/{1}".format(username, password))

u, created = User.objects.get_or_create(username=username)
if created:
    u.set_password(password)
    u.is_superuser = True
    u.is_staff = True
    u.save()
