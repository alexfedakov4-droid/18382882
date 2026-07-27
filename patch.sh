#!/usr/bin/env bash
set -e
L="$1"
python - "$L" <<'PY'
import sys,os,re
L=sys.argv[1]
def guard(path, mod):
    if not os.path.exists(path): return
    c=open(path).read()
    c=re.sub(r'(?m)^(\s*)import '+mod+r'\s*$',
             r'\1try: import '+mod+r'\n\1except Exception: pass', c)
    open(path,'w').write(c)
    print("guarded", mod, "in", path)
guard(os.path.join(L,'change_icon.py'),'pefile')
guard(os.path.join(L,'webserver.py'),'cgi')
PY
