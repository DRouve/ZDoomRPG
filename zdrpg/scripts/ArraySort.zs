struct ArraySort
{
    //*************************************************************************
    //
    //    SHUFFLE FUNCTIONS
    //
    // This group of functions is for shuffling an array, the opposite of
    // sorting an array
    //
    //*************************************************************************

    // takes a list of doubles and reverses the order
    static void ReverseDouble(array<double> ValueList)
    {
        int iMax = ValueList.size() - 1;
        int iHalf = ValueList.size() / 2;
        for (int i = 0; i < iHalf; i++)
        {
            SwapDouble(ValueList, i, iMax - i );
        }
    }

    // takes a list of ints and reverses the order
    static void ReverseInt(array<int> ValueList)
    {
        int iMax = ValueList.size() - 1;
        int iHalf = ValueList.size() / 2;
        for (int i = 0; i < iHalf; i++)
        {
            SwapInt(ValueList, i, iMax - i );
        }
    }

    // takes a list of strings and reverses the order
    static void ReverseString(array<string> ValueList)
    {
        int iMax = ValueList.size() - 1;
        int iHalf = ValueList.size() / 2;
        for (int i = 0; i < iHalf; i++)
        {
            SwapString(ValueList, i, iMax - i );
        }
    }

    // takes a list of doubles and shuffles them
    static void ShuffleDouble(array<double> ValueList)
    {
        for (int i = 0; i < ValueList.size(); i++)
        {
            SwapDouble(ValueList, i, random(0, ValueList.size() - 1) );
        }
    }

    // takes a list of ints and shuffles them
    static void ShuffleInt(array<int> ValueList)
    {
        for (int i = 0; i < ValueList.size(); i++)
        {
            SwapInt(ValueList, i, random(0, ValueList.size() - 1) );
        }
    }

    // takes a list of strings and shuffles them
    static void ShuffleString(array<string> ValueList)
    {
        for (int i = 0; i < ValueList.size(); i++)
        {
            SwapString(ValueList, i, random(0, ValueList.size() - 1) );
        }
    }

    //makes a shuffled list of ints with specified values
    static void MakeShuffledInt(array<int> ValueList, int StartValue, int StopValue, int StepValue = 1)
    {
        if (!ValueList) return;
        
        ValueList.clear();
        
        // avoid infinite loops
        if ((StartValue == StopValue) || (StepValue == 0) || (StartValue < StopValue ? StepValue < 0 : StepValue > 0))
        {
            ValueList.push(StartValue);
            return;
        }

        //make a list of ints
        int v = StartValue;
        if (StepValue > 0)
        {
            while (v <= StopValue)
            {
                ValueList.push(v);
                v+=StepValue;
            }
        }
        else
        {
            while (v >= StopValue)
            {
                ValueList.push(v);
                v+=StepValue;
            }
        }
        
        //shuffle the list
        ShuffleInt(ValueList);
    }

    //makes a shuffled list of doubles with specified values
    static void MakeShuffledDouble(array<double> ValueList, double StartValue, double StopValue, double StepValue = 1.0)
    {
        if (!ValueList) return;
        
        ValueList.clear();
        
        // avoid infinite loops
        if ((StartValue == StopValue) || (StepValue == 0) || (StartValue < StopValue ? StepValue < 0 : StepValue > 0))
        {
            ValueList.push(StartValue);
            return;
        }

        //make a list of doubles
        double v = StartValue;
        if (StepValue > 0)
        {
            while (v <= StopValue)
            {
                ValueList.push(v);
                v+=StepValue;
            }
        }
        else
        {
            while (v >= StopValue)
            {
                ValueList.push(v);
                v+=StepValue;
            }
        }
        
        //shuffle the list
        ShuffleDouble(ValueList);
    }

    //*************************************************************************
    //
    //    SORT FUNCTIONS
    //
    // This group of functions is for sorting an array
    //
    //*************************************************************************

    // Pass this function an array of doubles and it will return that array
    // sorted alongside an array of original indices
    //
    //    on entry:
    //        ValueList: a list of doubles to to be sorted in ascending order
    //        IndexList: contents not important, will be cleared
    //    on exit:
    //        ValueList: a list of doubles sorted in ascending order
    //        IndexList: a list of indices pointing to locations in the original
    //            unsorted list
    static void SortDouble(array<double> ValueList, array<int> IndexList = null)
    {
        if (!ValueList) return;
        if (IndexList)
        {
            //make a list of indices, same size as the list of values
            IndexList.clear();
            IndexList.reserve(ValueList.size());
            for (int i = 0; i < ValueList.size(); i++)
            {
                //IndexList.push(i);
                IndexList[i]=i;
            }
            
            //quicksort the values and indices lists silmultaneously
            QuickSortDoubleIndex(ValueList, IndexList, 0, ValueList.size() - 1);
        }
        else
        {
            QuickSortDouble(ValueList, 0, ValueList.size() - 1);
        }
    }
    
    // Similar to above, except for a list of int values
    static void SortInt(array<int> ValueList, array<int> IndexList = null)
    {
        if (!ValueList) return;
        if (IndexList)
        {
            //make a list of indices, same size as the list of values
            IndexList.clear();
            IndexList.reserve(ValueList.size());
            for (int i = 0; i < ValueList.size(); i++)
            {
                //IndexList.push(i);
                IndexList[i]=i;
            }
            
            //quicksort the values and indices lists silmultaneously
            QuickSortIntIndex(ValueList, IndexList, 0, ValueList.size() - 1);
        }
        else
        {
            QuickSortInt(ValueList, 0, ValueList.size() - 1);
        }
    }
    
    // Similar to above, except for a list of int values
    static void SortString(array<string> ValueList, array<int> IndexList = null)
    {
        if (!ValueList) return;
        if (IndexList)
        {
            //make a list of indices, same size as the list of values
            IndexList.clear();
            IndexList.reserve(ValueList.size());
            for (int i = 0; i < ValueList.size(); i++)
            {
                //IndexList.push(i);
                IndexList[i]=i;
            }
            
            //quicksort the values and indices lists silmultaneously
            QuickSortStringIndex(ValueList, IndexList, 0, ValueList.size() - 1);
        }
        else
        {
            QuickSortString(ValueList, 0, ValueList.size() - 1);
        }
    }
    
    // Pass this function a list of actors and a reference point, it will sort
    // that list by their distance to the referencepoint.
    // Null entries in the list will be eliminated
    static void SortActorsByDistanceToPoint(array<actor> ActorList, vector3 ReferencePoint)
    {
        //create working lists
        array<double> ValueList;
        array<int> IndexList;
        
        //populate working lists
        for (int i = 0; i < ActorList.size(); i++)
        {
            if (ActorList[i])
            {
                ValueList.push( (ActorList[i].pos - ReferencePoint).length() );
                IndexList.push(i);
            }
        }

        //sort working lists
        QuickSortDoubleIndex(ValueList, IndexList, 0, ValueList.size() - 1);

        //create sorted list from original list and index list
        array<actor> ActorListSorted;
        For (Int i = 0; i < ValueList.size(); i++)
        {
            ActorListSorted.Push(ActorList[IndexList[i]]);
        }

        //replace original list with sorted list
        ActorList.move(ActorListSorted);
    }
    
    // Create a list of actors matching TID, then sort them by distance to the
    // ReferencePoint.
    static void SortTIDActorsByDistanceToPoint(int tid, vector3 ReferencePoint, array<actor> ActorList)
    {
        ActorList.clear();
        
        ActorIterator ai = level.CreateActorIterator(tid);
        actor mo;
        while (mo = ai.next())
        {
            ActorList.push(mo);
        }

        SortActorsByDistanceToPoint(ActorList, ReferencePoint);
    }
    
    //*************************************************************************
    //
    //    PRINT FUNCTIONS
    //
    // This group of functions is for printing an array, mostly for testing and
    // debug purposes.
    //
    //*************************************************************************

    static void PrintArrayDouble(array<double> ValueList, string Title = "ArrayDouble")
    {
        if (!ValueList)
        {
            console.printf(Title.." is null");
            return;
        }
        
        if (ValueList.size() == 1)
        {
            console.printf(Title.." has 1 element");
        }
        else
        {
            console.printf(Title.." has "..ValueList.size().." elements");
        }
        
        for (int i = 0; i < ValueList.size(); i++)
        {
            console.printf(Title.."["..i.."]="..ValueList[i]);
        }
    }

    static void PrintArrayInt(array<int> ValueList, string Title = "ArrayInt")
    {
        if (!ValueList)
        {
            console.printf(Title.." is null");
            return;
        }
        
        if (ValueList.size() == 1)
        {
            console.printf(Title.." has 1 element");
        }
        else
        {
            console.printf(Title.." has "..ValueList.size().." elements");
        }
        
        for (int i = 0; i < ValueList.size(); i++)
        {
            console.printf(Title.."["..i.."]="..ValueList[i]);
        }
    }

    static void PrintArrayString(array<string> ValueList, string Title = "string")
    {
        if (!ValueList)
        {
            console.printf(Title.." is null");
            return;
        }
        
        if (ValueList.size() == 1)
        {
            console.printf(Title.." has 1 element");
        }
        else
        {
            console.printf(Title.." has "..ValueList.size().." elements");
        }
        
        for (int i = 0; i < ValueList.size(); i++)
        {
            console.printf(Title.."["..i.."]="..ValueList[i]);
        }
    }

    //*************************************************************************
    //
    //    WORKER FUNCTIONS
    //
    // Functions below this line are for internal use. You won't need to call
    // them directly unless you are doing something specific and you know what
    // you're doing.
    //
    //*************************************************************************

    static void SwapDouble(array<double> ValueList, int index1, int index2)
    {
        double temp=ValueList[index1];
        ValueList[index1]=ValueList[index2];
        ValueList[index2]=temp;
    }

    static void SwapInt(array<int> ValueList, int index1, int index2)
    {
        int temp=ValueList[index1];
        ValueList[index1]=ValueList[index2];
        ValueList[index2]=temp;
    }

    static void SwapString(array<string> ValueList, int index1, int index2)
    {
        string temp=ValueList[index1];
        ValueList[index1]=ValueList[index2];
        ValueList[index2]=temp;
    }

    static void QuickSortDouble(array<double> ValueList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionDouble(ValueList, low, high);
            QuickSortDouble(ValueList, low, pi - 1);
            QuickSortDouble(ValueList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionDouble(array<double> ValueList, int low, int high)
    {
        double pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapDouble(ValueList, i, j);
            }
         }
        SwapDouble(ValueList, i + 1, high);
        return (i + 1);
    }
    
    static void QuickSortDoubleIndex(array<double> ValueList, array<int> IndexList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionDoubleIndex(ValueList, IndexList, low, high);
            QuickSortDoubleIndex(ValueList, IndexList, low, pi - 1);
            QuickSortDoubleIndex(ValueList, IndexList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionDoubleIndex(array<double> ValueList, array<int> IndexList, int low, int high)
    {
        double pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapDouble(ValueList, i, j);
                SwapInt(IndexList, i, j);
            }
         }
        SwapDouble(ValueList, i + 1, high);
        SwapInt(IndexList, i + 1, high);
        return (i + 1);
    }
    
    static void QuickSortInt(array<int> ValueList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionInt(ValueList, low, high);
            QuickSortInt(ValueList, low, pi - 1);
            QuickSortInt(ValueList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionInt(array<int> ValueList, int low, int high)
    {
        int pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapInt(ValueList, i, j);
            }
         }
        SwapInt(ValueList, i + 1, high);
        return (i + 1);
    }
    
    static void QuickSortIntIndex(array<int> ValueList, array<int> IndexList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionIntIndex(ValueList, IndexList, low, high);
            QuickSortIntIndex(ValueList, IndexList, low, pi - 1);
            QuickSortIntIndex(ValueList, IndexList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionIntIndex(array<int> ValueList, array<int> IndexList, int low, int high)
    {
        int pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapInt(ValueList, i, j);
                SwapInt(IndexList, i, j);
            }
         }
        SwapInt(ValueList, i + 1, high);
        SwapInt(IndexList, i + 1, high);
        return (i + 1);
    }
    
    static void QuickSortString(array<string> ValueList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionString(ValueList, low, high);
            QuickSortString(ValueList, low, pi - 1);
            QuickSortString(ValueList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionString(array<string> ValueList, int low, int high)
    {
        string pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapString(ValueList, i, j);
            }
         }
        SwapString(ValueList, i + 1, high);
        return (i + 1);
    }
    
    static void QuickSortStringIndex(array<string> ValueList, array<int> IndexList, int low, int high)
    {
        if (low < high) {
            int pi = QuickSortPartitionStringIndex(ValueList, IndexList, low, high);
            QuickSortStringIndex(ValueList, IndexList, low, pi - 1);
            QuickSortStringIndex(ValueList, IndexList, pi + 1, high);
        }
    }
    
    static int QuickSortPartitionStringIndex(array<string> ValueList, array<int> IndexList, int low, int high)
    {
        string pivot = ValueList[high];

        int i = (low - 1);

        for (int j = low; j <= high- 1; j++)
        {
            if (ValueList[j] < pivot)
            {
                i++;
                SwapString(ValueList, i, j);
                SwapInt(IndexList, i, j);
            }
         }
        SwapString(ValueList, i + 1, high);
        SwapInt(IndexList, i + 1, high);
        return (i + 1);
    }
    
}
