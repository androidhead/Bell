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

	operation BellTest (count: Int, initial: Result) : (Int, Int)
	{
		mutable numOnes = 0;		
		using(qubit = Qubit())
		{
			for(test in 1..count)
			{
				Set (initial, qubit); //set qubit to passed in value

				X(qubit); //flip right before measuring
				let res = M(qubit); 

				// Count the number of ones we saw:
				if(res == One)
				{
					set numOnes = numOnes + 1;
				}
			}
			Set(Zero, qubit);
		}

		// Return number of times we saw a |0> and number of times we saw a |1>
		return (count-numOnes, numOnes); //count-numOnes?  that is some weird syntax
	}
}