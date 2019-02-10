namespace Quantum.Bell
{
    open Microsoft.Quantum.Primitive;
    open Microsoft.Quantum.Canon;
    
    //if qubit doesn't equal desired value, then make it desired value.
	operation Set ( desired: Result, q1: Qubit ) : Unit { //returns Unit, which is similar to returning Void
        let current = M(q1); //M() is measure
				
		if(desired != current)
		{
			X(q1); //X() applies a state flip around the x axis (whatever that means)
		}
    }

	operation BellTest (count: Int, initial: Result) : (Int, Int, Int)
	{
		mutable numOnes = 0;		
		mutable agree = 0;
		using(qubits = Qubit[2])
		{
			for(test in 1..count)
			{
				Set (initial, qubits[0]); //set first qubit to passed in value
				Set (Zero, qubits[1]); //set other qubit to zero
				
				//Hadamard + CNOT seems like that machine from the MS video that makes a quantum operation reversible 
				//(or something like that, I don't remember all the terminology)
				H(qubits[0]); //Hadamard gate ("1/2 flip") instead of a straight flip.  SUPA-POSITION!
				CNOT(qubits[0], qubits[1]);
				let res = M(qubits[0]); 

				if(M(qubits[1]) == res) //if qubits[0] and qubits[1] match
				{
					set agree = agree + 1; 
				}

				// Count the number of ones we saw:
				if(res == One)
				{
					set numOnes = numOnes + 1;
				}
			}
			Set(Zero, qubits[0]);
			Set(Zero, qubits[1]);
		}

		// Return number of times we saw a |0> and number of times we saw a |1>
		return (count - numOnes, numOnes, agree); 
	}
}