# DNS Performance Test

Shell script to test the performance of the most popular DNS resolvers from your location.

Includes by default:
 * CloudFlare 1.1.1.1
 * Level3 4.2.2.1
 * Google 8.8.8.8
 * Quad9 9.9.9.9
 * Freenom 80.80.80.80
 * OpenDNS
 * Norton
 * CleanBrowsing
 * Yandex
 * AdGuard
 * Neustar
 * Comodo

# Required 

You need to install bc and dig. For Ubuntu:

```
 $ sudo apt-get install bc dnsutils
```

# Utilization

``` 
 $ git clone --depth=1 https://github.com/cleanbrowsing/dnsperftest/
 $ cd dnsperftest
 $ bash ./dnstest.sh 
               test1   test2   test3   test4   test5   test6   test7   test8   test9   test10  Average 
cloudflare     1 ms    1 ms    1 ms    2 ms    1 ms    1 ms    1 ms    1 ms    1 ms    1 ms      1.10
google         22 ms   1 ms    4 ms    24 ms   1 ms    19 ms   3 ms    56 ms   21 ms   21 ms     17.20
quad9          10 ms   19 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   10 ms   55 ms     15.40
opendns        39 ms   2 ms    2 ms    20 ms   2 ms    72 ms   2 ms    39 ms   39 ms   3 ms      22.00
norton         2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    1 ms    2 ms    2 ms      1.80
cleanbrowsing  11 ms   14 ms   11 ms   11 ms   10 ms   10 ms   11 ms   36 ms   11 ms   13 ms     13.80
yandex         175 ms  209 ms  175 ms  181 ms  188 ms  179 ms  178 ms  179 ms  177 ms  208 ms    184.90
adguard        200 ms  200 ms  200 ms  199 ms  202 ms  200 ms  202 ms  200 ms  199 ms  248 ms    205.00
neustar        2 ms    2 ms    2 ms    2 ms    1 ms    2 ms    2 ms    2 ms    2 ms    2 ms      1.90
comodo         21 ms   22 ms   22 ms   22 ms   22 ms   22 ms   22 ms   21 ms   22 ms   24 ms     22.00
```

To sort with the fastest first, add `sort -k 20 -n` at the end of the command:

```
  $ bash ./dnstest.sh | sort -b -k 20 -n  # here 20 == ($totaldomains+1) * 2
                  GOOG    GHUB    STOF    YTUB    WIKI    TWTR    GMIL    WTAP    MTBM    Average
opendnsFamily-S1  38 ms   35 ms   35 ms   37 ms   34 ms   35 ms   34 ms   38 ms   34 ms     35.55
opendnsFamily-P1  37 ms   35 ms   35 ms   35 ms   36 ms   38 ms   35 ms   36 ms   35 ms     35.77
JIO-P1            37 ms   38 ms   51 ms   35 ms   36 ms   49 ms   45 ms   42 ms   36 ms     41.00
level3-S1         44 ms   40 ms   45 ms   43 ms   43 ms   44 ms   42 ms   43 ms   42 ms     42.88
level3-S4         44 ms   46 ms   43 ms   44 ms   43 ms   41 ms   43 ms   44 ms   42 ms     43.33
level3-S5         43 ms   43 ms   43 ms   44 ms   41 ms   45 ms   45 ms   45 ms   41 ms     43.33
level3-S2         43 ms   44 ms   43 ms   44 ms   44 ms   40 ms   43 ms   46 ms   44 ms     43.44
BellTele-P1       43 ms   48 ms   44 ms   56 ms   45 ms   46 ms   37 ms   36 ms   39 ms     43.77
Freenom-S1        42 ms   46 ms   43 ms   44 ms   43 ms   41 ms   51 ms   42 ms   43 ms     43.88
freenom-S1        43 ms   43 ms   44 ms   45 ms   40 ms   42 ms   45 ms   45 ms   50 ms     44.11
level3-S3         41 ms   57 ms   41 ms   42 ms   43 ms   46 ms   43 ms   43 ms   42 ms     44.22
opendns-S1        34 ms   33 ms   32 ms   32 ms   35 ms   36 ms   101 ms  39 ms   61 ms     44.77
level3-S6         43 ms   65 ms   43 ms   41 ms   43 ms   44 ms   45 ms   40 ms   41 ms     45.00
level3-P1         41 ms   44 ms   43 ms   45 ms   42 ms   47 ms   55 ms   45 ms   44 ms     45.11
google-S1         11 ms   48 ms   37 ms   35 ms   36 ms   34 ms   98 ms   36 ms   76 ms     45.66
norton-P1         47 ms   51 ms   50 ms   40 ms   46 ms   45 ms   55 ms   44 ms   42 ms     46.66
cloudflare-S1     37 ms   148 ms  36 ms   37 ms   36 ms   36 ms   39 ms   35 ms   37 ms     49.00
opendns-P1        35 ms   35 ms   36 ms   86 ms   37 ms   36 ms   84 ms   39 ms   60 ms     49.77
208.67.220.220    36 ms   124 ms  36 ms   37 ms   33 ms   36 ms   83 ms   35 ms   55 ms     52.77
level3-P2         46 ms   201 ms  45 ms   45 ms   47 ms   44 ms   46 ms   44 ms   46 ms     62.66
208.67.222.222    39 ms   38 ms   33 ms   33 ms   221 ms  37 ms   85 ms   37 ms   56 ms     64.33
google-P1         35 ms   17 ms   36 ms   35 ms   35 ms   36 ms   96 ms   35 ms   281 ms    67.33
Verisgn-S1        46 ms   41 ms   43 ms   40 ms   45 ms   44 ms   45 ms   122 ms  196 ms    69.11
Neustar-S1        41 ms   42 ms   42 ms   43 ms   42 ms   41 ms   111 ms  279 ms  44 ms     76.11
quad9-S1          40 ms   330 ms  43 ms   54 ms   56 ms   43 ms   44 ms   50 ms   43 ms     78.11
quad9-P1          46 ms   429 ms  44 ms   45 ms   49 ms   43 ms   43 ms   43 ms   136 ms    97.55
quad9-P2          42 ms   212 ms  46 ms   44 ms   44 ms   41 ms   45 ms   63 ms   403 ms    104.44
Freenom-P1        44 ms   222 ms  276 ms  43 ms   41 ms   41 ms   47 ms   48 ms   296 ms    117.55
quad9-S2          44 ms   215 ms  45 ms   52 ms   43 ms   44 ms   64 ms   54 ms   505 ms    118.44
Artech-P1         49 ms   54 ms   56 ms   47 ms   260 ms  42 ms   42 ms   484 ms  55 ms     121.00
French-P1         133 ms  152 ms  128 ms  128 ms  134 ms  135 ms  128 ms  130 ms  192 ms    140.00
Keweon-S1         146 ms  140 ms  138 ms  141 ms  140 ms  158 ms  148 ms  147 ms  139 ms    144.11
SafeDNS-S1        145 ms  149 ms  143 ms  145 ms  143 ms  151 ms  139 ms  141 ms  149 ms    145.00
8.8.4.4           36 ms   37 ms   36 ms   35 ms   35 ms   35 ms   38 ms   1000 ms 61 ms     145.88
```
# For Windows users using the Linux subsystem

If you receive an error `$'\r': command not found`, convert the file to a Linux-compatible line endings using:

    tr -d '\15\32' < dnstest.sh > dnstest-2.sh
    
Then run `bash ./dnstest-2.sh`
