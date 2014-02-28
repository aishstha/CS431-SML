(* CS431, John Pease, Homework 5 *)

(* Problem 1: takes list and returns boolean of whether or not x is in that list *)
(* usage: is_member [1,2,3,4,5] 4 *)
fun is_member L x = foldr (fn (i,c) => if i=x then true else c) false L;

(* Problem 2: Write a function splitter than takes a string sentence and returns a list of words in the sentence *)
(*usage: splitter("hello there, are you lost?") *)
fun splitter "" = []
|	splitter (x:string) =
		let fun helper(x:char) =
			 if x = #" " orelse x = #"," orelse x = #"." orelse x = #";" orelse x = #"?" orelse x = #":" orelse x = #"\t" orelse x = #"\n" then
				true
			else
				false
		in String.tokens helper x
		end;

val stop_words = "a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,hers,him,his,how,however,i,if,in,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,neither,no,nor,not,of,off,often,on,only,or,other,our,own,rather,said,say,says,she,should,since,so,1some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,where,which,while,who,whom,why,will,with,would,yet,you,your";
(* Problem 3: takes a string and returns a list of booleans indicating whether the word is in stop_words *)
(* usage: is_stop_word("hello there, are you lost?") *)
fun is_stop_word "" = []
|	is_stop_word(sentence:string) =
		let fun helper([], L) = L
			|	helper(x::xs, L) =
					if (is_member (splitter(stop_words)) x) then
						helper(xs, L@(true::[]))
					else
						helper(xs, L@(false::[]))
		in helper(splitter(sentence), [])
		end;


(* Problem 4: takes a string sentence and returns the list of unique stop words *)
(* usage: get_stop_words("hello there, how are you doing there?") *)
fun get_stop_words sentence = foldr (fn (i,c) => if (hd (is_stop_word(i))) andalso not (is_member c i) then i::c else c) [] (splitter(sentence));

(* Problem 5: take a string sentence return a list of words with the stop words removed *)
(* usage: remove_stop_words("hello there, are you lost?") *)
fun remove_stop_words sentence = foldr (fn (i,c) => if (hd (is_stop_word(i))) andalso not (is_member c i) then c else i::c) [] (splitter(sentence));
