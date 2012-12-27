using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Diagnostics;
using System.Drawing;

namespace ConsoleApplication1
{
    class Program
    {
        static bool IsPrime(int n)
        {
            if ((n & 1) == 0)
            {
                if (n == 2)
                {
                    return true;
                }
                else
                {
                    return false;
                }
            }
            for (int i = 3; (i * i) <= n; i += 2)
            {
                if ((n % i) == 0)
                {
                    return false;
                }
            }
            return n != 1;
        }

        static bool IsPair(int x, int y)
        {
            string xs = x.ToString();
            string ys = y.ToString();
            if (IsPrime(Int32.Parse(xs + ys)) && IsPrime(Int32.Parse(ys + xs)))
                return true;
            return false;
        }

        static List<int> Prime(int upto)
        {
            List<int> primes = new List<int>();
            primes.Add(2);
            for (int n = 3; n < upto; n+=2 )
            {
                if (IsPrime(n))
                    primes.Add(n);
            }
            return primes;
        }

        static void PrimeSet(int n, List<int> primes)
        {
            if (n == 1)
            {
            }
        }

        static string problem60()
        {
            List<int> primes = Prime(20000);
            HashSet<Point> pairs = new HashSet<Point>();
            for (int i = 0; i < primes.Count; i++ )
            {
                for ( int j = 1 + 1; j < primes.Count; j++ )
                {
                    Point pair = new Point(primes[i], primes[j]);
                    if (IsPair(pair.X, pair.Y))
                        pairs.Add(pair);
                }
            }

            for (int a = 0; a < primes.Count; a++ )
            {
                int aa = primes[a];
                for (int b = a + 1; b < primes.Count; b++ )
                {
                    int bb = primes[b];
                    if (!pairs.Contains(new Point(aa,bb)))
                        continue;
                    for (int c = b + 1; c < primes.Count; c++ )
                    {
                        int cc = primes[c];
                        if (!pairs.Contains(new Point(aa, cc)))
                            continue;
                        if (!pairs.Contains(new Point(bb, cc)))
                            continue;
                        for (int d = c + 1; d < primes.Count; d++)
                        {
                            int dd = primes[d];
                            if (!pairs.Contains(new Point(aa, dd)))
                                continue;
                            if (!pairs.Contains(new Point(bb, dd)))
                                continue;
                            if (!pairs.Contains(new Point(cc, dd)))
                                continue;
                            for (int e = d + 1; e < primes.Count;e++ )
                            {
                                int ee = primes[e];
                                if (!pairs.Contains(new Point(aa, ee)))
                                    continue;
                                if (!pairs.Contains(new Point(bb, ee)))
                                    continue;
                                if (!pairs.Contains(new Point(cc, ee)))
                                    continue;
                                if (!pairs.Contains(new Point(dd, ee)))
                                    continue;
                                Console.Write(aa.ToString() + " ");
                                Console.Write(bb.ToString() + " ");
                                Console.Write(cc.ToString() + " ");
                                Console.Write(dd.ToString() + " ");
                                Console.Write(ee.ToString() + "\n");
                            }
                        }
                    }
                }
            }

            return pairs.ToString();
        }

        static void Main(string[] args)
        {
            string ret = problem60();

            Console.Write(ret);
            Console.Read();
            return;
        }
    }
}
