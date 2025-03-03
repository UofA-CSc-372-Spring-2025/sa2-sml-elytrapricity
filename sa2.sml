(* Solutions to SA2 assignment, Intro to ML *)

(* Name: Alex Salgado                                        *)
(* Time spent on HW6: <= 9hr inlcuding most reading/research *)

(* Collaborators and references: Chapters 2-3 in ML for the Working Programmer,
  Lecture on Folding, Google for SML examples, Copilot, ChatGPT
*)

(* indicate planning to use the Unit testing module *)
use "Unit.sml";



(**** Problem A ****)
fun mynull []       = true
  | mynull (_::_)   = false;

val () =
    Unit.checkExpectWith Bool.toString "mynull [] should be true"
    (fn () => mynull [])
    true

val () =
    Unit.checkExpectWith Bool.toString "mynull [] should be false"
    (fn () => mynull ["a"])
    false



(**** Problem B ****)
fun firstVowel (#"a"::_) = true
  | firstVowel (#"e"::_) = true
  | firstVowel (#"i"::_) = true
  | firstVowel (#"o"::_) = true
  | firstVowel (#"u"::_) = true
  | firstVowel (#"A"::_) = true
  | firstVowel (#"E"::_) = true
  | firstVowel (#"I"::_) = true
  | firstVowel (#"O"::_) = true
  | firstVowel (#"U"::_) = true
  | firstVowel _         = false;

val () =
    Unit.checkExpectWith Bool.toString "firstVowel 'ack' should be true"
    (fn () => firstVowel [#"a",#"c",#"k"])
    true

val () =
    Unit.checkExpectWith Bool.toString "firstVowel 'Car' should be false"
    (fn () => firstVowel [#"C",#"a",#"r"])
    false



(**** Problem C ****)
fun reverse (l:'a list): 'a list = foldl (fn (x, acc) => x::acc) [] l;

val () =
  Unit.checkExpectWith (Unit.listString Int.toString) 
  "reverse [1,2] should be [2,1]"
  (fn () => reverse [1,2])
  [2,1]



(**** Problem D ****)
exception EmptyList

fun minlist [] = raise EmptyList
  | minlist (x::xs) = foldl Int.min x xs;

val () =
  Unit.checkExnWith Int.toString
  "minlist [] should raise an exception"
  (fn () => minlist [])

val () =
  Unit.checkExpectWith Int.toString
  "minlist [1,2,3,4,0] should be 0"
  (fn () => minlist [1,2,3,4,0])
  0



(**** Problem E ****)
exception Mismatch

fun zip ([], []) = []
  | zip ([], _) = raise Mismatch
  | zip (_, []) = raise Mismatch
  | zip (x::xs, y::ys) = (x, y) :: zip (xs, ys);



(**** Problem F ****)
fun concat lists = foldl (fn (x, acc) => acc @ x) [] lists;



(**** Problem G ****)
fun isDigit #"0" = true
  | isDigit #"1" = true
  | isDigit #"2" = true
  | isDigit #"3" = true
  | isDigit #"4" = true
  | isDigit #"5" = true
  | isDigit #"6" = true
  | isDigit #"7" = true
  | isDigit #"8" = true
  | isDigit #"9" = true
  | isDigit _    = false;



(**** Problem H ****)
fun isAlpha c =
  let val ordC = Char.ord c
  in
    (ordC >= Char.ord #"a" andalso ordC <= Char.ord #"z") orelse
    (ordC >= Char.ord #"A" andalso ordC <= Char.ord #"Z")
  end;



(**** Problem I ****)
fun svgCircle (cx, cy, r, fill) = 
  "<circle cx=\"" ^ Int.toString cx ^
  "\" cy=\"" ^ Int.toString cy ^
  "\" r=\"" ^ Int.toString r ^
  "\" fill=\"" ^ fill ^
  "\" />";

val () =
  Unit.checkExpectWith (fn x => x)
  "svgCircle (200, 300, 100, \"red\") should return <circle cx=\"200\" cy=\"300\" r=\"100\" fill=\"red\" />"
  (fn () => svgCircle (200, 300, 100, "red"))
  "<circle cx=\"200\" cy=\"300\" r=\"100\" fill=\"red\" />";



(**** Problem J ****)
fun partition _ [] = ([], [])
  | partition p (x::xs) =
      let val (yes, no) = partition p xs
      in
        if p x then
          (x::yes, no)
        else
          (yes, x::no)
      end;

val () =
  Unit.checkExpectWith (fn (l1, l2) => "(" ^ Unit.listString Int.toString l1 ^ ", " ^ Unit.listString Int.toString l2 ^ ")")
  "partition (fn x => x mod 2 = 0) [1, 2, 3, 4, 5] should return ([2, 4], [1, 3, 5])"
  (fn () => partition (fn x => x mod 2 = 0) [1, 2, 3, 4, 5])
  ([2, 4], [1, 3, 5]);



(* Unit testing reporting *)

val () = Unit.report()
val () = Unit.reportWhenFailures ()  (* put me at the _end_ *)
