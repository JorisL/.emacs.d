import matlab.engine
import re
import sys

print("MATLAB-engine REPL")
eng = matlab.engine.connect_matlab()
print(f"Connected to MATLAB process {eng.matlab.engine.engineName()}")

while True:
    try:
        # print(">> ", end="")
        # content = []
        # while True:
        #     line = input()
        #     if line:
        #         content.append(line)
        #     else:
        #         break
        # mlcommand = '\n'.join(content)
        mlcommand = input(">> ")
        if re.match(r"(exit|quit);?", mlcommand):
            raise KeyboardInterrupt
        print(eng.evalc(mlcommand, nargout=1))
    except (matlab.engine.MatlabExecutionError,
            matlab.engine.RejectedExecutionError,
            SyntaxError) as e:
        pass
    except KeyboardInterrupt:
        break
    
eng.quit()
