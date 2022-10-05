import sys
import os
from base64 import standard_b64encode

def main(args):
    sys.stdout = open(os.ctermid(), 'w')
    #sys.stdout.buffer.write(b'\x1b[6;30;42mSuccess!\x1b[0m')
    #sys.stdout.flush()
    #with open(sys.argv[-1], 'rb') as f:
    with open('/Users/edluffy/Dropbox/Projects/hologram-test/small.png', 'rb') as f:
       write_chunked(a='T', f=100, data=f.read())

def handle_result(args, result, target_window_id, boss):
    w = boss.window_id_map.get(target_window_id)

#handle_result.no_ui = True

def serialize_gr_command(**cmd):
   payload = cmd.pop('payload', None)
   cmd = ','.join('{}={}'.format(k, v) for k, v in cmd.items())
   ans = []
   w = ans.append
   w(b'\033_G'), w(cmd.encode('ascii'))
   if payload:
      w(b';')
      w(payload)
   w(b'\033\\')
   return b''.join(ans)

def write_chunked(**cmd):
   data = standard_b64encode(cmd.pop('data'))
   while data:
      chunk, data = data[:4096], data[4096:]
      m = 1 if data else 0
      #sys.stdout.buffer.write(serialize_gr_command(payload=chunk, m=m, **cmd))
      print(serialize_gr_command(payload=chunk, m=m, **cmd))

      sys.stdout.flush()
      cmd.clear()

