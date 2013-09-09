#!/usr/bin/python


#import re
#import ast
import yaml
#import itertools as it
import urllib2
#from xml.dom import minidom
from BeautifulSoup import BeautifulSoup

req = urllib2.urlopen('http://localhost:8080/view/my_view/api/xml')
#req = urllib2.urlopen('http://localhost:8080/job/my_test_job/api/json?pretty=true')

#print req.info()
res = req.read()
#res_dict = ast.literal_eval(res)
#res_dict = yaml.load(res)

print res
print "========================"

xml = BeautifulSoup(res)

xml_colors = xml.findAll("color")

colors = []
for color in xml_colors:
	print color




#xmldoc = minidom.parse(res)

#print xmldoc

#print res_dict['color']

#knights = {'gallahad': 'the pure', 'robin': 'the brave'}
#for k, v in knights.iteritems():
#	print k, v




#for line in res:
#	lhs, rhs = res.split(":")
#	print lhs
#	print rhs
#	if "color" in res:
#		print "color"
