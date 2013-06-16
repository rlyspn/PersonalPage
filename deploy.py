#!/usr/bin/python

import os, re, shutil
import subprocess as sp

assets = "assets"
pages = "pages"
site = "site"
pd = ["pandoc","--from=markdown", "--to=html", "--css=assets/css/style.css"]

def handle_assets():
    dest = os.path.join(site, assets)
    print "Copying %s to %s." % (assets, site)
    shutil.copytree(assets, dest)

def prepare_site():
    if (os.path.isdir(site)):
        shutil.rmtree(site)
        print "Removing %s." % site
    handle_assets()

def render_page(src, dest):
    print "rendering %s -> %s" % (src, dest)
    dst_dir = os.path.dirname(dest)
    if not os.path.exists(dst_dir):
        os.mkdir(dst_dir)
    out_file = open(dest, 'w+')
    sp.call(pd + [src], stdout=out_file)


def get_dst(src):
    ret = re.sub('^pages', site, src)
    ret = re.sub('md$', 'html', ret)
    return ret

def walk_pages():
    target = site
    for root, dirs, files in os.walk('pages'):
        for f in files:
            src = os.path.join(root, f)
            dest = get_dst(src)
            if dest:
                render_page(src, dest)

prepare_site()
walk_pages()
