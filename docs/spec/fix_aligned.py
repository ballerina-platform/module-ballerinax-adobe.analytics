import json,sys,os
p=os.path.join(os.path.dirname(os.path.abspath(__file__)),'aligned_ballerina_openapi.json')
d=json.load(open(p))
d['servers']=[{'url':'https://analytics.adobe.io/api'}]
for path,v in d['paths'].items():
    for m,o in v.items():
        if not isinstance(o,dict): continue
        if not o.get('description'):
            o['description']=o.get('summary','').rstrip('.')+'.'
json.dump(d,open(p,'w'),indent=2)
# audit log usage: declared */* -> application/json so it binds to UsageLogPage
d=json.load(open(p))
r=d['paths']['/{globalCompanyId}/auditlogs/usage']['get']['responses']['200']['content']
if '*/*' in r: r['application/json']=r.pop('*/*')
json.dump(d,open(p,'w'),indent=2)
