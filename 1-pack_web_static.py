#!/usr/bin/python3
""" Uses fabrinc to pack contents of web_static in a .tgz file """

from datetime import datetime
from fabric.api import local

def do_pack():
    now = datetime.now()
    tar_name = "versions/web_static_{}{}{}{}{}{}.tgz".format(
                now.year,
                now.month,
                now.day,
                now.hour,
                now.minute,
                now.second
            )
    if local("mkdir versions" ).failed:
        pass
    
    local("tar -cvzf {} web_static".format(tar_name))
    return tar_name
