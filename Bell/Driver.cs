using System;

using Microsoft.Quantum.Simulation.Core;
using Microsoft.Quantum.Simulation.Simulators;

namespace Quantum.Bell
{
    class Driver
    {
        static void Main(string[] args)
        {
            using (var qsim = new QuantumSimulator())
            {
                // Try initial values
                Result[] initials = new Result[] { Result.Zero, Result.One };
                foreach (Result initial in initials)
                {
                    var res = BellTest.Run(qsim, 1000, initial).Result;
                    var (numZeros, numOnes) = res;
                    Console.WriteLine(
                        $"Init:{initial,-4} 0s={numZeros,-4} 1s={numOnes,-4}");

                    //trying a better visualization
                    //Console.WriteLine(
                    //    $"Init      0s      1s");
                    //Console.WriteLine(
                    //    $"{(initial,-4).ToString().PadRight(10)}{(numZeros,-4).ToString().PadRight(8)}{(numOnes,-4)}");
                }
            }

            Console.WriteLine("Press any key to continue...");
            Console.ReadKey();
        }
    }
}