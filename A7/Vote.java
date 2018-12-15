import java.io.*;
import java.util.stream.*;
import java.util.*;
import java.lang.*;


public class Vote{

  public static void main(String[] args) throws IOException {
    Stream<String> lines = new BufferedReader(new FileReader("voterdata.csv")).lines();
    Tuple<Integer,Integer> result =
      lines
         .parallel()
         .map(l -> l.split(";"))
         .map(l -> tupleMap(l))
         .reduce(new Tuple <Integer,Integer> (0,0), Vote::reduceTuple);
     System.out.println("Democratic votes:  " + result.fst.toString());
     System.out.println("Republican votes: " + result.snd.toString());
     // Democratic votes: 2895541
     // Republican votes: 2039818
  }
  public static Tuple<Integer,Integer> reduceTuple (Tuple<Integer,Integer> a, Tuple<Integer,Integer> b){
    return new Tuple<Integer,Integer> ((a.fst + b.fst) , (a.snd + b.snd)); // help from Lizzy
  }

  public static Tuple<Integer,Integer> tupleMap (String[] streamLine) {
    Tuple<Integer,Integer> returnTuple;
    String voteParty = streamLine[4];

    if (voteParty.equals("Democratic") && streamLine[2].equals("Governor")){
        return returnTuple = new Tuple<>(Integer.parseInt(streamLine[6]),0);
    } else if (voteParty.equals("Republican") && streamLine[2].equals("Governor")){
        return returnTuple = new Tuple<>(0,Integer.parseInt(streamLine[6]));
    } else{
        return returnTuple = new Tuple<>(0,0);
    }

  }

}
