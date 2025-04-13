#!/usr/bin/env python3

import xml.etree.ElementTree as ET

tree = ET.parse("/usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml")

root = tree.getroot()

schema = root.find("schema")
for key in schema.findall("key"):
    if key.attrib["name"] == "scaling-factor":
        subelement = key.find("default")
        subelement.text = "2"
        break

tree.write("/usr/share/glib-2.0/schemas/org.gnome.desktop.interface.gschema.xml")
