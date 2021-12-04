import argparse
import matlab.engine
import re
import sys

parser = argparse.ArgumentParser(description='MATLAB command line / REPL interface for Windows.')
parser.add_argument("--orgbabel", action='store_true')
args, unknown = parser.parse_known_args()

eng = matlab.engine.connect_matlab()

if args.orgbabel:
    try:
        mlcommand = sys.stdin.read() # read until EOF
        print(eng.evalc(mlcommand, nargout=1))
    except (matlab.engine.MatlabExecutionError,
                matlab.engine.RejectedExecutionError,
                SyntaxError) as e:
            print(e)
else:
    print("MATLAB-engine REPL")
    print(f"Connected to MATLAB process {eng.matlab.engine.engineName()}")
    while True:
        try:
            mlcommand = input(">> ")
            if re.match(r"(exit|quit);?", mlcommand):
                raise KeyboardInterrupt
            print(eng.evalc(mlcommand, nargout=1))
        except (matlab.engine.MatlabExecutionError,
                matlab.engine.RejectedExecutionError,
                SyntaxError) as e:
            pass
        except EOFError:
            break
        except KeyboardInterrupt:
            break
    
eng.quit()
