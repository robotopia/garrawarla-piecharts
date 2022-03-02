#!/usr/bin/awk -f

BEGIN     { FS = ","; LIMIT = 810 }
$3 ~ /file|dir|symlink/ {
            split($5,size," ")
            if      (size[2] ~ /KB/) { scale = 2**10 }
            else if (size[2] ~ /MB/) { scale = 2**20 }
            else if (size[2] ~ /GB/) { scale = 2**30 }
            else if (size[2] ~ /TB/) { scale = 2**40 }
            else                     { scale = 1     }

            gsub(/ /, "", $2);
            person[$2]      += size[1]*scale
          }
END       {
            for (name in person)
            {
                print name, person[name]/2**40
                total += person[name]/2**40
            }
            print "unused",     LIMIT - total
            print "# assumed total", LIMIT
          }
