
--CIS 3190 A2 Ada assignment

with
 ada.Text_IO;
use
 Ada.Text_IO;
with
 ada.Integer_Text_IO;
use
 Ada.Integer_Text_IO;
with
 ada.strings.unbounded;
use
 ada.strings.unbounded;
with
 ada.strings.unbounded.Text_IO;
use
 ada.strings.unbounded.Text_IO;
with
 ada.characters.handling;
use
 ada.characters.handling;


procedure a2 is
    -- in: none.
    -- out: unbounded string.
    -- post: get user input.
    function inputJumble return Ada.Strings.Unbounded.Unbounded_String is
        S : Ada.Strings.Unbounded.Unbounded_String;
    begin
        Ada.Text_IO.Put("Enter a string: ");
        S := Ada.Strings.Unbounded.To_Unbounded_String(Ada.Text_IO.Get_Line);
        return S;
    end inputJumble;

    subtype line is unbounded_string;
    type read is array(1..51244) of line;
    -- in: none.
    -- out: array of string.
    -- post: build the dict once the program run.
    function buildLEXICON return read is
    read1: read;
    infp : file_type;
    i : integer := 1;
    begin
        open(infp, in_file, "/usr/share/dict/canadian-english-small");
        loop
            exit when end_of_file(infp);
            get_line (infp, read1(i));
            i := i + 1;
        end loop;
        close(infp);
        return read1;
    end buildLEXICON;

    count : integer := 1;
    procedure append(array2 : in out read; input1 :string) is
        temp1: unbounded_string;
    begin
        temp1 := To_Unbounded_String(input1);
        array2(count) := temp1;
        count := count+1;
    end append;

    procedure swap (c1: in out Character; c2: in out Character) is
        tempC: Character;
    begin
        tempC:= c1;
        c1:= c2;
        c2:= tempC;
    end swap;

    -- Based on the reference, I have converted the C code to Ada code.
    -- https://www.geeksforgeeks.org/write-a-c-program-to-print-all-permutations-of-a-given-string/
    counter : integer := 1;
    procedure permute (array1: in out read; input: in out string; a: integer; l: in out integer) is
        r: integer;
    begin
        r:= a;
        if a = l then
            counter := counter+1;
            append(array1, input);
        else
            for index in a .. l loop
                swap(input(a), input(index));
                permute(array1, input, r + 1, l);
                swap(input(a), input(index));
            end loop;
        end if;
    end permute;

    -- in: unbounded stirng.
    -- out: array of string.
    -- post: generate all anagrams of given word.
    function generateAnagram(input : unbounded_string) return read is
    length1 : integer := to_string(input)'Length;
    read3 : read;
    temp2 : string(1..length1);
    begin
        temp2 := to_string(input);
        permute(read3, temp2, 1, length1);
        return read3;
    end generateAnagram;

    -- in: array of string of dict and array of stirng of generated anagrams
    -- out: none
    -- post: print the matched words
    procedure findAnagram (array2: in out read; read5: in out read) is
    compare : unbounded_string;
    begin
        Put_line ("Here are words find in dict:");
        -- nested loop to match 2 arrays of string.
        for c in 1..counter loop
            for d in 1..51244 loop
                compare := to_Unbounded_String(Ada.Characters.Handling.To_Lower(to_string(array2(c))));
                if compare = read5(d) then
                    Ada.Text_IO.Put_Line(Ada.Strings.Unbounded.To_String(read5(d)));
                end if;
            end loop;
        end loop;
    end findAnagram;

userString : Ada.Strings.Unbounded.Unbounded_String;
choice : String(1..10);
endChoice : Natural;
read2: read;
read4: read;
begin
    read2 := buildLEXICON;
    loop
        userString := inputJumble;
        read4 := generateAnagram(userString);
        findAnagram(read4, read2);
        Put_Line ("Do you want to play one more? yes or no.");
        get_line(choice, endChoice);
        counter := 1;
        count := 1;
        -- the user can either type n or no.
        exit when choice(1..endChoice) = "no" or else choice(1) = 'n';
    end loop;
end a2;
