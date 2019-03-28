[LegacyColorValue = true];

    inputs:

    iStartTime (0800),

    ResetMinutes (60);


    vars:

        PriceW(0),

        ShareW(0),

        Count(0),

        VolWAPValue(0),

        VolWAPVariance(0),

        VolWAPSD(0);

        



    if mod( (TimeToMinutes(time)-TimeToMinutes(iStartTime) ), TimeToMinutes(ResetMinutes) ) = 0 then 

    begin

        PriceW = 0;

        ShareW = 0;

        Count = -1;

        Value1 = 0;

        Value2 = 0;

        VolWAPValue = 0;

    end;



    PriceW = PriceW + (AvgPrice * (UpTicks+DownTicks));

    ShareW = ShareW + (UpTicks+DownTicks);

    Count = Count + 1;

    Value3 = 0;



    if ShareW > 0 then VolWAPValue = PriceW / ShareW;



    {Calculate the individual variance terms for each intraday bar starting with the current

    bar and looping back through each bar to the start bar.  The terms are each normalized

    according to the Variance formula for each level of volume at each price bar            }



     For Value1 = 0 To Count Begin

        Value2 = ((UpTicks[Value1]+DownTicks[Value1])/ShareW) * (Square(AvgPrice[Value1]-VolWAPValue));

        Value3 = Value3 + Value2;

    End;



    VolWAPVariance = Value3;

    VolWAPSD = SquareRoot(VolWAPVariance);





    Plot1(VolWAPValue, "VWAP");

    Plot2(VolWAPValue + VolWAPSD, "VWAP1SDUp");

    Plot3(VolWAPValue - VolWAPSD, "VWAP1SDDown");

    Plot4(VolWAPValue + (2*VolWAPSD), "VWAP2SDUp");

    Plot5(VolWAPValue - (2*VolWAPSD), "VWAP2SDDown"); 

